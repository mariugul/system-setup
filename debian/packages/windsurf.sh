#!/usr/bin/env bash
set -euo pipefail
SIMULATE="${SIMULATE:-}" # inherit from parent

if ! command -v windsurf >/dev/null 2>&1; then
    echo "[*] Adding Windsurf repository key..."
    wget -qO- "https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/windsurf.gpg" | gpg --dearmor > windsurf-stable.gpg
    sudo install -D -o root -g root -m 644 windsurf-stable.gpg /etc/apt/keyrings/windsurf-stable.gpg
    echo "[*] Adding Windsurf repository to sources list..."
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/windsurf-stable.gpg] https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/apt stable main" | sudo tee /etc/apt/sources.list.d/windsurf.list > /dev/null
    rm -f windsurf-stable.gpg
    echo "[*] Updating apt cache..."
    sudo apt-get update $SIMULATE
    echo "[*] Ensuring apt-transport-https is installed..."
    sudo apt install apt-transport-https
    echo "[*] Installing Windsurf..."
    sudo apt-get install -y $SIMULATE windsurf
else
    echo "[*] Windsurf already installed"
fi
