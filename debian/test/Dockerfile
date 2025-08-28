# Test Dockerfile for install-packages.sh
FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Install basic dependencies for script execution
RUN apt-get update && apt-get install -y bash sudo curl wget gpg apt-transport-https software-properties-common

# Copy the system-setup scripts into the container
COPY ../ /debian

WORKDIR /debian

# Make all scripts executable
RUN chmod +x install-packages.sh packages/*.sh

# Run the install script
CMD ["/debian/install-packages.sh"]
