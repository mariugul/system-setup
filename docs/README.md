# System Setup Scripts for Debian/Ubuntu

This repository provides automated scripts to set up a development environment on Debian-based systems (including Ubuntu). It installs essential tools and applications, and includes a test harness to verify the installation process in a clean container.

## Features
- Modular install scripts for each package (VS Code, Windsurf, Slack, prerequisites)
- Main install script to run all package scripts
- Docker-based test system to verify installation in a fresh Ubuntu container
- Dry-run support (`-s` flag) for safe simulation of package installation

## Usage
### Install on your system
```bash
./debian/install-packages.sh
```

To simulate (dry run) without making changes:
```bash
./debian/install-packages.sh -s
```

### Test in Docker
Run the install script in a clean Ubuntu container:
```bash
cd debian
./test/install.sh
```

## Adding New Packages
1. Create a new script in `debian/packages/` (e.g., `mypackage.sh`).
2. Add a `source "$(dirname "$0")/packages/mypackage.sh"` line to `install-packages.sh`.

## Requirements
- Debian/Ubuntu system
- Docker (for testing)

## License
MIT

## Author
Marius Gulbrandsen
