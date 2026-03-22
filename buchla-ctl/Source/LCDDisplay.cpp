#include "LCDDisplay.h"

LCDDisplay::LCDDisplay()
{
    // Set up monospace font for LCD appearance
    lcdFont = juce::Font(juce::Font::getDefaultMonospacedFontName(), 12.0f, juce::Font::plain);
    
    // Initialize column headers and values
    initializeColumns();
    
    // Set initial display content
    setDisplayText("TAUNUS CONTROL SYSTEM\nBUCHLA 700 EMULATION\nREADY...");
}

LCDDisplay::~LCDDisplay()
{
}

void LCDDisplay::paint(juce::Graphics& g)
{
    auto bounds = getLocalBounds().toFloat();
    
    // LCD background
    g.setColour(BuchlaColors::lcdBackground);
    g.fillRoundedRectangle(bounds, 4.0f);
    
    // LCD border
    g.setColour(BuchlaColors::lcdBorder);
    g.drawRoundedRectangle(bounds, 4.0f, 1.0f);
    
    auto contentBounds = bounds.reduced(8.0f);
    
    // Split display: main text area and data columns
    auto textArea = contentBounds.removeFromTop(contentBounds.getHeight() * 0.7f);
    auto dataArea = contentBounds;
    
    // Draw main text display
    drawLCDText(g, displayContent, textArea);
    
    // Draw data columns
    drawDataColumns(g, dataArea);
}

void LCDDisplay::resized()
{
    calculateFontMetrics();
    updateDisplayLines();
}

void LCDDisplay::setDisplayText(const juce::String& text)
{
    displayContent = text;
    updateDisplayLines();
    repaint();
}

void LCDDisplay::appendLine(const juce::String& line)
{
    if (!displayContent.isEmpty())
        displayContent += "\n";
    
    displayContent += line;
    updateDisplayLines();
    
    if (autoScrollEnabled)
        scrollToBottom();
    
    repaint();
}

void LCDDisplay::clearDisplay()
{
    displayContent.clear();
    displayLines.clear();
    scrollOffset = 0;
    repaint();
}

void LCDDisplay::updateDataColumn(int columnIndex, const juce::String& value)
{
    if (columnIndex >= 0 && columnIndex < numDataColumns)
    {
        columnValues.set(columnIndex, value);
        repaint();
    }
}

void LCDDisplay::setColumnHeader(int columnIndex, const juce::String& header)
{
    if (columnIndex >= 0 && columnIndex < numDataColumns)
    {
        columnHeaders.set(columnIndex, header);
        repaint();
    }
}

juce::String LCDDisplay::getColumnValue(int columnIndex) const
{
    if (columnIndex >= 0 && columnIndex < numDataColumns)
        return columnValues[columnIndex];
    return {};
}

void LCDDisplay::updateDisplayLines()
{
    displayLines = juce::StringArray::fromLines(displayContent);
    
    // Handle line wrapping based on display width
    if (charsPerLine > 0)
    {
        juce::StringArray wrappedLines;
        
        for (const auto& line : displayLines)
        {
            if (line.length() <= charsPerLine)
            {
                wrappedLines.add(line);
            }
            else
            {
                // Wrap long lines
                for (int i = 0; i < line.length(); i += charsPerLine)
                {
                    wrappedLines.add(line.substring(i, i + charsPerLine));
                }
            }
        }
        
        displayLines = wrappedLines;
    }
}

void LCDDisplay::scrollToBottom()
{
    if (displayLines.size() > maxDisplayLines)
    {
        scrollOffset = displayLines.size() - maxDisplayLines;
    }
    else
    {
        scrollOffset = 0;
    }
}

void LCDDisplay::calculateFontMetrics()
{
    if (getWidth() > 0)
    {
        characterWidth = lcdFont.getStringWidthFloat("M"); // Use 'M' for monospace width
        lineHeight = lcdFont.getHeight();
        charsPerLine = static_cast<int>((getWidth() - 16) / characterWidth); // Account for padding
    }
}

void LCDDisplay::drawLCDText(juce::Graphics& g, const juce::String& text, 
                           const juce::Rectangle<float>& bounds)
{
    g.setFont(lcdFont);
    g.setColour(BuchlaColors::lcdText);
    
    if (displayLines.isEmpty())
        return;
    
    float y = bounds.getY();
    int lineCount = 0;
    
    // Draw visible lines
    for (int i = scrollOffset; i < displayLines.size() && lineCount < maxDisplayLines; ++i)
    {
        if (y + lineHeight > bounds.getBottom())
            break;
        
        auto lineRect = juce::Rectangle<float>(bounds.getX(), y, bounds.getWidth(), lineHeight);
        g.drawText(displayLines[i], lineRect, juce::Justification::topLeft, false);
        
        y += lineHeight;
        lineCount++;
    }
    
    // Draw cursor/caret if at end
    if (text.isNotEmpty())
    {
        float cursorX = bounds.getX() + (displayLines.isEmpty() ? 0 : 
                                       lcdFont.getStringWidthFloat(displayLines[displayLines.size() - 1]));
        float cursorY = y - lineHeight;
        
        // Blinking cursor effect (simplified)
        static bool cursorVisible = true;
        if (cursorVisible)
        {
            g.fillRect(cursorX, cursorY, 2.0f, lineHeight);
        }
    }
}

void LCDDisplay::drawDataColumns(juce::Graphics& g, const juce::Rectangle<float>& bounds)
{
    if (bounds.getHeight() < 20) return; // Not enough space
    
    g.setFont(lcdFont.withHeight(10.0f));
    
    float columnWidth = bounds.getWidth() / numDataColumns;
    
    for (int i = 0; i < numDataColumns; ++i)
    {
        float x = bounds.getX() + i * columnWidth;
        auto columnBounds = juce::Rectangle<float>(x, bounds.getY(), columnWidth, bounds.getHeight());
        
        // Header
        auto headerBounds = columnBounds.removeFromTop(12);
        g.setColour(BuchlaColors::lcdText.withAlpha(0.7f));
        g.drawText(columnHeaders[i], headerBounds, juce::Justification::centred, true);
        
        // Value
        g.setColour(BuchlaColors::lcdText);
        g.drawText(columnValues[i], columnBounds, juce::Justification::centred, true);
        
        // Column separator
        if (i < numDataColumns - 1)
        {
            g.setColour(BuchlaColors::lcdBorder);
            g.drawVerticalLine(static_cast<int>(x + columnWidth - 1), 
                             bounds.getY(), bounds.getBottom());
        }
    }
}

void LCDDisplay::initializeColumns()
{
    // Initialize with the fader labels from MainComponent
    juce::StringArray defaultHeaders = {
        "Quiet", "ROMP", "Lamp", "Clock", "P/R", "Go To", "Instr", 
        "Asgmt", "Load", "Other", "Voice", "Init", "Level", "Ind"
    };
    
    columnHeaders.clear();
    columnValues.clear();
    
    for (int i = 0; i < numDataColumns; ++i)
    {
        if (i < defaultHeaders.size())
            columnHeaders.add(defaultHeaders[i]);
        else
            columnHeaders.add(juce::String::formatted("C%d", i + 1));
        
        columnValues.add("--"); // Default empty value
    }
}