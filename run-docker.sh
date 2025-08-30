#!/bin/bash

# Build the Docker image
echo "Building Docker image..."
docker build -f Dockerfile.manual -t system-setup-manual .

# Run the container
echo "Starting container..."
docker run --rm -it \
    --name system-setup-manual \
    system-setup-manual

echo "Container exited."
