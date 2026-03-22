#pragma once

#include <juce_gui_basics/juce_gui_basics.h>
#include <juce_gui_extra/juce_gui_extra.h>
#include "BuchlaColors.h"

/**
 * Touch-sensitive keyboard component with 24 keys and Y-axis expression
 * 
 * Features:
 * - 24 touch-sensitive keys arranged horizontally
 * - Y-axis position detection for expression control
 * - Multi-touch support for polyphonic playing
 * - Visual feedback with key highlighting
 * - Configurable key range and velocity sensitivity
 */
class TouchKeyboard : public juce::Component
{
public:
    TouchKeyboard();
    ~TouchKeyboard() override;
    
    void paint(juce::Graphics& g) override;
    void resized() override;
    
    // Mouse/touch handling
    void mouseDown(const juce::MouseEvent& event) override;
    void mouseUp(const juce::MouseEvent& event) override;
    void mouseDrag(const juce::MouseEvent& event) override;
    
    // Callback for key events
    using KeyCallback = std::function<void(int keyIndex, float velocity, float yPosition)>;
    void setKeyCallback(KeyCallback callback) { keyCallback = callback; }
    
    // Configuration
    void setKeyRange(int numKeys) { 
        if (numKeys > 0 && numKeys <= maxKeys) 
            activeKeys = numKeys; 
        repaint();
    }
    
    // Key state
    struct KeyState
    {
        bool isPressed = false;
        float velocity = 0.0f;
        float yPosition = 0.5f; // 0.0 = bottom, 1.0 = top
        juce::Point<float> touchPosition;
        int touchId = -1;
    };
    
    const KeyState& getKeyState(int keyIndex) const { 
        return keyIndex < maxKeys ? keyStates[keyIndex] : keyStates[0]; 
    }

private:
    static const int maxKeys = 24;
    int activeKeys = 24;
    // MIDI note mapping: keys 0-14 -> MIDI 0-14, keys 15-23 -> MIDI 115-123
    
    std::array<KeyState, maxKeys> keyStates;
    KeyCallback keyCallback;
    
    // Visual properties
    float keyWidth = 0.0f;
    float keyHeight = 0.0f;
    
    // Touch handling
    struct TouchInfo
    {
        int keyIndex = -1;
        juce::Point<float> position;
        float velocity = 0.0f;
        float yPosition = 0.5f;
    };
    
    std::map<int, TouchInfo> activeTouches;
    
    // Helper methods
    int getKeyIndexForPosition(const juce::Point<float>& position);
    float calculateVelocity(const juce::Point<float>& position);
    float calculateYPosition(const juce::Point<float>& position);
    juce::Rectangle<float> getKeyBounds(int keyIndex);
    void updateKeyState(int keyIndex, bool isPressed, float velocity, float yPosition, int touchId);
    void drawKey(juce::Graphics& g, int keyIndex, const juce::Rectangle<float>& bounds);
    
    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR(TouchKeyboard)
};
