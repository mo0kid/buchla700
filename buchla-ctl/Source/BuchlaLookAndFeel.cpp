#include "BuchlaLookAndFeel.h"

BuchlaLookAndFeel::BuchlaLookAndFeel()
{
    // Set default colours for the Buchla theme
    setColour(juce::ResizableWindow::backgroundColourId, BuchlaColors::background);
    setColour(juce::DocumentWindow::backgroundColourId, BuchlaColors::background);
    
    // Button colours
    setColour(juce::TextButton::buttonColourId, BuchlaColors::buttonOff);
    setColour(juce::TextButton::buttonOnColourId, BuchlaColors::buttonOn);
    setColour(juce::TextButton::textColourOffId, BuchlaColors::buttonText);
    setColour(juce::TextButton::textColourOnId, BuchlaColors::buttonText);
    
    // Slider colours
    setColour(juce::Slider::rotarySliderFillColourId, BuchlaColors::accent);
    setColour(juce::Slider::rotarySliderOutlineColourId, BuchlaColors::controlBackground);
    setColour(juce::Slider::thumbColourId, BuchlaColors::faderThumb);
    setColour(juce::Slider::trackColourId, BuchlaColors::faderTrack);
    setColour(juce::Slider::textBoxTextColourId, BuchlaColors::valueText);
    setColour(juce::Slider::textBoxBackgroundColourId, BuchlaColors::controlBackground);
    
    // Label colours
    setColour(juce::Label::textColourId, BuchlaColors::labelText);
    setColour(juce::Label::backgroundColourId, juce::Colours::transparentBlack);
    
    // Use system font as default (could be customized later)
    buchlaFont = juce::Font(14.0f, juce::Font::bold);
}

BuchlaLookAndFeel::~BuchlaLookAndFeel()
{
}

void BuchlaLookAndFeel::drawButtonBackground(juce::Graphics& g, 
                                           juce::Button& button, 
                                           const juce::Colour& backgroundColour,
                                           bool shouldDrawButtonAsHighlighted, 
                                           bool shouldDrawButtonAsDown)
{
    auto bounds = button.getLocalBounds().toFloat();
    auto cornerRadius = 4.0f;
    
    juce::Colour fillColour = backgroundColour;
    
    if (button.getToggleState())
        fillColour = BuchlaColors::buttonOn;
    else if (shouldDrawButtonAsDown)
        fillColour = BuchlaColors::accentDark;
    else if (shouldDrawButtonAsHighlighted)
        fillColour = fillColour.brighter(0.1f);
    
    drawRoundedRectangle(g, bounds, cornerRadius, fillColour, 
                        BuchlaColors::touchKeyBorder, 1.0f);
}

void BuchlaLookAndFeel::drawButtonText(juce::Graphics& g, 
                                     juce::TextButton& button, 
                                     bool shouldDrawButtonAsHighlighted, 
                                     bool shouldDrawButtonAsDown)
{
    juce::ignoreUnused(shouldDrawButtonAsHighlighted, shouldDrawButtonAsDown);
    
    g.setFont(getTextButtonFont(button, button.getHeight()));
    g.setColour(button.findColour(button.getToggleState() ? 
                                 juce::TextButton::textColourOnId : 
                                 juce::TextButton::textColourOffId));
    
    g.drawText(button.getButtonText(), button.getLocalBounds(),
               juce::Justification::centred, true);
}

void BuchlaLookAndFeel::drawRotarySlider(juce::Graphics& g, 
                                       int x, int y, int width, int height, 
                                       float sliderPos, float rotaryStartAngle, 
                                       float rotaryEndAngle, juce::Slider& slider)
{
    auto bounds = juce::Rectangle<int>(x, y, width, height).toFloat();
    auto radius = juce::jmin(bounds.getWidth(), bounds.getHeight()) / 2.0f - 4.0f;
    auto centre = bounds.getCentre();
    auto rx = centre.x - radius;
    auto ry = centre.y - radius;
    auto rw = radius * 2.0f;
    auto angle = rotaryStartAngle + sliderPos * (rotaryEndAngle - rotaryStartAngle);
    
    // Draw knob body
    g.setColour(BuchlaColors::knobBody);
    g.fillEllipse(rx, ry, rw, rw);
    
    // Draw knob outline
    g.setColour(BuchlaColors::touchKeyBorder);
    g.drawEllipse(rx, ry, rw, rw, 1.5f);
    
    // Draw pointer
    juce::Path pointer;
    auto pointerLength = radius * 0.7f;
    auto pointerThickness = 3.0f;
    
    pointer.addRectangle(-pointerThickness * 0.5f, -pointerLength, 
                        pointerThickness, pointerLength * 0.8f);
    
    g.setColour(BuchlaColors::knobPointer);
    g.fillPath(pointer, juce::AffineTransform::rotation(angle).translated(centre.x, centre.y));
}

void BuchlaLookAndFeel::drawLinearSlider(juce::Graphics& g, 
                                       int x, int y, int width, int height,
                                       float sliderPos, float minSliderPos, float maxSliderPos,
                                       juce::Slider::SliderStyle style, juce::Slider& slider)
{
    juce::ignoreUnused(minSliderPos, maxSliderPos);
    
    // Debug log to verify this method is being called
    static int debugCallCount = 0;
    if (++debugCallCount % 100 == 0) { // Log every 100th call to avoid spam
        juce::Logger::writeToLog("BuchlaLookAndFeel::drawLinearSlider called, sliderPos=" + juce::String(sliderPos, 3));
    }
    
    auto bounds = juce::Rectangle<int>(x, y, width, height).toFloat();
    
    if (style == juce::Slider::LinearVertical)
    {
        // Draw track
        auto trackWidth = 8.0f;
        auto trackBounds = bounds.withSizeKeepingCentre(trackWidth, bounds.getHeight());
        drawRoundedRectangle(g, trackBounds, 4.0f, BuchlaColors::faderTrack, 
                           BuchlaColors::touchKeyBorder, 1.0f);
        
        // Draw thumb - make it VERY visible
        auto thumbHeight = 40.0f; // Even larger
        auto thumbWidth = 35.0f;  // Even wider 
        auto thumbY = bounds.getY() + (1.0f - sliderPos) * (bounds.getHeight() - thumbHeight);
        auto thumbBounds = juce::Rectangle<float>(bounds.getCentreX() - thumbWidth/2.0f, thumbY, thumbWidth, thumbHeight);
        
        // Draw thick black shadow for maximum contrast
        auto shadowBounds = thumbBounds.translated(2.0f, 2.0f);
        g.setColour(juce::Colour(0x80000000)); // Semi-transparent black
        g.fillRoundedRectangle(shadowBounds, 6.0f);
        
        // Draw bright white base for maximum visibility
        g.setColour(juce::Colours::white);
        g.fillRoundedRectangle(thumbBounds, 6.0f);
        
        // Draw thick orange border 
        g.setColour(BuchlaColors::faderThumb); // Bright orange
        g.drawRoundedRectangle(thumbBounds, 6.0f, 3.0f);
        
        // Add inner highlight for extra visibility
        auto innerBounds = thumbBounds.reduced(4.0f);
        g.setColour(juce::Colour(0xffffff99)); // Light yellow
        g.fillRoundedRectangle(innerBounds, 3.0f);
    }
    else if (style == juce::Slider::LinearHorizontal)
    {
        // Draw track
        auto trackHeight = 8.0f;
        auto trackBounds = bounds.withSizeKeepingCentre(bounds.getWidth(), trackHeight);
        drawRoundedRectangle(g, trackBounds, 4.0f, BuchlaColors::faderTrack,
                           BuchlaColors::touchKeyBorder, 1.0f);
        
        // Draw thumb
        auto thumbWidth = 20.0f;
        auto thumbX = bounds.getX() + sliderPos * (bounds.getWidth() - thumbWidth);
        auto thumbBounds = juce::Rectangle<float>(thumbX, bounds.getCentreY() - 12.0f, thumbWidth, 24.0f);
        
        drawRoundedRectangle(g, thumbBounds, 4.0f, BuchlaColors::faderThumb,
                           BuchlaColors::accent, 1.5f);
    }
}

void BuchlaLookAndFeel::drawLabel(juce::Graphics& g, juce::Label& label)
{
    g.fillAll(label.findColour(juce::Label::backgroundColourId));
    
    if (!label.isBeingEdited())
    {
        auto alpha = label.isEnabled() ? 1.0f : 0.5f;
        
        g.setColour(label.findColour(juce::Label::textColourId).withMultipliedAlpha(alpha));
        g.setFont(getLabelFont(label));
        
        auto textArea = label.getBorderSize().subtractedFrom(label.getLocalBounds());
        
        g.drawFittedText(label.getText(), textArea, label.getJustificationType(),
                        juce::jmax(1, (int)(textArea.getHeight() / getLabelFont(label).getHeight())),
                        label.getMinimumHorizontalScale());
    }
}

juce::Font BuchlaLookAndFeel::getTextButtonFont(juce::TextButton&, int buttonHeight)
{
    return buchlaFont.withHeight(juce::jmin(14.0f, buttonHeight * 0.6f));
}

juce::Font BuchlaLookAndFeel::getLabelFont(juce::Label&)
{
    return buchlaFont.withHeight(12.0f);
}

void BuchlaLookAndFeel::drawRoundedRectangle(juce::Graphics& g, 
                                           const juce::Rectangle<float>& bounds, 
                                           float cornerRadius, 
                                           const juce::Colour& fillColour, 
                                           const juce::Colour& borderColour, 
                                           float borderThickness)
{
    // Fill
    g.setColour(fillColour);
    g.fillRoundedRectangle(bounds, cornerRadius);
    
    // Border
    if (borderThickness > 0.0f)
    {
        g.setColour(borderColour);
        g.drawRoundedRectangle(bounds, cornerRadius, borderThickness);
    }
}