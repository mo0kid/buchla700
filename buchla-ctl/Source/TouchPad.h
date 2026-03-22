#pragma once

#include <juce_gui_basics/juce_gui_basics.h>
#include <juce_gui_extra/juce_gui_extra.h>
#include "BuchlaColors.h"

/**
 * XY Touch Controller (HT/VT - Horizontal Touch / Vertical Touch)
 * 
 * Features:
 * - 2D touch surface with X/Y position tracking
 * - Visual grid and cursor display
 * - Multi-touch support for complex gestures
 * - Configurable X/Y ranges and sensitivity
 * - Visual feedback with trail effects
 */
class TouchPad : public juce::Component
{
public:
    TouchPad();
    ~TouchPad() override;
    
    void paint(juce::Graphics& g) override;
    void resized() override;
    
    // Mouse/touch handling
    void mouseDown(const juce::MouseEvent& event) override;
    void mouseUp(const juce::MouseEvent& event) override;
    void mouseDrag(const juce::MouseEvent& event) override;
    
    // Callback for position changes
    using PositionCallback = std::function<void(float x, float y)>;
    void setPositionCallback(PositionCallback callback) { positionCallback = callback; }
    
    // Configuration
    void setXRange(float min, float max) { xMin = min; xMax = max; }
    void setYRange(float min, float max) { yMin = min; yMax = max; }
    void setGridVisible(bool visible) { showGrid = visible; repaint(); }
    void setTrailVisible(bool visible) { showTrail = visible; repaint(); }
    
    // Current position (normalized 0.0 - 1.0)
    juce::Point<float> getCurrentPosition() const { return currentPosition; }
    
    // Get mapped position in configured ranges
    juce::Point<float> getMappedPosition() const;

private:
    // Position state
    juce::Point<float> currentPosition{0.5f, 0.0f}; // Default: x=0.0 (center), y=0.0 (bottom)
    juce::Point<float> defaultPosition{0.5f, 0.0f}; // Reset position when touch ends
    bool isActive = false;
    
    // Configuration - X: 0.0 to 1.0, Y: 0.0 to 1.0
    float xMin = 0.0f, xMax = 1.0f;
    float yMin = 0.0f, yMax = 1.0f;
    bool showGrid = true;
    bool showTrail = true;
    
    // Visual trail
    struct TrailPoint
    {
        juce::Point<float> position;
        float age = 0.0f;
        float opacity = 1.0f;
    };
    
    std::vector<TrailPoint> trail;
    static const int maxTrailPoints = 20;
    
    // Callback
    PositionCallback positionCallback;
    
    // Touch tracking
    int primaryTouchId = -1;
    
    // Helper methods
    juce::Point<float> constrainPosition(const juce::Point<float>& pos);
    void updatePosition(const juce::Point<float>& newPos);
    void addTrailPoint(const juce::Point<float>& pos);
    void updateTrail();
    void drawGrid(juce::Graphics& g);
    void drawCursor(juce::Graphics& g);
    void drawTrail(juce::Graphics& g);
    
    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR(TouchPad)
};