#!/bin/bash
set -e

# Install Flutter
git clone https://github.com/flutter/flutter.git --depth 1 -b stable
export PATH="$PWD/flutter/bin:$PATH"

# Verify Flutter installation
flutter doctor -v

# Get dependencies
flutter pub get

# Build AAR
flutter build aar --no-profile --no-release

# Copy built AAR to appropriate location for JitPack
mkdir -p build/outputs/aar
cp android/build/outputs/aar/*.aar build/outputs/aar/