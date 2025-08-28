#!/usr/bin/env bash
set -euo pipefail
SIMULATE="${SIMULATE:-}" # inherit from parent

if ! command -v code >/dev/null 2>&1; then
  echo "[*] Installing VS Code..."
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/trusted.gpg.d/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" \
    | sudo tee /etc/apt/sources.list.d/vscode.list
  sudo apt-get update $SIMULATE
  sudo apt-get install -y $SIMULATE code
else
  echo "[*] VS Code already installed"
fi
