#!/bin/bash
# Usage: ./install.sh [uninstall]

INSTALL_PATH="/usr/local/bin/tg"
SOURCE_FILE="tg.py"

if [[ "$1" == "uninstall" ]]; then
    echo "Uninstalling tg..."
    if [[ -f "$INSTALL_PATH" ]]; then
        sudo rm "$INSTALL_PATH"
        echo "Successfully removed $INSTALL_PATH"
    else
        echo "tg is not installed at $INSTALL_PATH"
    fi
    exit 0
fi

if [[ ! -f "$SOURCE_FILE" ]]; then
    echo "Error: $SOURCE_FILE not found in the current directory."
    exit 1
fi

echo "Installing tg to $INSTALL_PATH..."
sudo cp "$SOURCE_FILE" "$INSTALL_PATH"
sudo chmod +x "$INSTALL_PATH"
echo "Installation complete!"