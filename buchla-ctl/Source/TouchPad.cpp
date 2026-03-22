#include "TouchPad.h"

TouchPad::TouchPad()
{
    setWantsKeyboardFocus(false);
    
    // Start with default position: x=0.0 (center), y=0.0 (bottom)
    currentPosition = defaultPosition;
}

TouchPad::~TouchPad()
{
}

void TouchPad::paint(juce::Graphics& g)
{
    auto bounds = getLocalBounds().toFloat();
    
    // Background
    g.setColour(BuchlaColors::xyPadBackground);
    g.fillRoundedRectangle(bounds, 8.0f);
    
    // Border
    g.setColour(BuchlaColors::touchKeyBorder);
    g.drawRoundedRectangle(bounds, 8.0f, 2.0f);
    
    // Draw grid if enabled
    if (showGrid)
        drawGrid(g);
    
    // Draw trail if enabled and active
    if (showTrail && isActive)
        drawTrail(g);
    
    // Draw cursor
    drawCursor(g);
    
    // Draw labels
    g.setColour(BuchlaColors::labelText);
    g.setFont(10.0f);
    
    // HT (Horizontal Touch) label
    g.drawText("HT", bounds.removeFromBottom(15), juce::Justification::centredLeft, true);
    
    // VT (Vertical Touch) label - rotated
    g.saveState();
    g.addTransform(juce::AffineTransform::rotation(-juce::MathConstants<float>::halfPi, 
                                                  bounds.getX() + 10, bounds.getCentreY()));
    g.drawText("VT", juce::Rectangle<float>(bounds.getX(), bounds.getCentreY() - 10, 20, 20),
               juce::Justification::centred, true);
    g.restoreState();
}

void TouchPad::resized()
{
    // Update trail positions if component size changes
    // (not implemented for simplicity)
}

void TouchPad::mouseDown(const juce::MouseEvent& event)
{
    juce::Logger::writeToLog("TouchPad::mouseDown at " + juce::String(event.position.x, 1) + "," + juce::String(event.position.y, 1) + " primaryTouchId=" + juce::String(primaryTouchId));
    if (primaryTouchId == -1)
    {
        primaryTouchId = event.source.getIndex();
        isActive = true;
        
        auto bounds = getLocalBounds().toFloat().reduced(10.0f);
        juce::Point<float> relativePos(
            (event.position.x - bounds.getX()) / bounds.getWidth(),
            1.0f - (event.position.y - bounds.getY()) / bounds.getHeight() // Flip Y: top=1.0, bottom=0.0
        );
        
        updatePosition(constrainPosition(relativePos));
    }
}

void TouchPad::mouseUp(const juce::MouseEvent& event)
{
    if (event.source.getIndex() == primaryTouchId)
    {
        primaryTouchId = -1;
        isActive = false;
        trail.clear();
        
        // Reset to default position (0.0, 0.0)
        updatePosition(defaultPosition);
        
        repaint();
    }
}

void TouchPad::mouseDrag(const juce::MouseEvent& event)
{
    if (event.source.getIndex() == primaryTouchId)
    {
        auto bounds = getLocalBounds().toFloat().reduced(10.0f);
        juce::Point<float> relativePos(
            (event.position.x - bounds.getX()) / bounds.getWidth(),
            1.0f - (event.position.y - bounds.getY()) / bounds.getHeight() // Flip Y: top=1.0, bottom=0.0
        );
        
        updatePosition(constrainPosition(relativePos));
    }
}

juce::Point<float> TouchPad::getMappedPosition() const
{
    return juce::Point<float>(
        xMin + currentPosition.x * (xMax - xMin),
        yMin + currentPosition.y * (yMax - yMin)
    );
}

juce::Point<float> TouchPad::constrainPosition(const juce::Point<float>& pos)
{
    return juce::Point<float>(
        juce::jlimit(0.0f, 1.0f, pos.x),
        juce::jlimit(0.0f, 1.0f, pos.y)
    );
}

void TouchPad::updatePosition(const juce::Point<float>& newPos)
{
    if (currentPosition != newPos)
    {
        currentPosition = newPos;
        
        if (showTrail)
            addTrailPoint(currentPosition);
        
        if (positionCallback)
        {
            auto mapped = getMappedPosition();
            juce::Logger::writeToLog("TouchPad: pos=" + juce::String(mapped.x, 3) + "," + juce::String(mapped.y, 3));
            positionCallback(mapped.x, mapped.y);
        }
        
        repaint();
    }
}

void TouchPad::addTrailPoint(const juce::Point<float>& pos)
{
    TrailPoint point;
    point.position = pos;
    point.age = 0.0f;
    point.opacity = 1.0f;
    
    trail.insert(trail.begin(), point);
    
    // Limit trail length
    if (trail.size() > maxTrailPoints)
        trail.resize(maxTrailPoints);
    
    // Update existing points
    updateTrail();
}

void TouchPad::updateTrail()
{
    for (auto& point : trail)
    {
        point.age += 1.0f;
        point.opacity = juce::jmax(0.0f, 1.0f - (point.age / maxTrailPoints));
    }
    
    // Remove very old points
    trail.erase(std::remove_if(trail.begin(), trail.end(),
                              [](const TrailPoint& p) { return p.opacity <= 0.0f; }),
               trail.end());
}

void TouchPad::drawGrid(juce::Graphics& g)
{
    auto bounds = getLocalBounds().toFloat().reduced(10.0f);
    
    g.setColour(BuchlaColors::xyPadGrid);
    
    // Vertical lines
    int numVertLines = 8;
    for (int i = 1; i < numVertLines; ++i)
    {
        float x = bounds.getX() + (i * bounds.getWidth() / numVertLines);
        g.drawVerticalLine(static_cast<int>(x), bounds.getY(), bounds.getBottom());
    }
    
    // Horizontal lines
    int numHorzLines = 6;
    for (int i = 1; i < numHorzLines; ++i)
    {
        float y = bounds.getY() + (i * bounds.getHeight() / numHorzLines);
        g.drawHorizontalLine(static_cast<int>(y), bounds.getX(), bounds.getRight());
    }
    
    // Center crosshairs
    g.setColour(BuchlaColors::xyPadGrid.brighter(0.2f));
    float centerX = bounds.getCentreX();
    float centerY = bounds.getCentreY();
    
    g.drawVerticalLine(static_cast<int>(centerX), bounds.getY(), bounds.getBottom());
    g.drawHorizontalLine(static_cast<int>(centerY), bounds.getX(), bounds.getRight());
}

void TouchPad::drawCursor(juce::Graphics& g)
{
    auto bounds = getLocalBounds().toFloat().reduced(10.0f);
    
    // Calculate cursor position (flip Y back for drawing since screen coordinates have 0 at top)
    float cursorX = bounds.getX() + currentPosition.x * bounds.getWidth();
    float cursorY = bounds.getY() + (1.0f - currentPosition.y) * bounds.getHeight();
    
    // Cursor appearance depends on active state
    juce::Colour cursorColour = isActive ? 
        BuchlaColors::xyPadCursor : BuchlaColors::xyPadCursor.withAlpha(0.7f);
    
    float cursorSize = isActive ? 12.0f : 8.0f;
    
    // Draw cursor as crosshair
    g.setColour(cursorColour);
    
    // Horizontal line
    g.drawHorizontalLine(static_cast<int>(cursorY), 
                        cursorX - cursorSize, cursorX + cursorSize);
    
    // Vertical line
    g.drawVerticalLine(static_cast<int>(cursorX), 
                      cursorY - cursorSize, cursorY + cursorSize);
    
    // Center dot
    g.fillEllipse(cursorX - 2, cursorY - 2, 4, 4);
    
    // Position readout if active
    if (isActive)
    {
        g.setFont(9.0f);
        auto mapped = getMappedPosition();
        juce::String posText = juce::String::formatted("%.1f, %.1f", mapped.x, mapped.y);
        
        // Position text below cursor
        auto textBounds = juce::Rectangle<float>(cursorX - 30, cursorY + 15, 60, 12);
        
        // Background for text
        g.setColour(BuchlaColors::background.withAlpha(0.8f));
        g.fillRoundedRectangle(textBounds, 2.0f);
        
        // Text
        g.setColour(BuchlaColors::valueText);
        g.drawText(posText, textBounds.toNearestInt(), 
                  juce::Justification::centred, true);
    }
}

void TouchPad::drawTrail(juce::Graphics& g)
{
    if (trail.empty()) return;
    
    auto bounds = getLocalBounds().toFloat().reduced(10.0f);
    
    // Draw trail as connected line segments
    juce::Path trailPath;
    bool firstPoint = true;
    
    for (const auto& point : trail)
    {
        float x = bounds.getX() + point.position.x * bounds.getWidth();
        float y = bounds.getY() + (1.0f - point.position.y) * bounds.getHeight(); // Flip Y for drawing
        
        if (firstPoint)
        {
            trailPath.startNewSubPath(x, y);
            firstPoint = false;
        }
        else
        {
            trailPath.lineTo(x, y);
        }
    }
    
    // Draw the trail with fading opacity
    for (size_t i = 0; i < trail.size() - 1; ++i)
    {
        const auto& point = trail[i];
        float opacity = point.opacity * 0.6f;
        
        g.setColour(BuchlaColors::accent.withAlpha(opacity));
        
        float x1 = bounds.getX() + point.position.x * bounds.getWidth();
        float y1 = bounds.getY() + (1.0f - point.position.y) * bounds.getHeight(); // Flip Y for drawing
        
        if (i + 1 < trail.size())
        {
            const auto& nextPoint = trail[i + 1];
            float x2 = bounds.getX() + nextPoint.position.x * bounds.getWidth();
            float y2 = bounds.getY() + (1.0f - nextPoint.position.y) * bounds.getHeight(); // Flip Y for drawing
            
            g.drawLine(x1, y1, x2, y2, 2.0f);
        }
    }
}