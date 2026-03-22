#include "TouchKeyboard.h"

TouchKeyboard::TouchKeyboard() { setWantsKeyboardFocus(false); }

TouchKeyboard::~TouchKeyboard() {}

void TouchKeyboard::paint(juce::Graphics &g) {
  // Background
  g.fillAll(BuchlaColors::controlBackground);

  // Calculate key dimensions
  keyWidth = static_cast<float>(getWidth()) / activeKeys;
  keyHeight = static_cast<float>(getHeight());

  // Draw keys
  for (int i = 0; i < activeKeys; ++i) {
    auto keyBounds = getKeyBounds(i);
    drawKey(g, i, keyBounds);
  }
}

void TouchKeyboard::resized() {
  keyWidth = static_cast<float>(getWidth()) / activeKeys;
  keyHeight = static_cast<float>(getHeight());
}

void TouchKeyboard::mouseDown(const juce::MouseEvent &event) {
  auto position = event.position;
  int keyIndex = getKeyIndexForPosition(position);

  if (keyIndex >= 0 && keyIndex < activeKeys) {
    TouchInfo touchInfo;
    touchInfo.keyIndex = keyIndex;
    touchInfo.position = position;
    touchInfo.velocity = calculateVelocity(position);
    touchInfo.yPosition = calculateYPosition(position);

    int touchId = event.source.getIndex();
    activeTouches[touchId] = touchInfo;

    updateKeyState(keyIndex, true, touchInfo.velocity, touchInfo.yPosition,
                   touchId);

    if (keyCallback) {
      // Convert keyIndex to proper MIDI note
      int midiNote;
      if (keyIndex < 14) {
        midiNote = keyIndex; // Keys 1-14 (keyIndex 0-13) map to MIDI notes 0-13
      } else {
        midiNote = 114 + (keyIndex - 14); // Keys 15-24 (keyIndex 14-23) map to MIDI notes 114-123
      }
      keyCallback(midiNote, touchInfo.velocity, touchInfo.yPosition);
    }
  }
}

void TouchKeyboard::mouseUp(const juce::MouseEvent &event) {
  int touchId = event.source.getIndex();
  auto it = activeTouches.find(touchId);
  if (it != activeTouches.end()) {
    int keyIndex = it->second.keyIndex;
    activeTouches.erase(it);

    // Check if any other touches are still active on this key
    bool stillPressed = false;
    for (const auto &pair : activeTouches) {
      if (pair.second.keyIndex == keyIndex) {
        stillPressed = true;
        break;
      }
    }

    if (!stillPressed) {
      updateKeyState(keyIndex, false, 0.0f, 0.5f, -1);

      if (keyCallback) {
        // Convert keyIndex to proper MIDI note for note off
        int midiNote;
        if (keyIndex < 14) {
          midiNote = keyIndex; // Keys 1-14 (keyIndex 0-13) map to MIDI notes 0-13
        } else {
          midiNote = 114 + (keyIndex - 14); // Keys 15-24 (keyIndex 14-23) map to MIDI notes 114-123
        }
        keyCallback(midiNote, 0.0f, 0.5f); // Note off
      }
    }
  }
}

void TouchKeyboard::mouseDrag(const juce::MouseEvent &event) {
  int touchId = event.source.getIndex();
  juce::Logger::writeToLog("TouchKeyboard::mouseDrag touchId=" + juce::String(touchId) + " y=" + juce::String(event.position.y, 1));
  auto it = activeTouches.find(touchId);
  if (it != activeTouches.end()) {
    auto &touchInfo = it->second;
    touchInfo.position = event.position;

    int newKeyIndex = getKeyIndexForPosition(event.position);

    // Handle key changes (sliding between keys)
    if (newKeyIndex != touchInfo.keyIndex && newKeyIndex >= 0 &&
        newKeyIndex < activeKeys) {
      // Release old key if no other touches are on it
      bool oldKeyStillPressed = false;
      for (const auto &pair : activeTouches) {
        if (pair.first != touchId &&
            pair.second.keyIndex == touchInfo.keyIndex) {
          oldKeyStillPressed = true;
          break;
        }
      }

      if (!oldKeyStillPressed) {
        updateKeyState(touchInfo.keyIndex, false, 0.0f, 0.5f, -1);
        if (keyCallback) {
          // Convert keyIndex to proper MIDI note for note off
          int midiNote;
          if (touchInfo.keyIndex < 14) {
            midiNote = touchInfo.keyIndex; // Keys 1-14 (keyIndex 0-13) map to MIDI notes 0-13
          } else {
            midiNote = 114 + (touchInfo.keyIndex - 14); // Keys 15-24 (keyIndex 14-23) map to MIDI notes 114-123
          }
          keyCallback(midiNote, 0.0f, 0.5f); // Note off
        }
      }

      // Press new key
      touchInfo.keyIndex = newKeyIndex;
      touchInfo.velocity = calculateVelocity(event.position);
      touchInfo.yPosition = calculateYPosition(event.position);

      updateKeyState(newKeyIndex, true, touchInfo.velocity, touchInfo.yPosition,
                     touchId);

      if (keyCallback) {
        // Convert keyIndex to proper MIDI note
        int midiNote;
        if (newKeyIndex < 14) {
          midiNote = newKeyIndex; // Keys 1-14 (keyIndex 0-13) map to MIDI notes 0-13
        } else {
          midiNote = 114 + (newKeyIndex - 14); // Keys 15-24 (keyIndex 14-23) map to MIDI notes 114-123
        }
        keyCallback(midiNote, touchInfo.velocity, touchInfo.yPosition);
      }
    } else if (newKeyIndex == touchInfo.keyIndex) {
      // Update expression on same key - send aftertouch instead of note-on
      touchInfo.yPosition = calculateYPosition(event.position);
      updateKeyState(touchInfo.keyIndex, true, touchInfo.velocity,
                     touchInfo.yPosition, touchId);

      if (keyCallback) {
        // Convert keyIndex to proper MIDI note
        int midiNote;
        if (touchInfo.keyIndex < 14) {
          midiNote = touchInfo.keyIndex; // Keys 1-14 (keyIndex 0-13) map to MIDI notes 0-13
        } else {
          midiNote = 114 + (touchInfo.keyIndex - 14); // Keys 15-24 (keyIndex 14-23) map to MIDI notes 114-123
        }
        // Send aftertouch: use negative velocity to indicate aftertouch message
        keyCallback(midiNote, -1.0f, touchInfo.yPosition);
      }
    }
  }
}

int TouchKeyboard::getKeyIndexForPosition(const juce::Point<float> &position) {
  if (position.x < 0 || position.x >= getWidth() || position.y < 0 ||
      position.y >= getHeight())
    return -1;

  int keyIndex = static_cast<int>(position.x / keyWidth);
  return juce::jlimit(0, activeKeys - 1, keyIndex);
}

float TouchKeyboard::calculateVelocity(const juce::Point<float> &position) {
  juce::ignoreUnused(position);
  // For now, return a fixed velocity
  // Could be enhanced to use touch pressure or initial impact velocity
  return 0.8f;
}

float TouchKeyboard::calculateYPosition(const juce::Point<float> &position) {
  if (keyHeight <= 0)
    return 0.5f;

  // Invert Y axis: top = 1.0, bottom = 0.0
  float yPos = 1.0f - (position.y / keyHeight);
  return juce::jlimit(0.0f, 1.0f, yPos);
}

juce::Rectangle<float> TouchKeyboard::getKeyBounds(int keyIndex) {
  float x = keyIndex * keyWidth;
  return juce::Rectangle<float>(x, 0, keyWidth, keyHeight);
}

void TouchKeyboard::updateKeyState(int keyIndex, bool isPressed, float velocity,
                                   float yPosition, int touchId) {
  if (keyIndex >= 0 && keyIndex < maxKeys) {
    auto &state = keyStates[keyIndex];
    state.isPressed = isPressed;
    state.velocity = velocity;
    state.yPosition = yPosition;
    state.touchId = touchId;

    repaint(getKeyBounds(keyIndex).toNearestInt());
  }
}

void TouchKeyboard::drawKey(juce::Graphics &g, int keyIndex,
                            const juce::Rectangle<float> &bounds) {
  const auto &state = keyStates[keyIndex];

  // Determine key base color based on key number (1-based display)
  int displayKeyNumber = keyIndex + 1;
  bool isVioletKey = (displayKeyNumber == 1 || displayKeyNumber == 2 || displayKeyNumber == 3 ||
                      displayKeyNumber == 8 || displayKeyNumber == 9 || displayKeyNumber == 10 ||
                      displayKeyNumber == 15 || displayKeyNumber == 16 || displayKeyNumber == 17 ||
                      displayKeyNumber == 22 || displayKeyNumber == 23 || displayKeyNumber == 24);
  
  juce::Colour baseColour = isVioletKey ? BuchlaColors::keyViolet : BuchlaColors::keyJadeGreen;
  
  // Key fill color based on state
  juce::Colour fillColour = state.isPressed ? baseColour.brighter(0.3f) : baseColour.darker(0.4f);

  // Add Y-position visualization if key is pressed
  if (state.isPressed) {
    // Blend color based on Y position
    float yIntensity = state.yPosition;
    fillColour = fillColour.interpolatedWith(BuchlaColors::accent, yIntensity * 0.3f);
  }

  // Draw key background
  auto keyRect = bounds.reduced(1.0f);
  g.setColour(fillColour);
  g.fillRoundedRectangle(keyRect, 4.0f);

  // Draw key border
  g.setColour(BuchlaColors::touchKeyBorder);
  g.drawRoundedRectangle(keyRect, 4.0f, 1.0f);

  // Draw Y-position indicator if pressed
  if (state.isPressed) {
    float indicatorY =
        keyRect.getBottom() - (state.yPosition * keyRect.getHeight());
    auto indicatorRect = juce::Rectangle<float>(
        keyRect.getX() + 2, indicatorY - 1, keyRect.getWidth() - 4, 2);

    g.setColour(BuchlaColors::highlightText);
    g.fillRect(indicatorRect);
  }

  // Draw key number
  g.setColour(state.isPressed ? BuchlaColors::background
                              : BuchlaColors::labelText);
  g.setFont(12.0f);
  g.drawText(juce::String(keyIndex + 1), keyRect,
             juce::Justification::centredTop, true);

  // Draw MIDI note number using Buchla 700 note range
  int midiNote;
  if (keyIndex < 14) {
    // Keys 1-14 (keyIndex 0-13) map to MIDI notes 0-13
    midiNote = keyIndex;
  } else {
    // Keys 15-24 (keyIndex 14-23) map to MIDI notes 114-123
    midiNote = 114 + (keyIndex - 14);
  }

  g.setFont(10.0f);
  g.drawText(juce::String::formatted("%03d", midiNote), keyRect,
             juce::Justification::centredBottom, true);
}
