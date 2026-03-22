#pragma once

#include <juce_gui_basics/juce_gui_basics.h>
#include "BuchlaColors.h"

/**
 * Custom Look & Feel class that provides the Buchla 700 aesthetic
 * Dark theme with orange accents, rounded corners, and custom slider/button styles
 */
class BuchlaLookAndFeel : public juce::LookAndFeel_V4
{
public:
    BuchlaLookAndFeel();
    ~BuchlaLookAndFeel() override;
    
    // Button styling
    void drawButtonBackground(juce::Graphics& g, 
                            juce::Button& button, 
                            const juce::Colour& backgroundColour,
                            bool shouldDrawButtonAsHighlighted, 
                            bool shouldDrawButtonAsDown) override;
    
    void drawButtonText(juce::Graphics& g, 
                       juce::TextButton& button, 
                       bool shouldDrawButtonAsHighlighted, 
                       bool shouldDrawButtonAsDown) override;
    
    // Slider styling
    void drawRotarySlider(juce::Graphics& g, 
                         int x, int y, int width, int height, 
                         float sliderPos, float rotaryStartAngle, 
                         float rotaryEndAngle, juce::Slider& slider) override;
    
    void drawLinearSlider(juce::Graphics& g, 
                         int x, int y, int width, int height,
                         float sliderPos, float minSliderPos, float maxSliderPos,
                         juce::Slider::SliderStyle style, juce::Slider& slider) override;
    
    // Label styling
    void drawLabel(juce::Graphics& g, juce::Label& label) override;
    
    // Font management
    juce::Font getTextButtonFont(juce::TextButton&, int buttonHeight) override;
    juce::Font getLabelFont(juce::Label&) override;
    
private:
    // Custom font for Buchla styling (if available)
    juce::Font buchlaFont;
    
    // Helper methods
    void drawRoundedRectangle(juce::Graphics& g, 
                             const juce::Rectangle<float>& bounds, 
                             float cornerRadius, 
                             const juce::Colour& fillColour, 
                             const juce::Colour& borderColour, 
                             float borderThickness = 1.0f);
    
    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR(BuchlaLookAndFeel)
};