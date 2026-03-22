# Buchla 700 User's Guide

**© 1989 Buchla and Associates**
Permission granted to duplicate and distribute by any and all means.

---

## Revision History

| Rev | Date |
|-----|------|
| 0 | Jan 1, 1988 |
| 1 | April 19, 1988 |
| 2 | May 19, 1988 |
| 3 | June 20, 1988 |
| 4 | July 19, 1988 |
| 5 | August 29, 1988 |
| 6 | December 15, 1988 |
| 7 | Jan 17, 1989 |

This revision is for use with MIDAS VII version 890111.01 or higher.

### Development Status Notation

Braces in the original manual indicate various uncertainties:
- `{single braces}` — function not implemented
- `{{double braces}}` — function may be changed
- `{{{triple braces}}}` — function has a bug

---

## 1.00 Setup

### What's in the Box

- This instruction manual
- 1 diskette
- 1 A.C. power cord

### Physical Connections

All connectors are located on the **rear panel** except for the headset connector on the front.

1. **Power**: Plug the A.C. power cord into an appropriate receptacle
2. **Audio Outputs**: Standard 1/4" phone jacks; output level is about 1 volt
3. **Headphones**: Medium or high impedance headsets plug into front-mounted stereo jack
4. **Video Monitor**: EGA or Multisync monitor required
   - Requires adapter cord for IBM computer connection
   - Configure for EGA display: digital, TTL levels, 64 colors, 21.8 kHz scan frequency
5. **MIDI**: Connect a MIDI source to the MIDI 1 input

Additional connections are possible but unnecessary for initial familiarization.

---

## 2.00 Loading a Program

1. Power on the system (power switch: upper left corner of front panel)
2. Remove the dummy diskette
3. Insert the program diskette into the drive (right side of instrument)
4. Press the **first green switch** (immediately right of the "scroll" controller) to initiate loading
5. The program's name and version number will appear with a menu of possibilities
6. Adjust monitor if necessary and proceed to the relevant section

---

## 3.00 MIDAS VII Introduction

**MIDAS VII** is an advanced high-level music language designed to provide the Buchla 700 user with a facility for characterizing, performing, and interacting with the instrument. It is a "user friendly" language requiring no programming experience or computer expertise.

MIDAS VII is a **comprehensive** language — while simple musical tasks are easily accomplished, the language is far from trivial, and as experience and musical desires escalate, MIDAS VII will accommodate increasingly sophisticated instrumental and musical concepts.

MIDAS VII consists of several functional units, each with its own display and purpose, and all sharing common editing procedures and modes of access.

---

## 4.00 Fetching with the Librarian

The MIDAS librarian stores and retrieves various sorts of data to and from disks.

### Cursor Basics

1. Place your finger toward the center of the **cursor pad** (a 2" square above keys 21 and 22)
2. Practice moving the cursor (a small arrow) around the video screen
3. Position the cursor in the box labeled "Librarian" and press the **E** key (right of cursor pad)
4. This is a common procedure for accessing information in MIDAS VII

### Diskette Contents

The provided diskette contains:
- Sample orchestras (collections of instruments)
- A score
- Collections of assignment tables, waveshape tables, and tuning tables

To view the disk's contents, move the cursor to "Index" and press **E**.

### Orchestra Organization

The 700 stores **40 instrument definitions** in internal memory, organized into two banks:
- **Lo orchestra**: Instruments 1–20
- **Hi orchestra**: Instruments 21–40

Each orchestra record on disk contains 20 instruments. The lower left field in the display determines where instruments go when fetched from disk. To change this field, position the cursor on "Lo/Hi orch" and toggle with **E**.

### Loading an Orchestra

1. Set field to "Lo orch"
2. Move cursor to the desired record (e.g., "Orchestra Tutorial")
3. Press **E**, confirm that the highlighted record is correct
4. Press **E** again, wait for load to complete
5. Press **M** to return to main menu (**M** works from any MIDAS display)

---

## 5.00 The Instrument Designer

The sonic output of the 700 is defined with the **instrument designer**. Here you:
- Specify time-varying functions (envelopes) for each variable
- Select waveshapes
- Determine the effect of performance gestures on sound
- Configure the elements that make up a voice

### 5.05 Voice Architecture

#### Oscillators
- Up to **4 oscillators** per voice
- Can contribute directly to output, modulate other elements, or both
- Pitches individually determined or tracking each other at any desired interval

#### DCAs (Digitally Controlled Amplifiers)
- **6 DCAs** per voice establish amplitudes and modulation intensities
- 6 corresponding **indices** control their gain

#### Three Types of Modulation
1. **A.M.** — Amplitude Modulation
2. **F.M.** — Frequency Modulation
3. **T.M.** — Timbre Modulation (unique to Buchla instruments)

#### Signal Path

```
Oscillators + DCAs → 2 Waveshape Tables → 24 dB/oct Filter → VCA → Output
                                                                    ↓
                                                          Location, Dynamics,
                                                          Equalization, Aural Excitation
```

The instrument editor is finished with a signal once it exits the VCA. The output section handles location, dynamics, equalization, and aural excitation.

### 5.10 Library Structure

The 700 employs a hierarchical library structure:

```
                    ┌─────────────────────┐
                    │   ACTIVE VOICES     │
                    │   (12 instruments)  │
                    └──────┬──────────────┘
                      arbitrary assignments
                    ┌──────┴──────────────┐
      ┌─────────────┤ INSTRUMENT LIBRARY  ├──────────┐
      │             │                     │          │
┌─────┴─────┐  ┌───┴───────┐  ┌─────────┴────┐    │
│ Hi orch   │  │ Lo orch   │  │ Default (0)  │    │
│ (21-40)   │  │ (1-20)    │  │ play only    │    │
└─────┬─────┘  └─────┬─────┘  └──────────────┘    │
      │  blocks of   │                             │
      │  20 only     │                             │
      └──────┬───────┘                             │
        ┌────┴────┐                                │
        │DISK FILE│                                │
        │(20 inst)│                                │
        └─────────┘
```

- **Default instrument** (number 0): Can't be edited, replaced, or stored — only played
- **12 voice slots**: One per voice; these are the instruments you can hear and edit
- Instruments can be copied between library and voices
- Disk only communicates with the library, in groups of 20

#### Voice Operations

From the main menu, call the instrument designer by positioning the cursor and pressing **E**.

- **Change voice**: Enter number (1–12) in voice field, press **E**
- **Fetch from library**: Select number (1–40), position cursor on "Fetch from library", press **E**
- **Copy to library**: Position cursor on "Copy to library", press **E**
- **View library names**: Position cursor on "Inst", press **E** (repeat to return)

A **red instrument number** warns that the current instrument is not stored in the library. Save it by copying to an appropriate slot.

#### Edit Mode

- Activate the **edit switch** (upper left panel) for monophonic auditioning
- Normally editing and auditioning apply to the group to which the selected voice is assigned (see section 9.10 for "group" explanation)
- Toggle off (LED off) for polyphonic mode

### 5.15 Instrument Configuration

**12 configurations** define the interconnection of oscillators, DCAs, and waveshape tables.

To change configuration: enter the desired number (1–12) and press **E**.

**Configuration diagram symbols:**
- **Circles** — Oscillators
- **Triangles** — DCAs
- **Squares** — Waveshape tables

**DCA routing in diagrams:**
- DCAs connected to the **bottom** of oscillators → **F.M.**
- DCAs pointing to the **sides** of other DCAs → **T.M.**
- Signals always exit through waveshape tables **A** and/or **B**

**View all configurations:** Position cursor on "Config", press **E**. Change by entering desired numbers. Return to instrument display by positioning cursor on "Configuration" and pressing **E**.

### 5.20 Waveshape Tables

- **Library of 20 waveshape tables** available
- Created/modified with the waveshape editor (section 7.00)
- Incorporated into instruments by entering desired waveshape numbers

**To view the waveshape library:**
1. Position cursor on "Wavshpe", press **E**
2. First 12 waveshapes appear; last 8 accessed via "Page"
3. Return to instrument display by entering "Waveshape"

### 5.25 Envelopes

The upper half of the display establishes static or time-varying values (envelopes) for the **13 parameters** that affect the sound of a voice.

**Parameters with independent envelopes:**
- 4 oscillator pitches (Freq 1–4)
- 6 indices (Index 1–6)
- Filter cutoff frequency
- Stereo location
- VCA level

**Envelope characteristics:**
- Connected time-value points called **segments**
- Maximum **128 total points** across all 13 envelopes
- Value range: **0 to 10**
- Time range: **0.001 to 32 seconds**
- Plotted with **exponential time scale** (emphasizes onset detail while still displaying activity seconds later)

#### Editing Envelopes

**Access:** Position cursor in the appropriate box, press **E**. The level envelope is simultaneously displayed at subdued intensity for reference.

**Default values:**
- Indices and level: **0**
- Oscillator frequencies, filter frequency, and location: **5.0**
- Filter resonance: **0** (range 0–9, displayed alongside filter frequency envelope)

**Graphical editing:**
1. Locate cursor near desired point (closer horizontally than to any other point)
2. Press **E** — cursor turns flaming pink
3. Drag the point to its intended location
4. Press **E** to disengage
5. Points must remain **sequential** — you cannot move point 1 to the right of point 2

**Creating new points:**
1. Press **+** key while cursor is in the main edit window
2. New point appears adjacent to last point in the function
3. Drag to position
4. For a succession: press **+** for each new point, press **E** when done with the last

**Text-based editing:**
- Enter point number in the "Pt" field
- Enter desired time and value in their respective fields
- Sequence must be preserved

**Deleting points:**
- Enter a point number in the "Pt" field and press **X**
- The selected point and all subsequent points are deleted

### 5.30 Conditional Actions

Normally, a function proceeds from point 0 to the largest numbered point, then stops. **Conditional actions** associated with specific points can alter this:

| Action | Effect |
|--------|--------|
| Sustain | Pause if key down at a particular point |
| Jump | Proceed or jump backwards/forwards a specified number of times |
| Key state | Continue until initiating key changes state (↑ = released, ↓ = active) |
| GoTo with random | Numbers >89: entering 9 in 1st digit produces "R"; 2nd digit sets upper limit |

**Programming a conditional action:**
1. Select the point where the action is to occur
2. Position cursor in the left side of the "conditional action" field (first 6 characters)
3. Press **+** or **-** until the desired action appears
4. Press **E**
5. Enter further data into data field(s)
6. **Delete action:** Use **+**/**-** to select a blank field, press **E**

**Note:** When jumping to a point, the interpolation time is the time programmed for the segment that precedes that point. To reduce this while preserving the function's shape, add a dummy point as the jump's destination.

### 5.35 Function Start Modes

Functions are normally started by key closure or other stimulus that calls the voice. Alternatively, a function may be initiated by attaching the instrument to a voice; in this mode it will **not** respond to key closures.

To change function start mode: position the cursor in the function display box and press **-**. A white legend indicates **key start on**; gray indicates **key start off**.

### 5.40 Sources and Multipliers

Much of the expressive potential depends on establishing relationships between a musician's gestures and the instrument's acoustic response. These relationships are created by directing **sources** to influence variables by certain degrees called **multipliers**.

To view a sub-menu of possible sources, position the cursor in the far left "source" field and press **E**.

#### The Nine Sources

The sources assume different meanings depending on the controller type:

| Source | MIDI Controller | Local (700's Touch Keyboard) |
|--------|----------------|------------------------------|
| 1 | Pitch wheel | X-Y tablet horizontal axis |
| 2 | Modulation wheel | X-Y tablet vertical axis |
| 3 | Breath controller | Longpot |
| 4 | GPC/V1 (general purpose controller) | Control voltage input #1 (rear panel) |
| 5 | Pch/Frq (derived from sounding pitch) | Pch/Frq |
| 6 | Key vel (key velocity) | — (no meaning locally) |
| 7 | Key Prs (key pressure / aftertouch) | Key Prs |
| 8 | Random | Random |
| 9 | Pedal 1 (foot pedal) | Pedal 1 |

**Pch/Frq details:**
- **Pch**: Increases linearly (fixed amount per interval)
- **Frq**: Increases exponentially (doubles each octave, significant at high pitches)

**Random source:**
- Bi-directional (positive and negative values with equal probability)
- Positive multiplier → **box distribution** (equal probability, -5 to +5)
- Negative multiplier → **pseudo-Gaussian distribution** (tails ending at -10 and +10)

**Pedal 1:** Analog input (0–10 volts) on rear panel. Under MIDI control, looks at controller #4 unless reassigned in the assignment table.

#### General vs. Point Sources

**General sources** (far left fields): Activated on the next key closure, then operate continuously, affecting the parameter independently of the function's progress in time.

**Point sources** (fields to the right of the "value" field): Affect only the point in the function to which they are attached. The value is derived from the source at the beginning of the segment preceding the point, and its influence is zero by the end of the subsequent segment.

**Net effect:** A specific point's value can be determined or modified by a source. Multiple sources can influence different points in varying degrees.

Points with sources or conditional actions are displayed in **yellow** in the graphic representation.

**Delete sources:** Position cursor in the source field and type **X**.

### 5.45 Oscillator Pitch Specification

The four oscillator pitches can be specified in several ways:

| Type | Description | Range |
|------|-------------|-------|
| **Frequency** | Fixed frequency, ignores controller and tuning table | 0 to 15.9 Hz |
| **Pitch** | Fixed pitch from pedal C to C9 | 16.35 Hz to 8372 Hz |
| **Interval** | Oscillator 1 sounds the tuning table pitch offset by the interval; oscillators 2–4 track osc 1 with declared offset | In cents (1 cent = 1/100 semitone) |
| **Ratio** | Like interval, but as a fraction | e.g., 4/3 = perfect fourth |

**Oscillator data entry:**
1. Position cursor in a type field (immediately right of oscillator numbers)
2. Scroll with **+** key, press **E** when desired type appears
3. Move cursor to data field, enter desired data

**Pitch entry:**
- Octave (0–9), note (A–G#)
- Sharps: **9** or **+** key
- Flats: **8** or **-** key
- Naturals: **7** key
- Positive displacement in cents follows

**Phase sync:** Oscillators 1, 2, or 3 may be phase synchronized to oscillator 4 by entering **+** in the "s" field (displays as capital "S"). Unsync by entering **-**.

### 5.50 Naming Instruments

1. Position cursor at the first character of the **name** field
2. Press **E** — upper/lower case characters, digits, and symbols appear with a second cursor
3. Move the second cursor to desired character, press **E**, and repeat
4. Move cursor 1: position cursor 2 on one of the lines surrounding the `*`, press **E**
5. Add comments in similar fashion
6. When finished, enter an `*` to escape the "conceptual typewriter"

### 5.55 Deleting Instruments

Position the cursor at the instrument number and press **X**.

---

## 6.00 The Front Panel

### 6.10 Upper Left Controls

| Control | Function |
|---------|----------|
| **Power** | Self-evident power switch |
| **Reset** | Initializes all parameters to nominal values, wipes all data. Awaits only one action: loading a new program. **Use sparingly.** |
| **Edit** | Restrains playing to only the currently displayed voice in the instrument designer. Different meanings in other displays. |
| **Display Intensity** | Adjusts LCD contrast for ambient light/viewing angle |
| **Voice Activity** (12 LEDs) | Indicate level values for each of the 12 voices |

### 6.20 Performance Controls

| Control | Function |
|---------|----------|
| **Tempo Mult** | Modifies the indicated score tempo |
| **Time Scaling** | Compresses or expands envelopes and time-varying functions (except tempo) |
| **Fine Tuning** | Adjusts tuning of all voices by up to one semitone |
| **Amplitude** | Governs main output levels (not individual voice outputs) |

LEDs on the first three controls indicate exact centering for precise digital accuracy of tempo, time, and pitch.

### 6.30 LCD and Touch Controls

- **Scroll**: A conceptual flywheel for positioning the score display
- **14 touch switches**: Initiate various system actions and establish meanings of the 14 slide controls
- **14 slide controls**: Functions shown on LCD display
- The **LCD** shows switch functions (which may change) and current assignments/levels of slide controls

### 6.40 Data Entry Section

- **10 numeric keys**: For numeric data entry; also enter note names (A–G)
- **Cursor pad**: Large square for moving the cursor
- **X**: Delete
- **E**: Enter data
- **M**: Return to main menu

### 6.50 Performance Surface

| Element | Description |
|---------|-------------|
| **X-Y Tablet** | Large square, performance joystick. Assignable as an instrument "source" for control of variables. |
| **24 Performance Keys** | Row of keys that serve as a "local" controller. When designated, keys 1–24 map into the tuning table as MIDI inputs (see section 8.20). |
| **Longpot** | Located immediately above the 24 keys. Another performance source. |
| **LEDs** | Dots above the longpot serve as status indicators (including step entry of score notes) |
| **Magnetic Strip** | Replaceable strip below the keys for labeling |

### 6.60 LCD Functions

The LCD is used in conjunction with the 14 touch switches, 14 slide controls, and 24 keys. The top row of the LCD comprises labels for the 14 switches. From left to right:

**"Quiet"** — Resets system variables to default values. Use to clear a hung note.

**"ROMP"** — Debugging aid for Buchla and Associates. Kills the program; requires reloading MIDAS from disk.

**Lamp** — The LCD is illuminated by an electroluminescent lamp (about 10,000 hours to half brightness). Touch switches and slide controls turn the lamp on; it extinguishes after 2.5 minutes. Press "Lamp" to toggle constant-on mode (underlined when active).

**"Clock", "P/R", "Go To"** — Score-related functions (see section 10.00).

**"Instr"** — Alternate method of selecting instruments:
1. Press "Instr" — switch meanings change
2. Use first 12 switches to select target group(s) (initially all selected, shown by arrows)
3. Select instrument:
   - **Instrument 0** (default): Press 14th key ("Deflt")
   - **Instruments 1–20** (lo orch): Press corresponding performance key
   - **Instruments 21–40** (hi orch): Press 13th key first (adds offset of 20), then performance key
4. Press 13th key again to return to normal mode

**"Asgmt"** — Selects assignment tables (see section 9.70).

**"Load"** — Followed by a letter (A–G), loads similarly labeled files from the currently inserted disk without the librarian display (see section 13.40).

**"Other" (12th switch)** — Controls the slide control functions:
- Initially assigned to voice parameters (shown in LCD lower line)
- Settings are **added** to programmed values but **not stored** as part of instrument definitions
- **"Voice"**: Toggle numbered keys to select which voice(s) the controls address
- **"Init"**: Restores controls to their normal settings (zero offset)
  - Zero is **midpoint** for Locn, Freq, and Filtr; **bottom** for the rest
- Activate "Other" to attach slide controls to other system variables:
  - **"Aux"**: Controls modulation of external signal (section 9.25)
  - **"Depth", "Rate", "Intensity"**: Phase shift variables (section 9.35)
  - **"CV1,2,3,4"**: Set control voltages on rear panel for external voltage-controlled apparatus
- Press "Prmtr" (the switch's new label) to return to normal voice parameter mode

---

## 7.00 The Waveshape Editor

The 700's waveshaping capabilities contribute substantially to timbral range. Each voice can simultaneously address **two waveshape tables**; a total of **24** are active and directly associated with the 12 voices. Additionally, a library of **20 waveshape tables** may be stashed in memory.

**Note:** Waveshape tables become part of instrument definitions — changes in the library do not affect extant instruments.

### Waveshape Theory

Waveshape tables may be regarded as **transfer functions**. In conventional systems with phase angle inputs, their outputs are cyclic replicas of the stored waveforms. The 700 differs: it utilizes continuous input functions of varying amplitude and complexity, and the resultant output is a multidimensional function yielding particularly rich timbral possibilities.

Fundamentals in common with conventional methods:
- Steep transitions produce higher-order harmonics
- Rules of symmetry apply (odd vs. even harmonics)
- For a given input function, a table exists that will produce a desired harmonic structure

### 7.10 Creating Waveshapes

Access the waveshape editor from the main menu. Clear the displayed waveshape by locating the cursor in the waveshape field and pressing **X**. The resultant straight line (the simplest waveshape — what goes in comes out) can be modified several ways.

### 7.20 Moving Individual Points

1. Position cursor in the graphic field
2. Press **+** or **-** until a "0" appears in the "width" field
3. Locate cursor horizontally so it is aligned with a point
4. Press **E** — cursor ignites
5. Move the point vertically (the waveshape table updates when you pause)
6. Press **E** to disengage

**Brush width:** To influence adjacent points, press **E** to disengage, then press **+** or **-** to change "brush width". Larger numbers influence bigger chunks, with each increment doubling the number of points affected.

**Numeric entry:** Enter a number between 0 and 253 in the "point" field and the desired vertical coordinate in the "value" field (range -1023 to +1023).

### 7.30 Interpolation Method

Define points of inflection and have the computer "connect the dots":

1. With cursor in waveshape display, press **+** or **-** until "width" becomes **"interp"**
2. Define the first point: position cursor horizontally, press **E**, then locate vertically
3. Type **+** and position cursor at next desired inflection point
4. Repeat until all points are defined
5. Terminate by pressing **E** for the last point

### 7.40 Harmonic Coefficient Specification

1. Locate cursor under the desired harmonic number
2. Press **E**, then move the red arrow cursor up
3. A bar graph of harmonic coefficients appears with values between -100 and +100
4. The **magenta line** portrays the offset waveshape
5. The **green line** is the result of summing the offset with the harmonically defined waveshape
6. Negative values indicate 180 degree phase reversal (enter with **-** key)
7. Press **E** again to enter the data and disengage

### 7.50 Waveshape Library Operations

| Operation | Procedure |
|-----------|-----------|
| **Store to library** | Enter waveshape number (1–20), then enter "store" |
| **Fetch from library** | Enter waveshape number (1–20), then enter "fetch" |
| **View voice waveshape** | Enter number 1–12 and "A" or "B" in voice/slot fields |

The "instrument" field is read-only — it shows the instrument currently played by the indicated voice.

---

## 8.00 Tuning Tables

The 700 can be tuned to **any imaginable scale**. There are 128 possible key addresses produced by a MIDI controller, and for each, the 700 can produce a predetermined pitch.

- **10 tuning tables** in memory (numbered 0–9)
- **Table 0**: Default (non-modifiable)
- **Tables 1–9**: Editable, can be stored and retrieved as tuning table libraries

### 8.10 Tuning Table Editor

Access from the main menu. MIDI key numbers are displayed in subdued intensity followed by corresponding pitches.

**Pitch display format:**
- First digit: octave number (0–9)
- Followed by: note name (A–G) and accidental (flat, sharp, or blank)
- Subsequent two digits: cents added to the indicated note

Each semitone is divided into **100 cents** (100 cents per halfstep, 1200 cents per octave).

The note names in the far left column correspond to MIDI key numbers. **Key 60 is middle C**.

**Entering pitches:** Naturals (blanks) with **7**, flats with **8**, sharps with **9**.

### 8.20 Key Mapping

Pitches at the ends of the range (0C 00 and 9C 99) are displayed with subdued intensity.

- Standard 88-key MIDI keyboard transmits key numbers 21–108
- 5-octave (C–C) synthesizer usually produces key numbers 36–96

The 700's local keys are mapped into unused extremes of the MIDI range:
- **Keys 1–14** → MIDI 1–14
- **Keys 15–24** → MIDI 115–124

The default tuning table provides these keys with a range of 8 octaves in intervals of thirds — handy for auditioning over a wide pitch range.

### 8.30 Automated Tuning Operations

| Operation | Procedure |
|-----------|-----------|
| **Copy and transpose** | Illuminate "copy and transpose", enter transposition value (cents), select first and last note of source group, position cursor at destination, press **E** |
| **Increment** | Enter interval in value field, select beginning note, select ending point. Generates equal interval scales. |
| **Interpolate** | Select two notes at the ends of a range. MIDAS calculates intermediate notes automatically. |

### 8.40 Tuning Table Library

- **10 tables** (0–9), with 0 being the default (non-modifiable)
- **Fetch**: Enter table number, then "fetch"
- **Store**: Enter table number, then "store"

### 8.50 Naming Tuning Tables

Position cursor in the name field, press **E**, then use the "conceptual typewriter" to enter the desired name.

**View library:** Position cursor on "Table", press **E**. Repeat to return to tuning table display.

---

## 9.00 Assignment Tables

Assignment tables tell the 700 what instruments are to be played and who is going to play them. Voices are assembled into **groups**, and for each group: instrument numbers, dynamic levels, and MIDI channels are assigned. Keyboard splits are determined, MIDI controller numbers may be altered, and other variables established.

### 9.05 Default Table

Select the assignment table editor from the main menu. The default table (00) appears:
- **8 voices** assigned to **group 1**: Played by a MIDI keyboard on port 1, channel 1
- **4 remaining voices** assigned to **group 2**: Controlled by the local ("L") front panel keyboard
- Default instrument assigned to both groups, dynamic level of "6"
- All keys from the MIDI controller are active, no splits

### 9.10 Groups

Each of the 700's 12 voices is assigned an instrument to play. To simplify multi-timbral assignments, MIDAS organizes voices into **groups** (1 to 12 voices per group):

- Voices within a group are sounded **polyphonically** (in rotation)
- All play the **same instrument**
- Groups played simultaneously are sounded **in parallel**
- Each group has: dynamic levels, source of control, and optional key-to-group assignments (MIDI port 1)

### 9.15 Selecting Assignment Tables

- Enter table number, move cursor to "fetch", press **E**
- Or: MIDI program change command (port 1, channel 1 initially; channel configurable)
- Cancel program change feature by deleting the data field

**Front panel selection:** Press "Asgmt" key. An underlined number and one of 20 LEDs appear. Active table = sum of underlined number (multiple of 20) + number beneath illuminated LED. Select new table by pressing "Asgmt" until desired offset, then press the appropriate performance key. "Deflt" key selects table 00.

### 9.20 MIDI Output

The 700 can transmit MIDI codes from the MIDAS score. Enter port 1 or 2 in the "MIDI out" field; channel numbers are selected elsewhere.

### 9.25 Auxiliary Input Modulation

Voice 12 may modulate a signal applied to **auxiliary input 1**. Enable by positioning cursor in the "aux" field and pressing **E** (red "aux" = active). Toggle off by the same process.

Modulation depth is controlled from the front panel: activate "Other" and adjust the "Aux" control.

### 9.30 Tuning Table Selection

Select from the tuning table library by entering a number (0–9) in the "Tun" field. Table 0 is the default (non-modifiable). Enter "Tun" to view the current library; repeat to return.

### 9.35 Phase Shift

Sounds directed towards the center of the stereo output field can be **shifted in phase** to enhance their presence. The degree of phase shift is called **"intensity"**.

Modulation with variable "depth" and "rate" (0.1 to 5 Hz) may be applied to the phase shift. Parameters are set in the "phase shift" section (range 00 to 99) and may be varied from the front panel by pressing "Other" and manipulating "Depth", "Rate", and "Inten" controls.

### 9.40 Voice-to-Group Assignment

To be active, a voice must be assigned to a group. Assign groups by entering desired group numbers (1 to 12) in the "Gr" columns. De-activate voices by deleting associated group numbers.

### 9.45 MIDI-Transmitted Variables

| MIDI Variable | Abbreviation | MIDI CN |
|---------------|-------------|---------|
| Pitch wheel | "Pch" | — |
| Modulation wheel | "Mod" | 1 |
| Breath controller | "Brth" | 2 |
| General purpose controller | "GPC" | configurable |
| Foot pedal | "Pedal 1" | 4 |
| Key pressure (aftertouch) | "Key Prs" | — |

Each has a corresponding **front panel variable** (used when the voice is under local control):

| Panel Variable | Abbreviation |
|----------------|-------------|
| X-Y tablet horizontal | "Hor" |
| X-Y tablet vertical | "Vrt" |
| Longpot | "LP" |
| Control voltage input 1 (0–10V) | "CV1" |
| Foot pedal (rear panel) | "Pedal 1" |
| Key pressure | "Key Prs" |

Controller information applied to a group is derived from the MIDI device assigned to that group. To allow controller info from **any** MIDI port: position cursor on the source number (1–5) and press **E**; the highlighted number indicates the info can come from any port.

### 9.50 Group Configuration

Once a group is defined (by assigning voices to it):

- **"In" column**: Determines the instrument played by each group
- **"D" column**: Dynamic level for each group

**Dynamic levels** (with dynamic 6 = mf = 0 dB as standard):

| Level | dB | Marking |
|-------|-----|---------|
| 9 | +6 dB | fff |
| 8 | +4 dB | ff |
| 7 | +2 dB | f |
| 6 | 0 dB | mf |
| 5 | -2 dB | mp |
| 4 | -4 dB | p |
| 3 | -6 dB | pp |
| 2 | -9 dB | ppp |
| 1 | -12 dB | pppp |
| 0 | — | tacit |

**Controller origin column:**
- Numerals **1–3** refer to MIDI ports
- Letter **"L"** calls for local control (700's touch keyboard)
- Enter data using cursor + **+**/**-** + **E**

**MIDI channel:** If a channel number is entered in the "Ch" column, the voice responds only to that MIDI channel, and MIDI output from the score is directed to that channel.

**Legato mode:** For guitar controllers (single channel per string), position cursor on the group number and highlight with **E**. This produces pitch changes without restarting the note.

**View instrument library:** Position cursor on "In", press **E**; repeat to return.

### 9.55 Key-to-Group Matrix

The lower portion of the display contains a matrix relating keys to group numbers. When a key calls a group, the corresponding intersection is highlighted.

**Data entry:**
- Position cursor on desired intersection, press **E** twice
- For a string of adjacent keys: position at one end, press **E**, relocate to other end, press **E** again
- Entries to already activated positions toggle them off

**Note:** This facility applies only to **MIDI port 1**, and group data cannot be entered unless this assignment exists.

### 9.60 Storing Assignment Tables

- **99 tables** can be stored in the library (0 = default, non-modifiable)
- Store: Enter number in "Asgnmnt" field, then "Store"
- Name tables by entering the line under "Asgnmnt" and applying the conceptual typewriter (section 5.50)

---

## 10.00 The Score Editor

Designed to capture the actions and gestures of performance, as well as serve composers working with various media. The MIDAS **score editor** is a comprehensive facility for storing, manipulating, and recalling sequential musical information.

Access from the main menu by entering "Score editor".

### Display Overview

**Upper left:**
- **Accidental sign** (#/b): Toggle with **E** for sharp/flat key rendering. Differentiated by slanting the leading edge.

**Score structure:**
- Subdivided into **sections** (1–20), displayed in "Sec" field
- Time measured in **beats** and **frames** (48 frames per beat)
- To address a beat: enter the desired number (clock must be stopped; frame count goes to 00)
- **"Insert" mode**: When highlighted, pre-existing material is delayed instead of overwritten as new data is entered

**The Clock:**
- Started/stopped: Position cursor on "clock", toggle with **E**; or use the 4th front panel control key (underlined when on)
- **"Con" field**: Enter alternate clock sources (press **E**, select from menu)
  - MIDI clock commands, MIDI song position pointers
  - SMPTE time code (begins at a particular section)
- **"Src" field**: Specifies clock signal source
  - Local clock, MIDI clocks, SMPTE signals, or pulses (24, 48, or 96 per beat)
- **"Step" mode**: Advances score incrementally as notes or rests are entered from keyboard

**Note Edit:** Provides means for adding new notes and temporally modifying extant notes.

### Piano Roll Display

The major portion shows a **graphic piano roll representation** of the score:
- Linear time notation with notes as horizontal lines
- Accidentals indicated by diagonal leading edges
- Notes enter from the right, are sounded as they cross the vertical **present-time line**, and disappear under the piano keyboard on the left
- New notes recorded appear at the present-time line

### Score Data Fields

**"New Data" field (bottom):**
- Beat markers (white dots every 48 frames)
- Codified event markers (colored vertical lines) — see section 10.20

**Non-group-specific data line:**
- Current **assignment** and **tuning** tables (enter to view libraries)
- **Tempo**: 4 to 240 beats per minute
- **Interpolate**: Time for a new dynamic or location to assume its specified value
- **Stop**: Stops the clock
- **Next**: Advances to the next score
- **In/Out**: Initiate/terminate recording at precisely specified times
- **Output**: Reserved for future use

**Per-group data (6 lines):**
- Group numbers (color-coded for association with scored notes)
- Asterisks indicating record status for individual groups
- Instruments assigned to each group (view library via "group/instrum" + **E**)
- **Transpose**: Per-group pitch transposition in cents (range ±1200 cents = ±1 octave)
- **Dynamic/Location**: Per-voice values (dynamic 0–9, location 1 [far left] to 9 [far right])
- **Key velocity**: 000 to 127 per note

**Analog source recording:**
- Analog data from performance gestures (front panel or MIDI) may be stored
- "Analog Source" line: storable sources and record status
- **Resolution** (3–9): Trade accuracy for memory. Higher = faster response + greater accuracy
- One group displayed at a time (group number at end of line)

**Score library:**
- **20 scores** in the MIDAS VII library
- Bottom line: current score number, title, record mode status, available memory ("M" field)

**Record modes:**
- **Play** / **Record**: Toggle via cursor + **E** or 5th front panel key
- **Overdub**: Add new data without erasing previous
- **PunchIn**: Adds foot switch control to Record/Play
- Notes consume **10 memory slots** each

### 10.05 Creating a Score

1. Write an assignment table assigning desired group(s) to voices
2. Add other initial conditions, store the final table in the library
3. Return to the score editor
4. Enable group(s) for recording: position cursor under asterisk(s), type **+**
   - Yellow asterisk = ready for punch in
   - Type **+** again → red asterisk = record enabled
5. Enter "local" clock control and source (default values)
6. Change record mode to "record" (cursor under "record", press **E**)
7. Start the clock (cursor under "clock", press **E**)
8. Play your piece; observe notes entering the score (color-coded by group)

**Analog variable recording:**
- Normally not displayed; enable via "resoltn/value" + **E**
- Select group in the Group field (lower right)
- Highlight analog source with **E**, enable variables with **+** on asterisks

**Key velocities** are always recorded. Display by highlighting the velocity field with **E**.

### 10.10 Score Positioning

| Method | Description |
|--------|-------------|
| **Clock** | Moves forward at tempo rate, modified by Tempo Mult control |
| **Beat number** | Enter desired beat in "B" field (clock off) |
| **Section** | Go to pre-established section (see 10.30) |
| **Scroll** | Flywheel-like behavior, bidirectional (clock off) |

### 10.15 Recording Non-Note Data

Position score appropriately, enter desired data. System must be in record mode, and the associated group must be enabled for recording.

### 10.20 Score Display Event Markers

The colored markers in the "new data" field follow this scheme:

| Position | Violet | Blue | Red |
|----------|--------|------|-----|
| **Very top** | Assignment | Tune | Instrument |
| **Upper middle** | Tempo | Interpolate | Transpose |
| **Lower middle** | Stop or Next | Punch In | Dynamic/Location |
| **Very bottom** | Repeat | Punch Out | Analog Variable |

---

## 11.00 The Patch Editor

The patch editor enables **alternative performance environments** beyond traditional key-to-note relationships. Named after the patchcords used in analog synthesizers.

**Note:** Comprehension of the patch and sequence editors is not essential to the successful application of MIDAS VII. Skip to section 13.00 if desired.

### Patch Fundamentals

From main menu, select "patch editor": a window into the **patch table**, a component menu at the bottom, and sequencer status display on the right.

A **patch** occupies a single line with one optional and three mandatory components:

| Component | Required? | Description |
|-----------|-----------|-------------|
| **Stimulus** | Mandatory | Event that invokes the patch (key closure/release, external pulse, internal trigger) |
| **Destination** | Mandatory | Variable to influence |
| **Datum** | Mandatory | Value sent to the destination |
| **Definer** | Optional | Event that activates the patch |

**Without definer:** Stimulus calls patch immediately.
**With definer:** Patch is inactive until the definer event occurs. Useful for using some keys to alter the effects of other keys. When multiple patches share the same stimulus and destination, the last received definer determines which patch is active.

### Creating Patches

Patches are edited on the line marked with the **gold arrow**.

1. Position cursor on the first character of the desired field
2. Appropriate menu entries highlight
3. Press **E** — a second cursor appears in the menu
4. Locate under desired entry, press **E** to insert
5. Use numbered keys for numeric data
6. When complete (stimulus + destination + datum all present): position cursor in datum field, press **E** to deposit into the patch table

### 11.10 Definer and Stimulus Fields

Structurally identical:
- Key closure or release + key number (001–128) + port (local or MIDI 1/2)
- If MIDI port: channel number (01–16)
- Press **3** key to enter "L" for local
- **Triggers**: 01 to 16
- **Pulses**: 1 or 2 (red banana jacks on rear panel)

### 11.20 Destinations

**Keys and triggers as destinations:**
- Actuated by the patch instead of serving as stimuli
- Edit keys **7**, **8**, **9** select data types:
  - **Transient**: Closure followed immediately by release
  - **Stop**: Release
  - **Start**: Closure
- **Output pulses** appear at the orange banana jacks

**LED control:**
- Illuminate LEDs on the 24 local keys
- 7 color-coded groups (3–4 keys each), destinations A through G
- Data digits: **1** = on, **2** = off, **3** = toggle, **0** = ignore

**Sequencer control:**
- **SeqLin**: Direct sequencer to execute a particular line (000–999)
- **SeqCtl**: Stop (**8**) or start (**9**) a sequencer

**Tuning tables:** 0 through 9 selectable by patches.

**Registers (01–16):**
- Set directly (00–99)
- Increment/decrement by signed values (-99 to +99)
- Use edit keys **8** and **9** to enter signs

**Voice parameters:** Columns 2, 3, and 4 address the same aspects as the instrument editor. Require either a voice or group number. Use **8**/**9** keys to select "V" (voice) or "G" (group). The group is defined by the current assignment table.

**Additional destinations (column 6):**
- 4 programmable output voltages (blue rear panel banana jacks)
- 3 phase shift parameters (section 9.35)
- Auxiliary input modulation (section 9.25)

**Continuous variables — four destination types:**
1. **Source** + **Multiplier**: Attach a performance gesture to a variable
2. **Value**: Fixed value entry
3. **Time**: Time to reach the new value (milliseconds, max 32767ms / ~30 seconds)

### 11.30 Patch Table Management

- MIDAS maintains patches in **logical order**
- **View patch**: Enter its stimulus and definition (and definer if used); the patch appears on the edit line
- **Delete patch**: Position cursor in datum field, press **X**
  - Cursor in destination field: clears the edit line without destroying the patch
  - Cursor in definition/stimulus field: clears that field only

---

## 12.00 The Sequence Editor

MIDAS VII incorporates **16 software-based sequencers**. Particularly appropriate for:
- Short and/or repetitive event series
- Simultaneous events on different time bases
- Complex interactive musical processes using registers

### Display Organization

Accessed from main menu. Similar to patch editor:
- Scrolled display of **1000 lines** (sequence table)
- Menu below
- Status display on right (identical to patch editor)

### Sequence Line Structure

- **Delay time**: 00.00 to 99.99 seconds between executions
- **3 action fields**: Direct various actions at execution time

Lines execute sequentially with specified delays.

### 12.20 Keys and Triggers in Actions

- Turn keys/triggers on or off
- Triggers may be requested to alternate states
- Keys can generate transients (closure-release pair)

### 12.30 Sequencer Control

- **On**: Proceeding (bright colored numbers in status column 1)
- **Off**: Stopped
- **Stop**: Halts at current line
- **Jump to line ___**: Next line executed is the one in the jump command

### 12.40 Register Operations

Registers can be set or incremented by one of four value types:

| Type | Description |
|------|-------------|
| Direct | Set to 00–99 |
| Register | Set to content of another register |
| Control voltage | From 4 CV inputs (violet rear panel banana jacks) |
| Random | Digit after "?" determines range by powers of two (2 = 4 values, 6 = 64 values) |

Entry: cursor under 8th action field character. Operations: **-** (set), **+** (increment), **=** (from CV).

### 12.50 Conditional Executions

If a specified condition is met, the subsequent action field is performed; otherwise it is skipped.

Registers compared using: **=** (equal), **<** (less than), **>** (greater than).

**Only available in action fields 1 or 2.**

### 12.60 Navigation

- Access a line directly by entering its number
- Delete actions: position cursor in unwanted field, press **X**

---

## 13.00 Storing with the Librarian

All data to be saved must first be stashed in libraries. Red colored numbers in displays warn of unstored data.

### 13.10 Naming Files

- All files must be named (1–8 characters)
- Enter field right of "FileName", proceed to enter characters
- Add optional comments (section 5.50 describes the "conceptual typewriter")

### 13.20 Writing to Disk

1. Insert a formatted 3.5" diskette (write protect OFF)
2. **Read the index** by positioning cursor on "Index", press **E**
   - **Important:** Read the index after every disk change. Negligence leads to trashed disks.
3. Enter "Store", then the record type(s):
   - Score, Waveshapes, Assignments, Hi Orch, Lo Orch, Tunings

**Multiple record types with same name:** Enter desired record types first, then enter "Store" twice.

### 13.30 Deleting Files

1. Position cursor on the file to delete
2. Press **X** (file name turns red)
3. Confirm the deletion
4. Press **X** again

### 13.40 Front Panel Loading

**Setup:** Enter a letter (A–G) in the "L" column to prepare files for front panel loading.

**Loading:** Activate the appropriate front panel key followed by the letter corresponding to the desired file(s).

**Rules:**
- Label only one file of each type with the same letter
- To direct an orchestra file to the **hi orchestra**: intensify its label with **+** (detensify with **-**)

---

## 14.00 Additional Menu Functions

### 14.40 Formatting Diskettes

New diskettes must be formatted before use:
1. Insert a blank diskette into the drive
2. Select "Format Disk" from the main menu
3. **WARNING:** This process erases all previously stored data

**Diskette requirements:**
- Double sided, certified for double density
- Recommended brands: Dysan, Sony, 3M
- Avoid: Verbatim

### 14.50 Program Replication

MIDAS VII can replicate itself:
1. Insert a formatted diskette
2. Select "Write program to disk" from the main menu
3. Recommended: perform with a freshly loaded program (minimizes risk of software viruses)

---

## Quick Reference

### Key Functions

| Key | Function |
|-----|----------|
| **E** | Enter / Execute / Confirm |
| **M** | Return to main menu (from any display) |
| **X** | Delete |
| **+** | Add / Enable / Increase / Scroll options forward |
| **-** | Decrease / Disable / Scroll options backward |
| **0–9** | Numeric data entry |
| **7** | Natural (in pitch entry) |
| **8** | Flat (in pitch entry); various edit mode functions |
| **9** | Sharp (in pitch entry); various edit mode functions |

### Memory Limits

| Resource | Maximum |
|----------|---------|
| Instruments in memory | 40 (20 Lo + 20 Hi orchestra) |
| Active voice slots | 12 |
| Default instrument | 1 (instrument 0, non-editable) |
| Envelope points (total) | 128 |
| Waveshape tables | 20 (library) + 24 (active, 2 per voice) |
| Tuning tables | 10 (0 = default) |
| Assignment tables | 99 (0 = default) |
| Scores | 20 |
| Sequencers | 16 |
| Sequence table lines | 1000 |
| Sections per score | 20 |
| Groups | Up to 12 |
| Voices | 12 |
| Oscillators per voice | 4 |
| DCAs per voice | 6 |
| Indices per voice | 6 |
| Configurations | 12 |
| MIDI ports | Up to 3 (2 in + potentially out) |

### Signal Path Summary

```
4 Oscillators ──┐
                 ├── 6 DCAs (AM/FM/TM routing via configuration) ──→ Waveshape A
                 │                                                  ──→ Waveshape B
                 │                                                        │
                 │                                        ┌───────────────┘
                 │                                        ▼
                 │                              24 dB/oct Filter (cutoff + resonance)
                 │                                        │
                 │                                        ▼
                 └───────────────────────────────── VCA (level × dynamics)
                                                          │
                                                          ▼
                                                   Output Section
                                              (location, EQ, excitation)
                                                          │
                                                     ┌────┴────┐
                                                     L         R
                                                  (stereo out)
```

### Front Panel Layout (Left to Right)

```
┌─────────────────────────────────────────────────────────────────────┐
│ POWER  RESET  EDIT    │ TEMPO  TIME   FINE   AMPL  │  DATA ENTRY  │
│                       │ MULT   SCALE  TUNE         │  0-9 keys    │
│ Display    Voice      │                            │  Cursor pad  │
│ Intensity  Activity   │                            │  X  E  M     │
│            (12 LEDs)  │                            │              │
├───────────────────────┼────────────────────────────┤              │
│      X-Y TABLET       │  SCROLL   14 TOUCH SWITCHES              │
│    (performance)      │           14 SLIDE CONTROLS              │
│                       │           LCD DISPLAY                     │
│                       │                                           │
│        24 PERFORMANCE KEYS      LONGPOT                          │
│        (with LEDs above)        (magnetic strip below keys)      │
└─────────────────────────────────────────────────────────────────────┘
```

### Rear Panel Connections

| Connector | Type | Color |
|-----------|------|-------|
| Audio outputs (2) | 1/4" phone jacks | — |
| MIDI inputs (1–2) | DIN-5 | — |
| MIDI output | DIN-5 | — |
| Pulse inputs (2) | Banana jacks | Red |
| Pulse outputs (2) | Banana jacks | Orange |
| CV outputs (4) | Banana jacks | Blue |
| CV inputs (4) | Banana jacks | Violet |
| Auxiliary input 1 | — | — |
| Control voltage input 1 | — | — |
| Pedal input | — | — |
| Video output | EGA/DB-9 | — |
| Floppy drive | Internal (right side) | — |

---

*End of User's Guide*
