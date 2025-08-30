FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install sudo and create a test user
RUN apt-get update && \
    apt-get install -y sudo && \
    useradd -m -s /bin/bash testuser && \
    echo 'testuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Switch to test user
USER testuser
WORKDIR /home/testuser

# Copy the playbook and install script
COPY --chown=testuser:testuser system-setup.yml ./
COPY --chown=testuser:testuser install.sh ./

# Make install script executable
RUN chmod +x install.sh

# Run the installation
RUN ./install.sh

# Copy verification script
COPY --chown=testuser:testuser test/verify.sh ./
RUN chmod +x verify.sh

# Run verification
CMD ["./verify.sh"]
