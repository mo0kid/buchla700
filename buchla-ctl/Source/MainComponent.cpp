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

    // Register all callbacks BEFORE connecting, so the emulator's
    // immediate response isn't dropped
    oscController->setConnectionCallback([this](bool isConnected) {
        if (!isConnected) {
            juce::MessageManager::callAsync([this]() {
                connectedToEmulator = false;
                blankDisplay();
                repaint();
            });
        }
    });

    oscController->setFaderUpdateCallback([this](int faderIndex, float value) {
        handleIncomingFaderUpdate(faderIndex, value);
    });

    oscController->setLcdRowCallback([this](int row, const juce::String& text) {
        handleLcdRow(row, text);
    });

    oscController->setFaderCenteredCallback([this](int bitmask) {
        handleFaderCentered(bitmask);
    });

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

    // Set size for iPad landscape orientation
    setSize(1024, 768);

    // Start blank — emulator will populate on connect
    blankDisplay();
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

void MainComponent::paintOverChildren(juce::Graphics& g)
{
    if (!oscController->isConnected()) {
        g.setColour(juce::Colours::red);
        g.setFont(juce::Font(28.0f));
        g.drawText("OSC NOT CONNECTED!", dataFadersArea, juce::Justification::centred);
    } else if (!connectedToEmulator) {
        g.setColour(juce::Colours::red);
        g.setFont(juce::Font(28.0f));
        g.drawText("EMU NOT CONNECTED!", dataFadersArea, juce::Justification::centred);
    }
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
    // Labels start blank — emulator sends them via LCD row 0
    juce::StringArray faderButtonNames = {
        " ", " ", " ", " ", " ", " ", " ",
        " ", " ", " ", " ", " ", " ", " "
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
    for (int i = 0; i < 14; ++i)
    {
        // Create fader (no text box) — all start as gain faders at zero
        auto fader = std::make_unique<RelativeFader>(RelativeFader::LinearVertical,
                                                     RelativeFader::NoTextBox);
        fader->setFaderType(RelativeFader::GainFader);
        fader->setRange(0.0, 1.0, 0.001);
        fader->setValue(0.0);
        
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
        
        // Create label — starts blank, emulator sends via LCD row 7
        auto label = std::make_unique<juce::Label>("", "");
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
}

void MainComponent::dataFaderChanged(int faderIndex, float value)
{
    oscController->sendFaderEvent(faderIndex, value);
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

void MainComponent::handleIncomingFaderUpdate(int faderIndex, float value)
{
    juce::MessageManager::callAsync([this, faderIndex, value]() {
        if (faderIndex >= 0 && faderIndex < 14) {
            if (dataFaders[faderIndex]->isJogActive())
                return;
            dataFaders[faderIndex]->setValue(value, juce::dontSendNotification);
        }
    });
}

void MainComponent::handleFaderCentered(int bitmask)
{
    juce::MessageManager::callAsync([this, bitmask]() {
        for (int i = 0; i < 14; ++i) {
            bool centered = (bitmask >> i) & 1;
            if (centered) {
                dataFaders[i]->setFaderType(RelativeFader::OffsetFader);
                if (!dataFaders[i]->isJogActive())
                    dataFaders[i]->setValue(0.5, juce::dontSendNotification);
            } else {
                dataFaders[i]->setFaderType(RelativeFader::GainFader);
                if (!dataFaders[i]->isJogActive())
                    dataFaders[i]->setValue(0.0, juce::dontSendNotification);
            }
            dataFaders[i]->repaint();
        }
    });
}

void MainComponent::blankDisplay()
{
    for (int i = 0; i < 14; ++i) {
        dataFaders[i]->setFaderType(RelativeFader::GainFader);
        dataFaders[i]->setValue(0.0, juce::dontSendNotification);
        dataFaders[i]->repaint();
        faderLabels[i]->setText("", juce::dontSendNotification);
        faderButtons[i]->setButtonText(" ");
    }
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
        if (!connectedToEmulator) {
            connectedToEmulator = true;
            repaint();
        }
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
