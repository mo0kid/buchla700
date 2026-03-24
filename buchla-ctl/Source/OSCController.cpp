#include "OSCController.h"

OSCController::OSCController() {
  oscSender = std::make_unique<juce::OSCSender>();
}

OSCController::~OSCController() { disconnect(); }

bool OSCController::connectToEmulator(const juce::String &ipAddress, int sendPort,
                                    int receivePort) {
  disconnect(); // Disconnect any existing connection

  targetIP = ipAddress;
  targetPort = sendPort;
  listenPort = receivePort;

  // Connect OSC sender
  if (!oscSender->connect(targetIP, targetPort)) {
    juce::Logger::writeToLog("OSCController: Failed to connect sender to " +
                             targetIP + ":" + juce::String(targetPort));
    return false;
  }

  // Connect OSC receiver
  if (!connect(listenPort)) {
    juce::Logger::writeToLog(
        "OSCController: Failed to start receiver on port " +
        juce::String(listenPort));
    oscSender->disconnect();
    return false;
  }

  // Add this as listener
  addListener(this);

  updateConnectionStatus(true);

  // Send connection announcement (must be after updateConnectionStatus
  // so that sendMessage's connected check passes)
  sendMessage("/taucontrol/connect", juce::String("BuchlaControl iPad"));

  juce::Logger::writeToLog("OSCController: Connected to emulator at " + targetIP +
                           ":" + juce::String(targetPort) +
                           ", listening on port " + juce::String(listenPort));

  return true;
}

void OSCController::disconnect() {
  if (connected) {
    // Send disconnect message
    sendMessage("/taucontrol/disconnect", juce::String("BuchlaControl iPad"));

    removeListener(this);
    juce::OSCReceiver::disconnect();
    oscSender->disconnect();

    updateConnectionStatus(false);

    juce::Logger::writeToLog("OSCController: Disconnected from emulator");
  }
}

void OSCController::sendKeyEvent(int midiNote, float velocity,
                                 float yPosition) {
  if (!connected)
    return;

  // midiNote is already the correct MIDI note from TouchKeyboard

  juce::Logger::writeToLog("OSC TX: key event note=" + juce::String(midiNote) + " vel=" + juce::String(velocity, 3) + " y=" + juce::String(yPosition, 3));
  if (velocity > 0.0f) {
    // Note on with Y-axis expression
    sendMessage("/taucontrol/key/on", midiNote, velocity, yPosition);
  } else if (velocity < 0.0f) {
    // Aftertouch (Y-axis movement on same key)
    juce::Logger::writeToLog("OSC TX: AFTERTOUCH note=" + juce::String(midiNote) + " yPos=" + juce::String(yPosition, 3));
    sendMessage("/taucontrol/key/aftertouch", midiNote, 0.0f, yPosition);
  } else {
    // Note off (velocity == 0.0f)
    sendMessage("/taucontrol/key/off", midiNote, 0.0f, 0.0f);
  }
}

void OSCController::sendButtonEvent(int buttonIndex, bool isPressed) {
  if (!connected)
    return;

  sendMessage("/taucontrol/button", buttonIndex, isPressed ? 1.0f : 0.0f);
}

void OSCController::sendFaderEvent(int faderIndex, float value) {
  if (!connected)
    return;

  sendMessage("/taucontrol/fader", faderIndex, value);
}

void OSCController::sendXYPosition(float x, float y) {
  juce::Logger::writeToLog("OSC TX: /taucontrol/xy x=" + juce::String(x, 3) + " y=" + juce::String(y, 3) + " connected=" + juce::String(connected ? "Y" : "N"));
  if (!connected)
    return;

  sendMessage("/taucontrol/xy", x, y);
}

void OSCController::sendTempoMult(float multiplier) {
  if (!connected)
    return;

  sendMessage("/taucontrol/tempo", multiplier);
}

void OSCController::sendTimeScaling(float scaling) {
  if (!connected)
    return;

  sendMessage("/taucontrol/timescale", scaling);
}

void OSCController::setTargetAddress(const juce::String &address, int port) {
  bool wasConnected = connected;

  if (wasConnected)
    disconnect();

  targetIP = address;
  targetPort = port;

  if (wasConnected)
    connectToEmulator(targetIP, targetPort, listenPort);
}

void OSCController::oscMessageReceived(const juce::OSCMessage &message) {
  auto address = message.getAddressPattern().toString();

  if (address == "/taunus/lcd/row") {
    // LCD row update from emulator
    if (message.size() >= 2 && lcdRowCallback) {
      int row = message[0].getInt32();
      juce::String text = message[1].getString();
      lcdRowCallback(row, text);
    }
  } else if (address == "/taunus/display") {
    handleDisplayUpdate(message);
  } else if (address.startsWith("/taunus/param/")) {
    handleParameterUpdate(message);
  } else if (address == "/taunus/status") {
    handleConnectionStatus(message);
  } else if (address == "/taunus/fader/centered") {
    if (message.size() >= 1 && faderCenteredCallback) {
      int mask = message[0].getInt32();
      faderCenteredCallback(mask);
    }
  } else if (address.startsWith("/taunus/")) {
    handleEmulatorMessage(message);
  } else if (address == "/taucontrol/fader") {
    // Handle incoming fader updates from desktop
    if (message.size() >= 2 && faderUpdateCallback) {
      int faderIndex = message[0].getInt32();
      float value = message[1].getFloat32();
      juce::Logger::writeToLog("OSCController: Received fader update from desktop - fader " + 
                              juce::String(faderIndex) + " = " + juce::String(value, 3));
      faderUpdateCallback(faderIndex, value);
    }
  }
}

void OSCController::handleEmulatorMessage(const juce::OSCMessage &message) {
  // Handle general messages from Taunus
  juce::Logger::writeToLog("OSCController: Received emulator message: " +
                           message.getAddressPattern().toString());
}

void OSCController::handleDisplayUpdate(const juce::OSCMessage &message) {
  if (message.size() > 0) {
    if (message[0].isString()) {
      juce::String displayText = message[0].getString();

      if (displayCallback)
        displayCallback(displayText);
    }
  }
}

void OSCController::handleParameterUpdate(const juce::OSCMessage &message) {
  auto address = message.getAddressPattern().toString();

  // Handle parameter updates like "/taunus/param/column/0" for data columns
  if (address.contains("/column/") && message.size() > 0) {
    // Extract column index from address
    auto parts = juce::StringArray::fromTokens(address, "/", "");
    for (int i = 0; i < parts.size(); ++i) {
      if (parts[i] == "column" && i + 1 < parts.size()) {
        int columnIndex = parts[i + 1].getIntValue();

        if (message[0].isString() && dataColumnCallback) {
          dataColumnCallback(columnIndex, message[0].getString());
        }
        break;
      }
    }
  }
}

void OSCController::handleConnectionStatus(const juce::OSCMessage &message) {
  if (message.size() > 0) {
    if (message[0].isString()) {
      juce::String status = message[0].getString();
      bool isConnected = (status == "connected");
      updateConnectionStatus(isConnected);
    }
  }
}

void OSCController::sendMessage(const juce::String &address,
                                const juce::var &value) {
  if (!connected || !oscSender)
    return;

  juce::OSCMessage msg(address);

  if (value.isInt() || value.isInt64())
    msg.addInt32(static_cast<int>(value));
  else if (value.isDouble())
    msg.addFloat32(static_cast<float>(value));
  else if (value.isBool())
    msg.addInt32(value ? 1 : 0);
  else if (value.isString())
    msg.addString(value.toString());

  if (!oscSender->send(msg)) {
    juce::Logger::writeToLog("OSCController: Failed to send message: " +
                             address);
  }
}

void OSCController::sendMessage(const juce::String &address,
                                const juce::var &value1,
                                const juce::var &value2) {
  if (!connected || !oscSender)
    return;

  juce::OSCMessage msg(address);

  // Add first value
  if (value1.isInt() || value1.isInt64())
    msg.addInt32(static_cast<int>(value1));
  else if (value1.isDouble())
    msg.addFloat32(static_cast<float>(value1));
  else if (value1.isBool())
    msg.addInt32(value1 ? 1 : 0);
  else if (value1.isString())
    msg.addString(value1.toString());

  // Add second value
  if (value2.isInt() || value2.isInt64())
    msg.addInt32(static_cast<int>(value2));
  else if (value2.isDouble())
    msg.addFloat32(static_cast<float>(value2));
  else if (value2.isBool())
    msg.addInt32(value2 ? 1 : 0);
  else if (value2.isString())
    msg.addString(value2.toString());

  if (!oscSender->send(msg)) {
    juce::Logger::writeToLog("OSCController: Failed to send message: " +
                             address);
  }
}

void OSCController::sendMessage(const juce::String &address,
                                const juce::var &value1,
                                const juce::var &value2,
                                const juce::var &value3) {
  if (!connected || !oscSender)
    return;

  juce::OSCMessage msg(address);

  // Add values (similar pattern as above)
  auto addValue = [&msg](const juce::var &value) {
    if (value.isInt() || value.isInt64())
      msg.addInt32(static_cast<int>(value));
    else if (value.isDouble())
      msg.addFloat32(static_cast<float>(value));
    else if (value.isBool())
      msg.addInt32(value ? 1 : 0);
    else if (value.isString())
      msg.addString(value.toString());
  };

  addValue(value1);
  addValue(value2);
  addValue(value3);

  if (!oscSender->send(msg)) {
    juce::Logger::writeToLog("OSCController: Failed to send message: " +
                             address);
  }
}

void OSCController::updateConnectionStatus(bool newStatus) {
  if (connected != newStatus) {
    connected = newStatus;

    if (connectionCallback)
      connectionCallback(connected);
  }
}
