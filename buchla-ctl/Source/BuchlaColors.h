#pragma once

#include <juce_graphics/juce_graphics.h>

/**
 * Color palette inspired by the Buchla 700 hardware interface
 * Dark theme with orange/amber accents for controls and displays
 */
namespace BuchlaColors
{
    // Background colors
    const juce::Colour background = juce::Colour(0xff1a1a1a);        // Very dark grey/black
    const juce::Colour panelBackground = juce::Colour(0xff2a2a2a);   // Slightly lighter panel background
    const juce::Colour controlBackground = juce::Colour(0xff3a3a3a); // Control background
    
    // LCD/Display colors
    const juce::Colour lcdBackground = juce::Colour(0xff0a0a0a);     // Deep black for LCD
    const juce::Colour lcdText = juce::Colour(0xffff9500);          // Bright orange text
    const juce::Colour lcdBorder = juce::Colour(0xff4a4a4a);        // Grey border
    
    // Touch controls
    const juce::Colour touchKeyOff = juce::Colour(0xff2a2a2a);      // Inactive touch key
    const juce::Colour touchKeyOn = juce::Colour(0xffff9500);       // Active touch key (orange)
    const juce::Colour touchKeyBorder = juce::Colour(0xff4a4a4a);   // Key border
    
    // Buttons and switches
    const juce::Colour buttonOff = juce::Colour(0xff3a3a3a);        // Inactive button
    const juce::Colour buttonOn = juce::Colour(0xffff6600);         // Active button (orange)
    const juce::Colour buttonText = juce::Colour(0xffffffff);       // Button text
    
    // Faders and knobs
    const juce::Colour faderTrack = juce::Colour(0xff4a4a4a);       // Fader track
    const juce::Colour faderThumb = juce::Colour(0xffff9500);       // Fader thumb (orange)
    const juce::Colour knobBody = juce::Colour(0xff5a5a5a);         // Knob body
    const juce::Colour knobPointer = juce::Colour(0xffff9500);      // Knob pointer (orange)
    
    // XY pad
    const juce::Colour xyPadBackground = juce::Colour(0xff1a1a1a);  // XY pad background
    const juce::Colour xyPadGrid = juce::Colour(0xff3a3a3a);        // Grid lines
    const juce::Colour xyPadCursor = juce::Colour(0xffff9500);      // Cursor (orange)
    
    // Text colors
    const juce::Colour labelText = juce::Colour(0xffcccccc);        // Light grey labels
    const juce::Colour valueText = juce::Colour(0xffffffff);        // White value text
    const juce::Colour highlightText = juce::Colour(0xffff9500);    // Orange highlight
    
    // Accents and highlights
    const juce::Colour accent = juce::Colour(0xffff9500);           // Primary orange accent
    const juce::Colour accentDark = juce::Colour(0xffcc7700);       // Darker orange
    const juce::Colour warning = juce::Colour(0xffff3300);          // Red for warnings
    const juce::Colour success = juce::Colour(0xff00ff66);          // Green for success
    
    // Special key colors
    const juce::Colour keyViolet = juce::Colour(0xff6E66A6);        // Blue-violet for special keys
    const juce::Colour keyJadeGreen = juce::Colour(0xff69A7A2);     // Jade green for normal keys
}