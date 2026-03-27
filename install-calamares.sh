#!/bin/bash

# Calamares Installation Script for Art Linux
# Run as root

set -e

CALAMARES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="/usr/local/lib"
BIN_DIR="/usr/local/bin"
SHARE_DIR="/usr/share/calamares"
CONFIG_DIR="/etc/calamares"

echo "Installing Calamares..."

# Copy binary
mkdir -p "$BIN_DIR"
cp "$CALAMARES_DIR/bin/calamares" "$BIN_DIR/"
chmod +x "$BIN_DIR/calamares"

# Copy libraries
mkdir -p "$LIB_DIR"
cp -r "$CALAMARES_DIR/lib/"* "$LIB_DIR/"

# Update library cache
ldconfig

# Copy configuration
mkdir -p "$CONFIG_DIR"
cp -r "$CALAMARES_DIR/etc/calamares/"* "$CONFIG_DIR/"

# Copy branding
mkdir -p "$SHARE_DIR/branding"
cp -r "$CALAMARES_DIR/lib/branding/"* "$SHARE_DIR/branding/"

# Copy QML
mkdir -p "$SHARE_DIR/qml"
cp -r "$CALAMARES_DIR/lib/qml/"* "$SHARE_DIR/qml/"

# Create symlink for modules
mkdir -p "$LIB_DIR/calamares"
ln -sf "$CALAMARES_DIR/lib/x86_64-linux-gnu/calamares/"* "$LIB_DIR/calamares/"

echo ""
echo "=========================================="
echo "  Calamares installed successfully!"
echo "=========================================="
echo ""
echo "Run 'calamares' to start the installer."
echo ""
