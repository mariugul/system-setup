# System Setup Scripts for Debian/Ubuntu

This repository provides automated scripts and an Ansible playbook to set up a development environment on Debian-based systems.

## One-off Quick Install
To run the setup in one command, use:

```bash
curl -fsSL https://raw.githubusercontent.com/mariugul/system-setup/refs/heads/master/install.sh | bash
```

This will:
- Install curl, pip, and Ansible (system-wide)
- Download the Ansible playbook to `/playbooks`
- Run the playbook to set up your system

## Features
- Modular install scripts for each package
- Ansible playbook for idempotent, robust setup
- Docker-based test system (optional)

## Manual Usage
Clone the repo and run:
```bash
./install.sh
```

## Requirements
- Debian/Ubuntu system
- sudo privileges

## License
MIT

## Author
Your Name
