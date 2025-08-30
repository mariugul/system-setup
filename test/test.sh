#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="system-setup-curl-test"
DOCKERFILE="test-curl-install.Dockerfile"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Build the Docker image
if docker build -t "$IMAGE_NAME" -f "$SCRIPT_DIR/$DOCKERFILE" "$PROJECT_ROOT"; then
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
