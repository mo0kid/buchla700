#pragma once

#include <juce_gui_basics/juce_gui_basics.h>
#include <juce_gui_extra/juce_gui_extra.h>
#include "BuchlaColors.h"
#include "BuchlaLookAndFeel.h"
#include "TouchKeyboard.h"
#include "TouchPad.h"
#include "OSCController.h"
#include "RelativeFader.h"

/**
 * Main component that implements the Buchla 700 style interface layout
 * 
 * Layout consists of:
 * - 24 touch keys with Y-axis expression (Pink area - bottom)
 * - 14 fader buttons (Green area - middle top)
 * - 14 faders with labels (Orange area - middle bottom)
 * - XY controller (HT/VT) (Blue area - top right)
 * - Tempo multiplier and time scaling knobs (Yellow area - top left)
 */
class MainComponent : public juce::Component, 
                     public juce::Timer
{
public:
    MainComponent();
    ~MainComponent() override;

    void paint(juce::Graphics&) override;
    void paintOverChildren(juce::Graphics&) override;
    void resized() override;
    
    // Timer callback for regular updates
    void timerCallback() override;

private:
    // Look and feel
    BuchlaLookAndFeel buchlaLookAndFeel;
    
    // OSC communication
    std::unique_ptr<OSCController> oscController;
    
    // UI Components
    std::unique_ptr<TouchKeyboard> touchKeyboard;
    std::unique_ptr<TouchPad> xyController;
    
    // Top control knobs
    std::unique_ptr<juce::Slider> tempoMultSlider;
    std::unique_ptr<juce::Slider> timeScalingSlider;
    std::unique_ptr<juce::Label> tempoMultLabel;
    std::unique_ptr<juce::Label> timeScalingLabel;
    
    
    // 14 fader buttons (above faders)
    std::array<std::unique_ptr<juce::TextButton>, 14> faderButtons;
    
    // 14 data faders with labels
    std::array<std::unique_ptr<RelativeFader>, 14> dataFaders;
    std::array<std::unique_ptr<juce::Label>, 14> faderLabels;
    
    // Layout areas for different sections
    juce::Rectangle<int> topControlsArea;        // Yellow area - knobs
    juce::Rectangle<int> xyControllerArea;       // Blue area - XY controller
    juce::Rectangle<int> faderButtonsArea;       // Green area - fader buttons
    juce::Rectangle<int> dataFadersArea;         // Orange area - faders
    juce::Rectangle<int> touchKeyboardArea;      // Pink area - keyboard
    
    void setupTopControls();
    void setupFaderButtons();
    void setupDataFaders();
    void layoutComponents();
    
    // Button and fader callbacks
    void faderButtonClicked(int buttonIndex);
    void dataFaderChanged(int faderIndex, float value);
    void topControlChanged();

    void handleIncomingFaderUpdate(int faderIndex, float value);
    void handleFaderCentered(int bitmask);
    void handleLcdRow(int row, const juce::String& text);
    void blankDisplay();
    bool connectedToEmulator = false;
    void parseLcdLabels(const juce::String& text, int count,
                        std::function<void(int, const juce::String&)> setter);

    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR(MainComponent)
};