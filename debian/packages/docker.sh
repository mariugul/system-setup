#!/usr/bin/env bash
set -euo pipefail
SIMULATE="${SIMULATE:-}" # inherit from parent

if ! command -v docker >/dev/null 2>&1; then
    echo "[*] Installing Docker..."
    sudo apt-get update $SIMULATE
    sudo apt-get install -y $SIMULATE ca-certificates gnupg lsb-release
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update $SIMULATE
    sudo apt-get install -y $SIMULATE docker-ce docker-ce-cli containerd.io
    echo "[*] Docker installed."
    echo "[*] Adding $USER to docker group to allow running Docker without sudo..."
    sudo usermod -aG docker $USER
    echo "[*] Activating docker group membership for current shell..."
    newgrp docker <<EONG
echo "[*] Docker group membership activated for this shell."
EONG
else
    echo "[*] Docker already installed."
fi
