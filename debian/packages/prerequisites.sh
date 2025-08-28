#!/usr/bin/env bash
set -euo pipefail
SIMULATE="${SIMULATE:-}" # inherit from parent


PREREQ_PKGS=(curl wget gpg apt-transport-https software-properties-common)
MISSING_PKGS=()
for pkg in "${PREREQ_PKGS[@]}"; do
	if ! dpkg -s "$pkg" >/dev/null 2>&1; then
		MISSING_PKGS+=("$pkg")
	fi
done

if [ ${#MISSING_PKGS[@]} -eq 0 ]; then
	echo "[*] All prerequisites already installed."
else
    echo "[*] Updating apt cache..."
    sudo apt-get update $SIMULATE
	echo "[*] Installing prerequisites: ${MISSING_PKGS[*]}"
	sudo apt-get install -y $SIMULATE "${MISSING_PKGS[@]}"
fi
