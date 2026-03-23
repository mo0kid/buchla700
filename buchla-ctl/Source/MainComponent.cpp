#include "MainComponent.h"

MainComponent::MainComponent()
{
    // Set look and feel
    setLookAndFeel(&buchlaLookAndFeel);
    
    // Enable keyboard focus
    setWantsKeyboardFocus(true);
    
    // Create OSC controller
    oscController = std::make_unique<OSCController>();
    
    // Create main UI components
    touchKeyboard = std::make_unique<TouchKeyboard>();
    addAndMakeVisible(touchKeyboard.get());
    
    xyController = std::make_unique<TouchPad>();
    addAndMakeVisible(xyController.get());
    
    
    // Setup all control sections
    setupTopControls();
    setupFaderButtons();
    setupDataFaders();
    
    // Set callbacks for child components
    touchKeyboard->setKeyCallback([this](int key, float velocity, float yPosition) {
        oscController->sendKeyEvent(key, velocity, yPosition);
    });
    
    xyController->setPositionCallback([this](float x, float y) {
        oscController->sendXYPosition(x, y);
    });
    
    // Start timer for regular updates
    startTimer(50); // 20 FPS
    
    // Initialize fader value arrays with default values
    initializeFaderValues();
    
    // Connect to desktop Buchla700 app
    // Try common desktop IP addresses on local network
    bool connected = false;
    
    // Try different local network addresses
    juce::StringArray addressesToTry = {
        "192.168.0.18",    // Actual desktop IP (primary)
        "192.168.0.19",    // Actual desktop IP (secondary)
        "192.168.1.100",   // Common desktop IP
        "192.168.1.101",   // Alternative
        "192.168.1.2",     // Router +1
        "192.168.0.100",   // Alternative subnet
        "10.0.0.100",      // Alternative subnet
        "127.0.0.1"        // Localhost (for simulator testing)
    };
    
    for (const auto& address : addressesToTry) {
        if (oscController->connectToEmulator(address, 9001, 9002)) {
            connected = true;
            juce::Logger::writeToLog("BuchlaControl: Connected to Buchla700 at " + address);
            break;
        }
    }
    
    if (!connected) {
        juce::Logger::writeToLog("BuchlaControl: Could not connect to Buchla700 desktop app");
        juce::Logger::writeToLog("BuchlaControl: Make sure desktop app is running and on same network");
        juce::Logger::writeToLog("BuchlaControl: No OSC communication will work until connected");
    }
    
    // Set up fader update callback to handle incoming changes from desktop
    oscController->setFaderUpdateCallback([this](int faderIndex, float value) {
        handleIncomingFaderUpdate(faderIndex, value);
    });

    // Set up LCD row callback to mirror emulator display
    oscController->setLcdRowCallback([this](int row, const juce::String& text) {
        handleLcdRow(row, text);
    });
    
    // Set size for iPad landscape orientation
    setSize(1024, 768);
    
}

MainComponent::~MainComponent()
{
    setLookAndFeel(nullptr);
}

void MainComponent::paint(juce::Graphics& g)
{
    // Fill with dark background - NO panel separators/rectangles
    g.fillAll(BuchlaColors::background);
}

void MainComponent::resized()
{
    auto bounds = getLocalBounds();
    
    // Blue area: XY controller - SQUARE (width = height)
    xyControllerArea = juce::Rectangle<int>(0, 50, 200, 200);
    
    // Yellow area: knobs below XY controller
    topControlsArea = juce::Rectangle<int>(0, 250, 200, 120);
    
    // Green area: fader buttons - positioned to align with faders
    faderButtonsArea = juce::Rectangle<int>(200, 0, bounds.getWidth() - 200, 50);
    
    // Orange area: faders - right side, below green area
    dataFadersArea = juce::Rectangle<int>(200, 50, bounds.getWidth() - 200, 320);
    
    // Pink area: keyboard - EXPANDED to fill remaining space
    touchKeyboardArea = juce::Rectangle<int>(0, 370, bounds.getWidth(), bounds.getHeight() - 370);
    
    layoutComponents();
}

void MainComponent::setupTopControls()
{
    // Tempo multiplier knob - 11 discrete values: 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.3, 1.4, 1.5
    tempoMultSlider = std::make_unique<juce::Slider>(juce::Slider::RotaryVerticalDrag, 
                                                     juce::Slider::TextBoxBelow);
    tempoMultSlider->setRange(0, 10, 1); // 11 positions (0-10)
    tempoMultSlider->setColour(juce::Slider::rotarySliderFillColourId, BuchlaColors::accent);
    tempoMultSlider->setColour(juce::Slider::textBoxTextColourId, BuchlaColors::valueText);
    tempoMultSlider->onValueChange = [this] { topControlChanged(); };
    // Custom text function to show actual tempo multiplier value instead of index
    tempoMultSlider->textFromValueFunction = [](double value) {
        int sliderPos = static_cast<int>(value);
        float tempoMult = 0.5f + (sliderPos * 0.1f);
        return juce::String(tempoMult, 1);
    };
    tempoMultSlider->setValue(5); // Default to position 5 (1.0) - set after textFromValueFunction
    addAndMakeVisible(tempoMultSlider.get());
    
    tempoMultLabel = std::make_unique<juce::Label>("", "TEMPO MULT");
    tempoMultLabel->setColour(juce::Label::textColourId, BuchlaColors::labelText);
    tempoMultLabel->setJustificationType(juce::Justification::centred);
    addAndMakeVisible(tempoMultLabel.get());
    
    // Time scaling knob - 11 discrete values: 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.3, 1.4, 1.5
    timeScalingSlider = std::make_unique<juce::Slider>(juce::Slider::RotaryVerticalDrag,
                                                       juce::Slider::TextBoxBelow);
    timeScalingSlider->setRange(0, 10, 1); // 11 positions (0-10)
    timeScalingSlider->setColour(juce::Slider::rotarySliderFillColourId, BuchlaColors::accent);
    timeScalingSlider->setColour(juce::Slider::textBoxTextColourId, BuchlaColors::valueText);
    timeScalingSlider->onValueChange = [this] { topControlChanged(); };
    // Custom text function to show actual time scaling value instead of index
    timeScalingSlider->textFromValueFunction = [](double value) {
        int sliderPos = static_cast<int>(value);
        float timeScaling = 0.5f + (sliderPos * 0.1f);
        return juce::String(timeScaling, 1);
    };
    timeScalingSlider->setValue(5); // Default to position 5 (1.0) - set after textFromValueFunction
    addAndMakeVisible(timeScalingSlider.get());
    
    timeScalingLabel = std::make_unique<juce::Label>("", "TIME SCALING");
    timeScalingLabel->setColour(juce::Label::textColourId, BuchlaColors::labelText);
    timeScalingLabel->setJustificationType(juce::Justification::centred);
    addAndMakeVisible(timeScalingLabel.get());
}


void MainComponent::setupFaderButtons()
{
    // Labels that correspond to faders
    juce::StringArray faderButtonNames = {
        "Quiet", "ROMP", "Lamp", "Clock", "_P/R ", "GoTo", "Instr", 
        "Asgmt", "Load", " ", " ", "Other", "Voice", "Init"
    };
    
    for (int i = 0; i < 14; ++i)
    {
        auto button = std::make_unique<juce::TextButton>(faderButtonNames[i]);
        button->setColour(juce::TextButton::buttonColourId, BuchlaColors::buttonOff);
        button->setColour(juce::TextButton::buttonOnColourId, BuchlaColors::buttonOn);
        button->setColour(juce::TextButton::textColourOffId, BuchlaColors::buttonText);
        button->setColour(juce::TextButton::textColourOnId, BuchlaColors::buttonText);
        button->setClickingTogglesState(false);
        button->onClick = [this, i] { faderButtonClicked(i); };
        
        faderButtons[i] = std::move(button);
        addAndMakeVisible(faderButtons[i].get());
    }
}

void MainComponent::setupDataFaders()
{
    // Labels that correspond to LCD display data
    juce::StringArray faderLabelNames = {
        "Locn", "Level", "Ind 1", "Ind 2", "Ind 3", "Frq 1", "Frq 2", 
        "Frq 3", "Frq 4", "Ind 4", "Ind 5", "Ind 6", "Filtr", "Reson"
    };
    
    for (int i = 0; i < 14; ++i)
    {
        // Create fader (no text box)
        auto fader = std::make_unique<RelativeFader>(RelativeFader::LinearVertical,
                                                     RelativeFader::NoTextBox);
        
        // Set fader type FIRST, then values
        // Locn=0, Frq1=5, Frq2=6, Frq3=7, Frq4=8, Filtr=12
        if (i == 0 || (i >= 5 && i <= 8) || i == 12) {
            // Locn, Frq 1-4, Filtr: offset faders
            fader->setFaderType(RelativeFader::OffsetFader);
            fader->setRange(0.0, 1.0, 0.001);
            fader->setValue(0.5);
        } else {
            // Level, Reson, Ind 1-6: gain faders  
            fader->setFaderType(RelativeFader::GainFader);
            fader->setRange(0.0, 1.0, 0.001);
            fader->setValue(0.0);
        }
        
        // Force initial repaint to ensure display is updated
        fader->repaint();
        fader->setColour(juce::Slider::trackColourId, BuchlaColors::faderTrack);
        fader->setColour(juce::Slider::thumbColourId, BuchlaColors::faderThumb);
        fader->setColour(juce::Slider::textBoxTextColourId, BuchlaColors::valueText);
        
        // No text box needed
        
        // Explicitly set look and feel to ensure custom drawing
        fader->setLookAndFeel(&buchlaLookAndFeel);
        
        fader->onValueChange = [this, i] { 
            dataFaderChanged(i, static_cast<float>(dataFaders[i]->getValue())); 
        };
        
        dataFaders[i] = std::move(fader);
        addAndMakeVisible(dataFaders[i].get());
        
        // Create label
        auto label = std::make_unique<juce::Label>("", faderLabelNames[i]);
        label->setColour(juce::Label::textColourId, BuchlaColors::labelText);
        label->setJustificationType(juce::Justification::centred);
        
        faderLabels[i] = std::move(label);
        addAndMakeVisible(faderLabels[i].get());
    }
}

void MainComponent::layoutComponents()
{
    // Layout knobs (Yellow area - knobs below XY controller)
    auto yellowArea = topControlsArea.reduced(10);
    auto knobWidth = yellowArea.getWidth() / 2 - 10;
    
    auto tempoArea = yellowArea.removeFromLeft(knobWidth);
    tempoMultLabel->setBounds(tempoArea.removeFromBottom(20));
    tempoMultSlider->setBounds(tempoArea);
    
    yellowArea.removeFromLeft(20); // Spacing between knobs
    timeScalingLabel->setBounds(yellowArea.removeFromBottom(20));
    timeScalingSlider->setBounds(yellowArea);
    
    // Layout XY controller (Blue area - left side spanning down)
    if (xyController)
        xyController->setBounds(xyControllerArea.reduced(10));
    
    // Layout fader buttons (Green area - EXACTLY aligned with faders)
    auto greenArea = faderButtonsArea.reduced(5);
    int faderButtonWidth = greenArea.getWidth() / 14;
    
    for (int i = 0; i < 14; ++i)
    {
        auto bounds = juce::Rectangle<int>(
            greenArea.getX() + i * faderButtonWidth,
            greenArea.getY(),
            faderButtonWidth - 2,
            greenArea.getHeight()
        );
        faderButtons[i]->setBounds(bounds);
    }
    
    // Layout data faders (Orange area - EXACTLY aligned with fader buttons above)
    auto orangeArea = dataFadersArea.reduced(5);
    int faderWidth = orangeArea.getWidth() / 14;
    
    for (int i = 0; i < 14; ++i)
    {
        auto columnArea = juce::Rectangle<int>(
            orangeArea.getX() + i * faderWidth,
            orangeArea.getY(),
            faderWidth - 2,
            orangeArea.getHeight()
        );
        
        faderLabels[i]->setBounds(columnArea.removeFromBottom(20));
        dataFaders[i]->setBounds(columnArea.reduced(5));
    }
    
    // Layout touch keyboard (Pink area) - expanded to fill remaining space
    if (touchKeyboard)
        touchKeyboard->setBounds(touchKeyboardArea.reduced(5));
}


void MainComponent::timerCallback()
{
    // Regular updates for UI components
    repaint();
}


void MainComponent::faderButtonClicked(int buttonIndex)
{
    // All buttons are momentary: send press then release to the emulator
    oscController->sendButtonEvent(buttonIndex, true);
    oscController->sendButtonEvent(buttonIndex, false);

    // Cycle local fader mode after sending button to emulator
    // (button 11 = "Other"/"EQ"/"Prmtr")
    if (buttonIndex == 11) {
        cycleFaderMode();
    }
}

void MainComponent::dataFaderChanged(int faderIndex, float value)
{
    // Send different OSC messages based on fader mode
    switch (currentFaderMode) {
        case FaderMode::Normal:
            // Standard fader behavior
            oscController->sendFaderEvent(faderIndex, value);
            break;
            
        case FaderMode::Other:
            // Phase shift and auxiliary controls
            oscController->sendFaderEvent(faderIndex + 200, value); // Offset by 200 for Other mode
            break;
            
        case FaderMode::EQ:
            // EQ band controls
            oscController->sendFaderEvent(faderIndex + 300, value); // Offset by 300 for EQ mode
            break;
    }
}

void MainComponent::topControlChanged()
{
    // Convert tempo multiplier slider position (0-10) to actual values
    // 0=0.5, 1=0.6, 2=0.7, 3=0.8, 4=0.9, 5=1.0, 6=1.1, 7=1.2, 8=1.3, 9=1.4, 10=1.5
    int tempoSliderPos = static_cast<int>(tempoMultSlider->getValue());
    float tempoMult = 0.5f + (tempoSliderPos * 0.1f);
    
    // Convert time scaling slider position (0-10) to actual values
    // 0=0.5, 1=0.6, 2=0.7, 3=0.8, 4=0.9, 5=1.0, 6=1.1, 7=1.2, 8=1.3, 9=1.4, 10=1.5
    int timeSliderPos = static_cast<int>(timeScalingSlider->getValue());
    float timeScaling = 0.5f + (timeSliderPos * 0.1f);
    
    oscController->sendTempoMult(tempoMult);
    oscController->sendTimeScaling(timeScaling);
}

void MainComponent::resetFadersToDefaults()
{
    // Reset fader values to defaults for the current mode only
    
    for (int i = 0; i < 14; ++i)
    {
        float defaultValue = 0.0f; // Default for most faders
        
        switch (currentFaderMode) {
            case FaderMode::Normal:
                // Normal mode: Locn, Frq 1-4, Filtr = 0.5 (neutral), others = 0.0
                if (i == 0 || (i >= 5 && i <= 8) || i == 12) {
                    defaultValue = 0.5f; // Neutral for Locn, Frq 1-4, Filtr
                } else {
                    defaultValue = 0.0f; // No effect for Level, Reson, Ind 1-6
                }
                break;
                
            case FaderMode::Other:
                // Other mode: Phase shift controls get sensible defaults, others = 0.0
                if (i == 2) { // Depth
                    defaultValue = 0.0f; // 0% depth
                } else if (i == 3) { // Rate  
                    defaultValue = 0.0f; // 0.1Hz (minimum rate)
                } else if (i == 4) { // Intensity
                    defaultValue = 0.0f; // 0% intensity
                } else if (i >= 5 && i <= 8) { // CV1-4
                    defaultValue = 0.5f; // Neutral for CV controls
                } else {
                    defaultValue = 0.0f; // Unused faders
                }
                break;
                
            case FaderMode::EQ:
                // EQ mode: All bands reset to 0dB (50%)
                defaultValue = 0.5f;
                break;
        }
        
        // Set the fader value and send OSC message
        dataFaders[i]->setValue(defaultValue, juce::dontSendNotification);
        
        // Send the change to the desktop synth
        dataFaderChanged(i, defaultValue);
    }
    
    // Save the reset values to the current mode's array
    saveFaderValues();
}

// Fader mode system implementation
void MainComponent::cycleFaderMode()
{
    // Save current fader values before switching
    saveFaderValues();
    
    switch (currentFaderMode) {
        case FaderMode::Normal:
            currentFaderMode = FaderMode::Other;
            break;
        case FaderMode::Other:
            currentFaderMode = FaderMode::EQ;
            break;
        case FaderMode::EQ:
            currentFaderMode = FaderMode::Normal;
            break;
    }
    
    // Restore fader values for the new mode
    restoreFaderValues();
    
    updateButtonLabels();
    updateFaderLabels();
}

void MainComponent::updateButtonLabels()
{
    juce::StringArray buttonNames;

    switch (currentFaderMode) {
        case FaderMode::Normal:
            buttonNames = {
                "Quiet", "ROMP", "Lamp", "Clock", "_P/R ", "GoTo", "Instr",
                "Asgmt", "Load", " ", " ", "Other", "Voice", "Init"
            };
            break;

        case FaderMode::Other:
            buttonNames = {
                "Quiet", " ", " ", " ", " ", " ", " ",
                " ", " ", " ", " ", "EQ", " ", "Init"
            };
            break;

        case FaderMode::EQ:
            buttonNames = {
                "Quiet", " ", " ", " ", " ", " ", " ",
                " ", " ", " ", " ", "Prmtr", " ", "Init"
            };
            break;
    }

    for (int i = 0; i < 14; ++i) {
        if (i < buttonNames.size()) {
            faderButtons[i]->setButtonText(buttonNames[i]);
        }
    }
}

void MainComponent::updateFaderLabels()
{
    juce::StringArray labelNames;

    switch (currentFaderMode) {
        case FaderMode::Normal:
            labelNames = {
                "Locn", "Level", "Ind 1", "Ind 2", "Ind 3", "Frq 1", "Frq 2",
                "Frq 3", "Frq 4", "Ind 4", "Ind 5", "Ind 6", "Filtr", "Reson"
            };
            break;

        case FaderMode::Other:
            labelNames = {
                "---", "Aux", "Depth", "Rate", "Inten", "CV1", "CV2",
                "CV3", "CV4", "---", "---", "---", "---", "---"
            };
            break;

        case FaderMode::EQ:
            labelNames = {
                "50", "150", "400", "1k", "2.5k", "6k", "15k",
                "50", "150", "400", "1k", "2.5k", "6k", "15k"
            };
            break;
    }

    // Update fader labels
    for (int i = 0; i < 14; ++i) {
        if (i < labelNames.size()) {
            faderLabels[i]->setText(labelNames[i], juce::dontSendNotification);
        }
    }
}

void MainComponent::initializeFaderValues()
{
    // Initialize Normal mode with default synthesizer values
    for (int i = 0; i < 14; ++i) {
        // Locn=0, Frq1=5, Frq2=6, Frq3=7, Frq4=8, Filtr=12
        if (i == 0 || (i >= 5 && i <= 8) || i == 12) {
            normalModeValues[i] = 0.5f; // Neutral for Locn, Frq 1-4, Filtr
        } else {
            normalModeValues[i] = 0.0f; // No effect for Level, Reson, Ind 1-6
        }
    }
    
    // Initialize Other mode — all bottom-based bars (firmware uses BarBset)
    for (int i = 0; i < 14; ++i) {
        otherModeValues[i] = 0.0f;
    }
    
    // Initialize EQ mode (all bands at 0dB = 50%)
    for (int i = 0; i < 14; ++i) {
        eqModeValues[i] = 0.5f; // 0dB for all EQ bands
    }
}

void MainComponent::saveFaderValues()
{
    std::array<float, 14>* targetArray = nullptr;
    
    switch (currentFaderMode) {
        case FaderMode::Normal:
            targetArray = &normalModeValues;
            break;
        case FaderMode::Other:
            targetArray = &otherModeValues;
            break;
        case FaderMode::EQ:
            targetArray = &eqModeValues;
            break;
    }
    
    if (targetArray) {
        for (int i = 0; i < 14; ++i) {
            (*targetArray)[i] = static_cast<float>(dataFaders[i]->getValue());
        }
    }
}

void MainComponent::restoreFaderValues()
{
    const std::array<float, 14>* sourceArray = nullptr;
    
    switch (currentFaderMode) {
        case FaderMode::Normal:
            sourceArray = &normalModeValues;
            break;
        case FaderMode::Other:
            sourceArray = &otherModeValues;
            break;
        case FaderMode::EQ:
            sourceArray = &eqModeValues;
            break;
    }
    
    if (sourceArray) {
        for (int i = 0; i < 14; ++i) {
            // Update fader type per mode
            switch (currentFaderMode) {
                case FaderMode::Normal:
                    // Locn=0, Frq1-4=5-8, Filtr=12: offset; rest: gain
                    if (i == 0 || (i >= 5 && i <= 8) || i == 12)
                        dataFaders[i]->setFaderType(RelativeFader::OffsetFader);
                    else
                        dataFaders[i]->setFaderType(RelativeFader::GainFader);
                    break;
                case FaderMode::Other:
                    dataFaders[i]->setFaderType(RelativeFader::GainFader);
                    break;
                case FaderMode::EQ:
                    dataFaders[i]->setFaderType(RelativeFader::OffsetFader);
                    break;
            }

            // Restore visual position only — don't send OSC to avoid
            // flooding the emulator's keyboard buffer
            dataFaders[i]->setValue((*sourceArray)[i], juce::dontSendNotification);
        }
    }
}

void MainComponent::syncOtherModeWithDesktop()
{
    // When entering Other mode, request current phase shift values from desktop
    // For now, we'll send the current fader values and let the desktop sync back
    // This creates a feedback loop that will settle on the correct values
    
    if (currentFaderMode == FaderMode::Other) {
        // Send current Other mode values to get desktop to sync back
        for (int i = 2; i <= 4; ++i) { // Depth, Rate, Intensity
            dataFaderChanged(i, otherModeValues[i]);
        }
    }
}

void MainComponent::handleIncomingFaderUpdate(int faderIndex, float value)
{
    // This callback arrives from the OSC thread — use MessageManager for UI updates
    juce::MessageManager::callAsync([this, faderIndex, value]() {
        // Determine which fader mode this update belongs to based on faderIndex
        FaderMode targetMode = FaderMode::Normal;
        int localFaderIndex = faderIndex;

        if (faderIndex >= 300) {
            targetMode = FaderMode::EQ;
            localFaderIndex = faderIndex - 300;
        } else if (faderIndex >= 200) {
            targetMode = FaderMode::Other;
            localFaderIndex = faderIndex - 200;
        } else {
            targetMode = FaderMode::Normal;
            localFaderIndex = faderIndex;
        }

        if (localFaderIndex >= 0 && localFaderIndex < 14) {
            // ignore incoming updates while the user is actively jogging
            // this fader — the jog value is authoritative
            if (currentFaderMode == targetMode &&
                dataFaders[localFaderIndex]->isJogActive()) {
                return;
            }

            switch (targetMode) {
                case FaderMode::Normal:
                    normalModeValues[localFaderIndex] = value;
                    break;
                case FaderMode::Other:
                    otherModeValues[localFaderIndex] = value;
                    break;
                case FaderMode::EQ:
                    eqModeValues[localFaderIndex] = value;
                    break;
            }

            if (currentFaderMode == targetMode) {
                dataFaders[localFaderIndex]->setValue(value, juce::dontSendNotification);
            }
        }
    });
}

void MainComponent::parseLcdLabels(const juce::String& text, int count,
                                    std::function<void(int, const juce::String&)> setter)
{
    // The LCD is 85 columns wide with 14 fields.
    // Field width is approximately 6 characters each (85 / 14 ≈ 6.07).
    // Fields 0-12 are 6 chars wide, field 13 gets the remainder.

    int fieldWidth = 6;

    for (int i = 0; i < count; ++i) {
        int start = i * fieldWidth;
        int len = (i < count - 1) ? fieldWidth : (text.length() - start);

        if (start >= text.length() || len <= 0)
            break;

        juce::String label = text.substring(start, start + len).trim();
        setter(i, label);
    }
}

void MainComponent::handleLcdRow(int row, const juce::String& text)
{
    juce::Logger::writeToLog("LCD ROW " + juce::String(row) + ": [" + text + "]");

    // This callback arrives from the OSC thread — use MessageManager for UI updates
    juce::MessageManager::callAsync([this, row, text]() {
        if (row == 0) {
            // Row 0: button labels
            parseLcdLabels(text, 14, [this](int i, const juce::String& label) {
                if (i < 14) {
                    faderButtons[i]->setButtonText(label);
                    juce::Logger::writeToLog("  btn[" + juce::String(i) + "] = \"" + label + "\"");
                }
            });
        }
        else if (row == 7) {
            // Row 7: fader/pot labels
            parseLcdLabels(text, 14, [this](int i, const juce::String& label) {
                if (i < 14)
                    faderLabels[i]->setText(label, juce::dontSendNotification);
            });
        }
    });
}
