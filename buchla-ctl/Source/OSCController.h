#pragma once

#include <juce_osc/juce_osc.h>
#include <juce_core/juce_core.h>

/**
 * OSC Controller - Handles communication between BuchlaControl and Buchla 700 emulator
 * 
 * Features:
 * - Sends touch events, fader changes, and XY position to Buchla 700 emulator
 * - Receives display updates and parameter changes from emulator
 * - Auto-discovery of emulator instances on network
 * - Configurable IP address and ports
 * - Connection status monitoring
 */
class OSCController : public juce::OSCReceiver,
                     public juce::OSCReceiver::Listener<juce::OSCReceiver::RealtimeCallback>
{
public:
    OSCController();
    ~OSCController() override;
    
    // Connection management
    bool connectToEmulator(const juce::String& ipAddress = "127.0.0.1", 
                        int sendPort = 9001, int receivePort = 9002);
    void disconnect();
    bool isConnected() const { return connected; }
    
    // Connection status callback
    using ConnectionCallback = std::function<void(bool isConnected)>;
    void setConnectionCallback(ConnectionCallback callback) { connectionCallback = callback; }
    
    // Outgoing OSC messages (to Taunus)
    void sendKeyEvent(int midiNote, float velocity, float yPosition);
    void sendButtonEvent(int buttonIndex, bool isPressed);
    void sendFaderEvent(int faderIndex, float value);
    void sendXYPosition(float x, float y);
    void sendTempoMult(float multiplier);
    void sendTimeScaling(float scaling);
    
    // Display update callback
    using DisplayCallback = std::function<void(const juce::String& text)>;
    void setDisplayCallback(DisplayCallback callback) { displayCallback = callback; }
    
    // Data column update callback
    using DataColumnCallback = std::function<void(int columnIndex, const juce::String& value)>;
    void setDataColumnCallback(DataColumnCallback callback) { dataColumnCallback = callback; }
    
    // Fader update callback (for incoming fader changes from desktop)
    using FaderUpdateCallback = std::function<void(int faderIndex, float value)>;
    void setFaderUpdateCallback(FaderUpdateCallback callback) { faderUpdateCallback = callback; }

    // LCD row update callback (row number, row text)
    using LcdRowCallback = std::function<void(int row, const juce::String& text)>;
    void setLcdRowCallback(LcdRowCallback callback) { lcdRowCallback = callback; }

    // Fader centered bitmask callback (bit i = 1 means fader i is bipolar)
    using FaderCenteredCallback = std::function<void(int bitmask)>;
    void setFaderCenteredCallback(FaderCenteredCallback callback) { faderCenteredCallback = std::move(callback); }
    
    // OSC Receiver implementation
    void oscMessageReceived(const juce::OSCMessage& message) override;
    
    // Configuration
    void setTargetAddress(const juce::String& address, int port);
    juce::String getTargetAddress() const { return targetIP; }
    int getTargetPort() const { return targetPort; }

private:
    // Connection state
    bool connected = false;
    juce::String targetIP = "127.0.0.1";
    int targetPort = 9001;
    int listenPort = 9002;
    
    // OSC communication
    std::unique_ptr<juce::OSCSender> oscSender;
    
    // Callbacks
    ConnectionCallback connectionCallback;
    DisplayCallback displayCallback;
    DataColumnCallback dataColumnCallback;
    FaderUpdateCallback faderUpdateCallback;
    LcdRowCallback lcdRowCallback;
    FaderCenteredCallback faderCenteredCallback;
    
    // Helper methods
    void handleEmulatorMessage(const juce::OSCMessage& message);
    void handleDisplayUpdate(const juce::OSCMessage& message);
    void handleParameterUpdate(const juce::OSCMessage& message);
    void handleConnectionStatus(const juce::OSCMessage& message);
    void sendMessage(const juce::String& address, const juce::var& value);
    void sendMessage(const juce::String& address, const juce::var& value1, const juce::var& value2);
    void sendMessage(const juce::String& address, const juce::var& value1, 
                    const juce::var& value2, const juce::var& value3);
    void updateConnectionStatus(bool newStatus);
    
    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR(OSCController)
};