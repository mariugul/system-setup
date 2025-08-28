#!/usr/bin/env bash

set -euo pipefail

# Support -s (simulate/dry run) option
SIMULATE=""
if [[ "${1:-}" == "-s" ]]; then
  SIMULATE="-s"
  echo "[*] Dry run mode: apt-get will simulate actions."
fi

source "$(dirname "$0")/packages/prerequisites.sh"
source "$(dirname "$0")/packages/docker.sh"
source "$(dirname "$0")/packages/vscode.sh"
source "$(dirname "$0")/packages/windsurf.sh"
source "$(dirname "$0")/packages/slack.sh"

echo "[✔] All requested packages are installed."
