#!/usr/bin/env bash
set -euo pipefail

# Check if any packages need to be installed
NEED_UPDATE=false

if ! command -v curl >/dev/null 2>&1; then
    NEED_UPDATE=true
fi

if ! command -v ansible >/dev/null 2>&1; then
    NEED_UPDATE=true
fi

# Update package list only if needed
if [ "$NEED_UPDATE" = true ]; then
    echo "[*] Updating package list..."
    sudo apt-get update
fi

# Install curl if not present
if ! command -v curl >/dev/null 2>&1; then
    echo "[*] Installing curl..."
    sudo apt-get install -y curl
fi

# Install Ansible system-wide with apt
if ! command -v ansible >/dev/null 2>&1; then
    echo "[*] Installing Ansible with apt..."
    sudo apt-get install -y ansible
fi


# Determine which playbook to use
LOCAL_YML="./system-setup.yml"
REPO_RAW_URL="https://raw.githubusercontent.com/mariugul/system-setup/refs/heads/master/system-setup.yml"
TARGET_YML="/playbooks/system-setup.yml"

if [ -f "$LOCAL_YML" ]; then
    echo "[*] Using local system-setup.yml..."
    PLAYBOOK_TO_USE="$LOCAL_YML"
else
    echo "[*] Local system-setup.yml not found, downloading from GitHub..."
    sudo mkdir -p /playbooks
    sudo curl -fsSL "$REPO_RAW_URL" -o "$TARGET_YML"
    PLAYBOOK_TO_USE="$TARGET_YML"
fi

# Run Ansible playbook
echo "[*] Running Ansible playbook..."
ansible-playbook "$PLAYBOOK_TO_USE" --ask-become-pass
