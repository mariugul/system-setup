# Test Dockerfile for one-off install.sh curl method
FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive


# Install curl and sudo
RUN apt-get update && apt-get install -y curl sudo

# Create a non-root user and add to sudoers
RUN useradd -m testuser && echo 'testuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER testuser
WORKDIR /home/testuser

# Run the one-off install script as non-root user
CMD curl -fsSL https://raw.githubusercontent.com/mariugul/system-setup/refs/heads/master/install.sh | bash
