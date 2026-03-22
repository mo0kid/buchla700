#pragma once

#include "BuchlaColors.h"
#include <juce_gui_basics/juce_gui_basics.h>

/**
 * Jog/shuttle fader: touch position relative to the fader handle controls
 * the speed and direction of value change.  Touch at handle = no movement,
 * above = value increases, below = decreases.  The handle keeps moving past
 * the touch point because the reference is fixed at the handle's position
 * at the moment of touch-down.
 */
class RelativeFader : public juce::Slider, private juce::Timer {
public:
  enum FaderType {
    OffsetFader, // 0.5 = neutral
    GainFader    // 0.0 = neutral
  };

  static constexpr float jogDeadzone   = 0.03f;  // dead zone around handle
  static constexpr float jogMaxSpeed   = 0.016f;  // full range in ~1s at 60Hz
  static constexpr float jogSpeedRange = 0.47f;   // displacement for full speed
  static constexpr int   jogTimerHz    = 60;
  static constexpr int   jogGuardTicks = 15;       // ~250ms guard after release

  RelativeFader(SliderStyle style = LinearVertical,
                TextEntryBoxPosition textBoxPosition = NoTextBox)
      : juce::Slider(style, textBoxPosition), faderType(GainFader) {}

  ~RelativeFader() override { stopTimer(); }

  void setFaderType(FaderType type) { faderType = type; }

  /* true while finger is down, or briefly after release to let
   * the emulator's bar-graph polling catch up to the final value */
  bool isJogActive() const { return jogActive || releaseGuard > 0; }

  void mouseDown(const juce::MouseEvent &event) override {
    /* speed/direction is based on touch displacement from the midpoint —
     * above midpoint = value increases, below = decreases */
    double range = getMaximum() - getMinimum();
    jogRefNorm = 0.5f;
    jogCurrentNorm = (range > 0.0) ? (float)((getValue() - getMinimum()) / range)
                                   : 0.0f;
    jogTouchNorm = normalizedY(event);
    jogActive = true;
    releaseGuard = 0;
    startTimerHz(jogTimerHz);
    setMouseCursor(juce::MouseCursor::DraggingHandCursor);
    repaint();
  }

  void mouseDoubleClick(const juce::MouseEvent &) override {
    /* prevent JUCE's default double-click reset */
  }

  void mouseDrag(const juce::MouseEvent &event) override {
    jogTouchNorm = normalizedY(event);
  }

  void mouseUp(const juce::MouseEvent & /*event*/) override {
    jogActive = false;
    releaseGuard = jogGuardTicks;
    setValue(getValue(), juce::sendNotificationSync);
    setMouseCursor(juce::MouseCursor::NormalCursor);
    repaint();
  }

  void timerCallback() override {
    if (releaseGuard > 0) {
      if (--releaseGuard == 0)
        stopTimer();
      return;
    }

    if (!jogActive) return;

    float speed = jogSpeed(jogTouchNorm);
    if (speed == 0.0f) { repaint(); return; }

    /* accumulate on our own position — immune to JUCE/emulator
     * value overrides, so the handle always moves past the touch */
    jogCurrentNorm += speed;
    jogCurrentNorm = juce::jlimit(0.0f, 1.0f, jogCurrentNorm);

    double range = getMaximum() - getMinimum();
    double newValue = getMinimum() + (double)jogCurrentNorm * range;
    setValue(newValue, juce::sendNotificationSync);
    repaint();
  }

  void paint(juce::Graphics &g) override {
    auto bounds = getLocalBounds().toFloat().reduced(2.0f);
    auto barWidth = bounds.getWidth();
    auto barHeight = bounds.getHeight();

    // Dark background
    g.setColour(juce::Colour(0xff1a1a1a));
    g.fillRoundedRectangle(bounds, 3.0f);

    // Border
    g.setColour(juce::Colour(0xff3a3a3a));
    g.drawRoundedRectangle(bounds, 3.0f, 1.0f);

    // Current value as 0-1
    auto range = getMaximum() - getMinimum();
    float val = (range > 0.0) ? (float)((getValue() - getMinimum()) / range)
                              : 0.0f;

    float midY = bounds.getY() + barHeight * 0.5f;

    // Filled bar
    if (faderType == OffsetFader) {
      // Offset: fill from midpoint toward value
      float valY = bounds.getY() + (1.0f - val) * barHeight;
      float top = std::min(valY, midY);
      float bot = std::max(valY, midY);
      auto fillRect = juce::Rectangle<float>(
          bounds.getX(), top, barWidth, bot - top);
      g.setColour(BuchlaColors::accent.withAlpha(0.85f));
      g.fillRect(fillRect);
    } else {
      // Gain: fill from bottom up to value
      float valY = bounds.getY() + (1.0f - val) * barHeight;
      auto fillRect = juce::Rectangle<float>(
          bounds.getX(), valY, barWidth, bounds.getBottom() - valY);
      g.setColour(BuchlaColors::accent.withAlpha(0.85f));
      g.fillRect(fillRect);
    }

    // Midpoint line
    g.setColour(juce::Colour(0x60ffffff));
    g.drawHorizontalLine((int)midY, bounds.getX(), bounds.getRight());

    // Value top-edge line (brighter bar cap)
    float capY = bounds.getY() + (1.0f - val) * barHeight;
    g.setColour(juce::Colour(0xc0ffffff));
    g.drawHorizontalLine((int)capY, bounds.getX() + 1.0f,
                         bounds.getRight() - 1.0f);

    // Touch-position indicator while jogging
    if (jogActive) {
      float touchY = bounds.getY() + (1.0f - jogTouchNorm) * barHeight;
      g.setColour(juce::Colour(0x60ff8800));
      g.drawHorizontalLine((int)touchY, bounds.getX(), bounds.getRight());
    }
  }

private:
  FaderType faderType;
  float jogTouchNorm   = 0.5f;   // current touch position (0=bottom, 1=top)
  float jogRefNorm     = 0.0f;   // handle position at touch-down (jog reference)
  float jogCurrentNorm = 0.0f;   // accumulated jog position (independent of Slider value)
  bool  jogActive      = false;
  int   releaseGuard = 0;

  // Convert pixel Y to normalized 0-1 (bottom=0, top=1)
  float normalizedY(const juce::MouseEvent &event) {
    float y = 1.0f - (float)event.getPosition().getY() / (float)getHeight();
    return juce::jlimit(0.0f, 1.0f, y);
  }

  // Speed based on touch displacement from the handle's touch-down position
  float jogSpeed(float touch) {
    float d = touch - jogRefNorm;
    if (d > -jogDeadzone && d < jogDeadzone) return 0.0f;
    if (d > 0.0f) d -= jogDeadzone; else d += jogDeadzone;
    float norm = d / jogSpeedRange;
    norm = juce::jlimit(-1.0f, 1.0f, norm);
    return norm * std::abs(norm) * jogMaxSpeed;  // quadratic
  }

  JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR(RelativeFader)
};
