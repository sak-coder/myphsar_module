#!/bin/bash
set -e

# Define Flutter version
FLUTTER_VERSION="3.13.0"  # Change to your required version
FLUTTER_SDK_DIR="$PWD/flutter_sdk"

echo "=== Installing Flutter SDK ==="

# Install Flutter if not already present
if [ ! -d "$FLUTTER_SDK_DIR" ]; then
    echo "Downloading Flutter $FLUTTER_VERSION..."
    wget -q "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_$FLUTTER_VERSION-stable.tar.xz" -O flutter.tar.xz
    
    echo "Extracting Flutter SDK..."
    tar -xf flutter.tar.xz
    mv flutter flutter_sdk
    rm flutter.tar.xz
fi

# Set up environment variables
export PATH="$FLUTTER_SDK_DIR/bin:$PATH"
export FLUTTER_ROOT="$FLUTTER_SDK_DIR"

echo "Flutter SDK path: $FLUTTER_ROOT"
echo "Flutter version:"
flutter --version

echo "=== Setting up project ==="

# Get dependencies
flutter pub get

echo "=== Building AAR ==="

# Build AAR
flutter build aar --no-profile --no-release --verbose

echo "=== Preparing artifacts for JitPack ==="

# Copy built artifacts to expected locations
mkdir -p android/build/outputs/aar
cp -r build/host/outputs/repo/* android/build/outputs/aar/ 2>/dev/null || echo "No repo files to copy"

# Create a simple Gradle build that uses the pre-built AARs
echo "Build completed successfully!"
