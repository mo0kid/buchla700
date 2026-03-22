# BuchlaControl - Buchla 700 OSC Controller for iPad
# JUCE-based touch controller for Buchla 700 emulator

cmake_minimum_required(VERSION 3.15)

# Set project name and version
project(BuchlaControl VERSION 1.0.0)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find and add JUCE
find_package(PkgConfig)

# Add JUCE subdirectory - adjust path as needed
# Option 1: Local JUCE copy (git submodule)
if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/juce/CMakeLists.txt)
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/juce ${CMAKE_CURRENT_BINARY_DIR}/juce)
# Option 2: Parent Taunus project's JUCE (development)
elseif(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/../../CascadeProjects/Taunus/juce/CMakeLists.txt)
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../../CascadeProjects/Taunus/juce ${CMAKE_CURRENT_BINARY_DIR}/juce)
# Option 3: Home JUCE installation
elseif(EXISTS $ENV{HOME}/JUCE/CMakeLists.txt)
    add_subdirectory($ENV{HOME}/JUCE ${CMAKE_CURRENT_BINARY_DIR}/juce)
else()
    message(FATAL_ERROR "JUCE not found. Clone it into buchla-ctl/juce/ or set JUCE path.")
endif()

# Create the application target
juce_add_gui_app(BuchlaControl
    COMPANY_NAME "Buchla700"
    PRODUCT_NAME "BuchlaControl"
    VERSION 1.0.0
    BUNDLE_ID com.buchla700.buchlacontrol
    MICROPHONE_PERMISSION_ENABLED FALSE
    CAMERA_PERMISSION_ENABLED FALSE
    BLUETOOTH_PERMISSION_ENABLED FALSE
    SEND_APPLE_EVENTS_PERMISSION_ENABLED FALSE
    NETWORK_ACCESS_ENABLED TRUE
)

# Set target properties for iOS/iPad
set_target_properties(BuchlaControl PROPERTIES
    MACOSX_BUNDLE TRUE
    MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_SOURCE_DIR}/Info.plist
    MACOSX_BUNDLE_GUI_IDENTIFIER com.buchla700.buchlacontrol
    MACOSX_BUNDLE_BUNDLE_VERSION 1.0.0
    MACOSX_BUNDLE_SHORT_VERSION_STRING 1.0.0
    XCODE_ATTRIBUTE_TARGETED_DEVICE_FAMILY "2" # iPad only
    XCODE_ATTRIBUTE_IPHONEOS_DEPLOYMENT_TARGET "15.0"
    XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH[variant=Debug] "YES"
    XCODE_ATTRIBUTE_DEVELOPMENT_TEAM ""
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "iPhone Developer"
    XCODE_ATTRIBUTE_PROVISIONING_PROFILE_SPECIFIER ""
    XCODE_ATTRIBUTE_SUPPORTED_PLATFORMS "iphoneos iphonesimulator"
    XCODE_ATTRIBUTE_ENABLE_BITCODE "NO"
    XCODE_ATTRIBUTE_INFOPLIST_KEY_NSLocalNetworkUsageDescription "BuchlaControl needs local network access to communicate with the Buchla 700 emulator via OSC"
    XCODE_ATTRIBUTE_INFOPLIST_KEY_NSBonjourServices "_osc._udp"
)

# Source files
target_sources(BuchlaControl PRIVATE
    Source/Main.cpp
    Source/MainComponent.cpp
    Source/MainComponent.h
    Source/BuchlaLookAndFeel.cpp
    Source/BuchlaLookAndFeel.h
    Source/TouchKeyboard.cpp
    Source/TouchKeyboard.h
    Source/TouchPad.cpp
    Source/TouchPad.h
    Source/OSCController.cpp
    Source/OSCController.h
    Source/BuchlaColors.h
)

# Objective-C++ file for iOS status bar hiding
target_sources(BuchlaControl PRIVATE Source/HideStatusBar.mm)
set_source_files_properties(Source/HideStatusBar.mm PROPERTIES
    COMPILE_FLAGS "-x objective-c++"
    SKIP_PRECOMPILE_HEADERS ON
)

# JUCE modules
target_link_libraries(BuchlaControl PRIVATE
    juce::juce_core
    juce::juce_data_structures
    juce::juce_events
    juce::juce_graphics
    juce::juce_gui_basics
    juce::juce_gui_extra
    juce::juce_osc
    juce::juce_opengl
)

# Compiler definitions
target_compile_definitions(BuchlaControl PRIVATE
    JUCE_WEB_BROWSER=0
    JUCE_USE_CURL=0
    JUCE_APPLICATION_NAME_STRING="$<TARGET_PROPERTY:BuchlaControl,JUCE_PRODUCT_NAME>"
    JUCE_APPLICATION_VERSION_STRING="$<TARGET_PROPERTY:BuchlaControl,JUCE_VERSION>"
    JUCE_DISPLAY_SPLASH_SCREEN=0
    JUCE_USE_DARK_SPLASH_SCREEN=1
)

# Include directories
target_include_directories(BuchlaControl PRIVATE
    Source
)
