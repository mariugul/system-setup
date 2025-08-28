#!/usr/bin/env bash
set -euo pipefail
SIMULATE="${SIMULATE:-}" # inherit from parent

if ! command -v slack >/dev/null 2>&1; then
  echo "[*] Adding Slack repository key..."
  wget -qO- https://packagecloud.io/slacktechnologies/slack/gpgkey | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/slack.gpg > /dev/null
  echo "[*] Adding Slack repository to sources list..."
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/trusted.gpg.d/slack.gpg] https://packagecloud.io/slacktechnologies/slack/debian/ jessie main" \
    | sudo tee /etc/apt/sources.list.d/slack.list
  echo "[*] Updating apt cache..."
  sudo apt-get update $SIMULATE
  echo "[*] Installing Slack..."
  sudo apt-get install -y $SIMULATE slack-desktop
else
  echo "[*] Slack already installed"
fi
