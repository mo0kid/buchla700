#pragma once

#include <juce_gui_basics/juce_gui_basics.h>
#include "BuchlaColors.h"

/**
 * LCD Display Component - Emulates the Buchla 700 LCD display
 * 
 * Features:
 * - Multi-line text display with monospace font
 * - Orange text on black background
 * - 14 data columns matching the fader labels
 * - Scrollable content
 * - Updates from OSC messages or internal state
 */
class LCDDisplay : public juce::Component
{
public:
    LCDDisplay();
    ~LCDDisplay() override;
    
    void paint(juce::Graphics& g) override;
    void resized() override;
    
    // Content management
    void setDisplayText(const juce::String& text);
    void appendLine(const juce::String& line);
    void clearDisplay();
    
    // Data column updates (corresponding to fader labels)
    void updateDataColumn(int columnIndex, const juce::String& value);
    void setColumnHeader(int columnIndex, const juce::String& header);
    
    // Display configuration
    void setMaxLines(int lines) { maxDisplayLines = lines; }
    void setScrollEnabled(bool enabled) { scrollEnabled = enabled; }
    void setAutoScroll(bool enabled) { autoScrollEnabled = enabled; }
    
    // Data access
    juce::String getCurrentText() const { return displayContent; }
    juce::String getColumnValue(int columnIndex) const;

private:
    // Display content
    juce::String displayContent;
    juce::StringArray displayLines;
    int maxDisplayLines = 6;  // Typical LCD display height
    int scrollOffset = 0;
    
    // Data columns (matching fader layout)
    static const int numDataColumns = 14;
    juce::StringArray columnHeaders;
    juce::StringArray columnValues;
    
    // Display properties
    bool scrollEnabled = true;
    bool autoScrollEnabled = true;
    juce::Font lcdFont;
    
    // Visual properties
    float characterWidth = 0.0f;
    float lineHeight = 0.0f;
    int charsPerLine = 0;
    
    // Helper methods
    void updateDisplayLines();
    void scrollToBottom();
    void calculateFontMetrics();
    void drawLCDText(juce::Graphics& g, const juce::String& text, 
                    const juce::Rectangle<float>& bounds);
    void drawDataColumns(juce::Graphics& g, const juce::Rectangle<float>& bounds);
    void initializeColumns();
    
    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR(LCDDisplay)
};