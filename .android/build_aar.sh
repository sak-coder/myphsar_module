#!/bin/bash

# build_aar.sh
echo "Setting up Flutter..."
chmod +x install_flutter.sh
./install_flutter.sh

echo "Building Flutter module..."
flutter build aar --no-profile --no-debug --no-tree-shake-icons

echo "Building Android AAR..."
cd android
./gradlew clean build
./gradlew assembleRelease

echo "AAR built successfully!"
echo "AAR location: android/build/outputs/aar/"