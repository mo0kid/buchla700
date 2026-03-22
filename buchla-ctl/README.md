# TauControl - Buchla 700 Style OSC Controller

TauControl is an iPad application that provides a touch-based interface for controlling the Taunus synthesizer over OSC (Open Sound Control). It emulates the look and feel of the iconic Buchla 700 hardware interface.

## Features

### Touch Controls
- **24 Touch Keys**: Velocity-sensitive keys with Y-axis expression control
  - Keys 0-14 map to MIDI notes 0-14
  - Keys 15-23 map to MIDI notes 115-123
  - Real-time Y-position feedback for expression control

- **XY Controller**: 2D touch pad for HT/VT (Horizontal Touch / Vertical Touch) control
  - Visual grid and cursor display
  - Trail effects for gesture visualization
  - Configurable X/Y ranges

### Interface Elements
- **14 Multipurpose Buttons**: Toggle buttons for various control functions
- **14 Data Faders**: Vertical faders with labels matching LCD display data
- **Tempo Controls**: Tempo multiplier and time scaling knobs

### Visual Design
- **Buchla 700 Aesthetic**: Dark theme with orange/amber accents
- **Responsive Layout**: Optimized for iPad landscape orientation
- **Real-time Feedback**: Visual feedback for all touch interactions

## OSC Communication

### Outgoing Messages (to Taunus)
- `/taucontrol/key/on [midiNote] [velocity] [yPosition]` - Key press with expression
- `/taucontrol/key/off [midiNote] 0.0 0.0` - Key release
- `/taucontrol/button [buttonIndex] [state]` - Button state change
- `/taucontrol/fader [faderIndex] [value]` - Fader position change
- `/taucontrol/xy [x] [y]` - XY controller position
- `/taucontrol/tempo [multiplier]` - Tempo multiplier change
- `/taucontrol/timescale [scaling]` - Time scaling change

### Incoming Messages (from Taunus)
- `/taunus/param/column/[index] [value]` - Data column value update
- `/taunus/status [status]` - Connection status

## Building

### Requirements
- JUCE 7.x framework
- CMake 3.15+
- Xcode (for iOS/iPad deployment)
- iOS 13.0+ target

### Build Steps

1. **Configure for Xcode**:
   ```bash
   cd tauControl
   cmake . -B build -G Xcode
   ```

2. **Open in Xcode**:
   ```bash
   open build/TauControl.xcodeproj
   ```

3. **Configure iPad Deployment**:
   - Set target device to iPad
   - Configure development team and signing
   - Set deployment target to iOS 13.0+

4. **Build and Deploy**:
   - Build and run on iPad device or simulator

## Configuration

### Network Setup
- Default connection: `127.0.0.1:9001` (send) / `9002` (receive)
- Supports local network discovery of Taunus instances
- Configurable IP address and ports

### Display Layout
The interface is divided into sections matching the Buchla 700 layout:

```
┌─────────────────────────────────────────────────────────┐
│ Tempo Knobs    │                                        │
├────────────────┼────────────────────────────────────────┤
│                │    14 Multipurpose Buttons             │
│   XY           ├────────────────────────────────────────┤
│ Controller     │         14 Data Faders                 │
│                │                                        │
├────────────────┴────────────────────────────────────────┤
│              24 Touch Keys with Y Expression            │
└─────────────────────────────────────────────────────────┘
```

## Integration with Taunus

To use TauControl with the Taunus synthesizer:

1. **Add OSC Support to Taunus**: Taunus needs OSC receiver functionality to handle incoming messages from TauControl

2. **Message Routing**: TauControl messages should be routed to appropriate Taunus parameters:
   - Key events → Voice triggering and note assignment
   - XY controller → Modulation sources (HT/VT)
   - Faders → Parameter control (dynamics, FM indices, etc.)
   - Buttons → Function switching, preset selection

3. **Feedback**: Taunus can send display updates and parameter changes back to TauControl for visual feedback

## License

This project is part of the Taunus synthesizer suite and follows the same licensing terms.

## Credits

Inspired by the Don Buchla 700 series synthesizers and their unique approach to electronic music control interfaces.
