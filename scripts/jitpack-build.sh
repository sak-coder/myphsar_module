#!/bin/bash
set -e

echo "Installing Flutter..."
git clone https://github.com/flutter/flutter.git --depth 1 -b stable
export PATH="$PWD/flutter/bin:$PATH"
export FLUTTER_ROOT="$PWD/flutter"

echo "Checking Flutter version..."
flutter --version

echo "Getting dependencies..."
flutter pub get

echo "Building AAR..."
flutter build aar --no-profile --no-release

echo "Preparing for JitPack..."
# Copy the built AARs to a location JitPack expects
mkdir -p android/build/outputs/aar
cp -r build/host/outputs/repo/* android/build/outputs/aar/

echo "Build completed successfully!"