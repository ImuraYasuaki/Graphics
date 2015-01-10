#!/bin/bash

INSTAL_PATH=$(SRCROOT)/../Framework
LIB_NAME=lib$(${PROJECT_NAME}.a

BUILD_COMMAND=xcodebuild build -target $(PROJECT_NAME) \
    -project $(PROJECT_NAME).xcodeproj \
    -configuration $(CONFIGURATION) \
    ONLY_ACTIVE_ARCH=NO \
    BUILD_DIR=$(BUILD_DIR) \
    BUILD_ROOT=$(BUILD_ROOT)

echo "1: build_library\n2: install_library\n3: install_header\n4: install_resource"

echo "build_library: dummy"
echo"    $(build_command) -sdk iphoneos
    $(build_command) -sdk iphonesimulator"

echo "install_library: dummy
    mkdir -p $(INSTALL_PATH)/lib
    lipo -create -output $(INSTALL_PATH)/lib/$(LIB_NAME) \ 
      ${BUILD_DIR}/${CONFIGURATION}-iphoneos/$(LIB_NAME) \
      ${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/$(LIB_NAME)"

echo "install_header: dymmy
    mkdir -p $(INSTALL_PATH)/include/$(PROJECT_NAME)
    install -m 0644 ${BUILD_DIR}/${CONFIGURATION}-iphoneos/include/$(PROJECT_NAME)/*.h \
      $(INSTALL_PATH)/include/$(PROJECT_NAME)"

echo "install_resource: dummy
    mkdir -p $(INSTALL_PATH)/resource
    find $(PROJECT_DIR) -name "*.xib" -exec install -m 0644 "{}" $(INSTALL_PATH)/resource ";""

echo "dummy:"

