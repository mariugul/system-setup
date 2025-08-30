#!/usr/bin/env bash
set -euo pipefail

# Install curl if not present
if ! command -v curl >/dev/null 2>&1; then
    echo "[*] Installing curl..."
    sudo apt-get update
    sudo apt-get install -y curl
fi

# Install pip if not present
if ! command -v pip3 >/dev/null 2>&1; then
    echo "[*] Installing pip3..."
    sudo apt-get update
    sudo apt-get install -y python3-pip
fi

# Install Ansible system-wide with apt
if ! command -v ansible >/dev/null 2>&1; then
    echo "[*] Installing Ansible with apt..."
    sudo apt-get update
    sudo apt-get install -y ansible
fi

# Download system-setup.yml with curl
REPO_RAW_URL="https://raw.githubusercontent.com/mariugul/system-setup/main/system-setup.yml"
TARGET_YML="system-setup.yml"

if [ ! -f "$TARGET_YML" ]; then
    echo "[*] Downloading system-setup.yml..."
    curl -fsSL "$REPO_RAW_URL" -o "$TARGET_YML"
fi


sudo mkdir -p /playbooks
REPO_RAW_URL="https://raw.githubusercontent.com/mariugul/system-setup/main/ansible/system-setup.yml"
TARGET_YML="/playbooks/system-setup.yml"

if [ ! -f "$TARGET_YML" ]; then
    echo "[*] Downloading system-setup.yml into /playbooks ..."
    sudo curl -fsSL "$REPO_RAW_URL" -o "$TARGET_YML"
fi

# Run Ansible playbook
echo "[*] Running Ansible playbook..."
ansible-playbook "$TARGET_YML" --ask-become-pass
