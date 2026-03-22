# BuchlaControl - Buchla 700 Style OSC Controller

BuchlaControl is an iPad application that provides a touch-based interface for controlling the Buchla 700 emulator over OSC (Open Sound Control). It emulates the look and feel of the iconic Buchla 700 hardware interface.

## Features

### Touch Controls
- **24 Touch Keys**: Keys with Y-axis expression control
  - Keys 0-14 map to MIDI notes 0-14
  - Keys 15-23 map to MIDI notes 115-123
  - Real-time Y-position feedback for expression control

- **XY Controller**: 2D touch pad for HT/VT (Horizontal Touch / Vertical Touch) control
  - Visual grid and cursor display
  - Trail effects for gesture visualization
  - Configurable X/Y ranges

### Interface Elements
- **14 Multipurpose Buttons**: Toggle buttons for various control functions
- **14 Data Faders**: Bar-graph faders with labels matching LCD display data
- **Tempo Controls**: Tempo multiplier and time scaling knobs

### Visual Design
- **Buchla 700 Aesthetic**: Dark theme with orange/amber accents
- **Responsive Layout**: Optimized for iPad landscape orientation
- **Real-time Feedback**: Visual feedback for all touch interactions

## OSC Communication

### Outgoing Messages (to Buchla 700 emulator)
- `/taucontrol/key/on [midiNote] [velocity] [yPosition]` - Key press with expression
- `/taucontrol/key/off [midiNote] 0.0 0.0` - Key release
- `/taucontrol/button [buttonIndex] [state]` - Button state change
- `/taucontrol/fader [faderIndex] [value]` - Fader position change
- `/taucontrol/xy [x] [y]` - XY controller position
- `/taucontrol/tempo [multiplier]` - Tempo multiplier change
- `/taucontrol/timescale [scaling]` - Time scaling change

### Incoming Messages (from Buchla 700 emulator)
- `/taucontrol/fader [faderIndex] [value]` - Fader position update
- `/taunus/lcd/row [row] [text]` - LCD row text update
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
   cd buchla-ctl
   cmake -B build_ios -G Xcode \
     -DCMAKE_SYSTEM_NAME=iOS \
     -DCMAKE_OSX_DEPLOYMENT_TARGET=15.0
   ```

2. **Open in Xcode**:
   ```bash
   open build_ios/BuchlaControl.xcodeproj
   ```

3. **Configure iPad Deployment**:
   - Set target device to iPad
   - Configure development team and signing
   - Set deployment target to iOS 15.0+

4. **Build and Deploy**:
   - Build and run on iPad device or simulator

## Configuration

### Network Setup
- Default connection: `127.0.0.1:9001` (send) / `9002` (receive)
- Supports local network discovery of Buchla 700 emulator instances
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

## Integration with the Buchla 700 Emulator

To use BuchlaControl with the Buchla 700 emulator:

1. **Ensure both are on the same network**: The iPad running BuchlaControl and the machine running the emulator must be reachable via UDP.

2. **Message Routing**: BuchlaControl messages are routed to the emulator's OSC handler, which maps them to the appropriate parameters:
   - Key events → Voice triggering and note assignment
   - XY controller → Modulation sources (HT/VT)
   - Faders → Parameter control (dynamics, FM indices, etc.)
   - Buttons → Function switching, preset selection

3. **Feedback**: The emulator sends display updates (LCD text, bar graph values) back to BuchlaControl for visual feedback.

## License

GNU General Public License v3.0 — see [LICENSE](../LICENSE).

## Credits

Inspired by the Don Buchla 700 series synthesizers and their unique approach to electronic music control interfaces.
