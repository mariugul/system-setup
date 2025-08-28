#!/usr/bin/env bash
set -euo pipefail


# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

IMAGE_NAME="system-setup-test"
DOCKERFILE="$SCRIPT_DIR/Dockerfile"

# Build the Docker image
if docker build -t "$IMAGE_NAME" -f "$DOCKERFILE" "$PROJECT_ROOT"; then
  echo "[+] Docker image built successfully."
else
  echo "[!] Docker build failed."
  exit 1
fi

# Run the container and capture output
if docker run --rm "$IMAGE_NAME"; then
  echo "[✔] Install script ran successfully in container."
  exit 0
else
  echo "[✗] Install script failed in container."
  exit 2
fi
