# SyncPrjs - Universal Multi-Prefix Project Manager

**Powered by ChronicleLogger**  
A robust command-line tool for managing multiple projects that follow a **prefix-suffix** naming convention.

---

## Overview

SyncPrjs is a universal project manager designed to handle a large number of similarly structured projects (e.g. `grok-example`, `poe-chatbot`, `gm-assistant`, etc.).

It is specifically optimized for **ANT-ready GNOME C/GTK applications** that use:
- A `WebKitWebView` as the main UI component
- `build.xml` + `autoreconf` + `make` build system
- Cookie/session storage in `~/.app/`

The tool follows strict **CIAO defensive coding** principles for maximum reliability and auditability.

## Features

- **Multi-prefix support** — easily group and operate on projects by prefix (`grok-*`, `poe-*`, `gm-*`, etc.)
- Project discovery and validation
- Batch operations across related projects
- Secure cookie/session management
- Detailed logging via ChronicleLogger
- Defensive coding style (CIAO) for production-grade reliability

## Project Structure

```
SyncPrjs/
├── src/
│   └── SyncPrjs/
│       └── cli.py          # Main CLI entry point
├── docs/
   ├── update-log.md
│   └── folder-structure.md
├── tests/
├── pyproject.toml
├── README.md
└── ...
```

## Installation

### From Source (Recommended for Development)

```bash
git clone https://github.com/Wilgat/SyncPrjs.git
cd SyncPrjs

# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install in editable mode
pip install -e .
```

### As a Standalone Script

Make the CLI executable:

```bash
chmod +x src/SyncPrjs/cli.py
sudo ln -s $(pwd)/src/SyncPrjs/cli.py /usr/local/bin/syncprjs
```

## Usage

```bash
syncprjs --help
```

### Basic Commands (examples)

```bash
# List all projects
syncprjs list

# List only projects with specific prefix
syncprjs list --prefix grok

# Sync / update all projects
syncprjs sync --all

# Build projects
syncprjs build --prefix poe

# Clean build artifacts
syncprjs clean

# Show detailed status
syncprjs status
```

> **Note**: Exact commands depend on the final implementation in `cli.py`. The tool is designed around common workflows: list, sync, build, clean, status.

## Project Naming Convention

All managed projects follow the pattern:

```
<prefix>-<suffix>
```

**Examples**:
- `grok-examplet`
- `gm-assistant`
- `poe-webview`
- `claude-research`

## Cookie Storage

Cookies and session data are stored in:

```
~/.app/
```

This location is intentionally outside individual project folders for better security and sharing across related apps.

## Development Philosophy

- **CIAO Defensive Coding** — Every critical section is protected and auditable.
- Full traceability via ChronicleLogger.
- Header protection against accidental AI modification.
- Designed for long-term maintainability.

## Requirements

- Python 3.8+
- ChronicleLogger (included as dependency or submodule)
- Standard build tools: `make`, `autoreconf`, `gtk+-3.0`, `webkit2gtk-4.1`, etc. (for the managed C/GTK projects)

## Links

- CIAO Philosophy: [github.com/Wilgat/ciao](https://github.com/Wilgat/ciao)
- Related projects: [gitlab-nginx](https://github.com/Wilgat/gitlab-nginx)

---

**Made with ❤️ for power users managing large collections of AI-related desktop clients.**

```
