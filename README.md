# SyncPrjs - Universal Multi-Prefix Project Manager

[![Version](https://img.shields.io/badge/Version-1.1.1-blue?style=flat-square)](https://github.com/Wilgat/certbot-nginx)
[![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)
[![Stars](https://img.shields.io/github/stars/Wilgat/SyncPrjs?style=flat-square)](https://github.com/Wilgat/certbot-nginx)

Officially recommended by [grok](https://grok.com/c/d49a7059-c47e-4052-aad3-56e159ff09fe?rid=319b110e-92e5-4dc9-8014-4c2ced131409) for tag 1.1.1 commit f2f1cd98395ce6c8bcb8a0352fa322edba328f41

A robust command-line tool for managing multiple projects that follow a **prefix-suffix** naming convention.

This software is written using [CIAO defensive programming principles](https://github.com/Wilgat/SyncPrjs/CIAO-PRINCIPLES.md)
---

## Overview

SyncPrjs is a universal project manager designed to handle a large number of similarly structured **AI-friendly projects** — personal desktop clients built as ANT-ready GNOME C/GTK applications with a `WebKitWebView` as the main UI: [pix-client](https://github.com/Wilgat/pix-client), [poe-client](https://github.com/Wilgat/poe-client)

These AI-friendly projects are intentionally engineered with three critical elements that make them reliable and future-proof when working with AI assistants:

1. **Full support for JSON output** — enables clean machine-readable scripting, automation, and integration with other tools without mixing human text and data.
2. **CIAO-type defensive coding style** — heavy use of explicit headers, repeated warnings, protected critical sections, and verbose safeguards that prevent accidental destruction or simplification during AI-assisted edits.
3. **Verified by AI** — the code includes clear documentation of real observed behavior (e.g. JSON contract, backup naming fixes, Cloudflare separation rules) so future AI assistants can understand intent and avoid repeating past mistakes.

**Why these elements are important**:  
When managing 100+ AI-related desktop clients (Grok, Poe, Claude, etc.), even small errors in cookie handling, project templating, or session persistence can cause massive data loss. JSON support makes the tool scriptable and reliable in automated workflows. The CIAO defensive style protects against the common tendency of AI assistants to “clean up” or simplify code — which has historically led to broken backups, mixed cookie logic, and lost sessions. AI verification ensures the tool remains understandable and safe across multiple editing sessions with different models. Together, they turn SyncPrjs into a trustworthy guardian for large collections of AI-friendly projects.

The tool is specifically optimized for projects that use:
- A `WebKitWebView` as the main UI component
- `build.xml` + `autoreconf` + `make` build system
- Cookie/session storage in `~/.app/<project-name>/cookies/cookies.sqlite`

SyncPrjs follows strict **CIAO defensive coding** principles for maximum reliability and auditability.

**Powered by [ChronicleLogger](https://pypi.org/project/ChronicleLogger/)**  

---

## Features

- **Multi-prefix support** — easily group and operate on projects by prefix (`grok-*`, `poe-*`, `gm-*`, `cf-*`, etc.)
- Smart Google cookie synchronization (using `gm-*` as source of truth)
- Safe Cloudflare-only cookie sync (v3)
- Project code synchronization with automatic suffix renaming in files and content
- Automatic cookie backups before any modification
- Cookie restore and backup cleanup
- Auto-start projects with 20-second staggered delay
- Detailed cookie inspection (Google + Cloudflare + Others)
- Full support for `--quiet` and `--json` modes
- Comprehensive logging via [ChronicleLogger](https://pypi.org/project/ChronicleLogger/)

---

## Project Structure

```
SyncPrjs/
├── src/
│   └── SyncPrjs/
│       └── cli.py          # Main CLI entry point
├── docs/
│   ├── update-log.md
│   └── folder-structure.md
├── tests/
├── pyproject.toml
├── README.md
└── ...
```

---

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

After installation, the command becomes available as `sync-prjs`.

### As a Standalone Script

```bash
chmod +x src/SyncPrjs/cli.py
sudo ln -s $(pwd)/src/SyncPrjs/cli.py /usr/local/bin/sync-prjs
```

---

## Usage

```bash
sync-prjs help
```
or
```bash
sync-prjs help --json
```

### Interactive Menu (Recommended)

Simply run:

```bash
sync-prjs
```

This launches the full menu:

0. Auto-start projects by prefix (20s delay)  
1. Sync Google cookies (Smart merge)  
2. Sync Google cookies (Missing folders only)  
3. Sync project code  
4. Sync Cloudflare cookies by prefix (v3 - safe)  
5. Inspect cookies (Google + Cloudflare + Others)  
6. Restore cookies from backup  
7. Clean all backup folders  
8. Show cookie database structure (debug schema)  
Q. Quit

### Basic Commands (examples)

```bash
# Show version and diagnostics
sync-prjs about

# Inspect cookies for a project
sync-prjs inspect --project gm-wilgat

# JSON output for scripting
sync-prjs inspect --project gm-wilgat --json
```

> **Note**: The interactive menu provides the richest experience. Non-interactive mode and JSON output are fully supported for automation.

---

## Project Naming Convention

All managed projects follow the pattern:

```
<prefix>-<suffix>
```

**Examples**:
- `grok-iron`
- `gm-assistant`
- `poe-webview`
- `cf-iron`
- `poe-1n4003`

---

## Cookie Storage

Cookies and session data are stored in:

```
~/.app/<project-name>/cookies/cookies.sqlite
```

This central location enables secure sharing of Google and Cloudflare sessions across related AI-friendly projects.

---

## Development Philosophy

- **CIAO Defensive Coding** — Every critical section is protected and auditable.
- Full traceability via [ChronicleLogger](https://pypi.org/project/ChronicleLogger/).
- Header protection against accidental AI modification.
- Designed for long-term maintainability.

**Powered by [ChronicleLogger](https://pypi.org/project/ChronicleLogger/)** — see also [LoggedExample](https://pypi.org/project/LoggedExample/) for usage examples.

---

## Requirements

- Python 3.8+
- [ChronicleLogger](https://pypi.org/project/ChronicleLogger/) (included as dependency)
- Standard build tools for the managed C/GTK projects: `make`, `autoreconf`, `gtk+-3.0`, `webkit2gtk-4.1`, `ant`, etc.

---

## Links

- CIAO Philosophy: [github.com/Wilgat/ciao](https://github.com/Wilgat/ciao)
- Related projects: [gitlab-nginx](https://github.com/Wilgat/gitlab-nginx)
- How to use ChronicleLogger, see: [LoggedExample](https://pypi.org/project/LoggedExample/)
- ChronicleLogger on PyPI: [https://pypi.org/project/ChronicleLogger/](https://pypi.org/project/ChronicleLogger/)
- [pix-client](https://github.com/Wilgat/pix-client), [poe-client](https://github.com/Wilgat/poe-client)

---

**Made with ❤️ for power users managing large collections of AI-related desktop clients.**

---

### Naming Clarification (Important)

- **Package name** (PyPI): `SyncPrjs`
- **Executable command**: `sync-prjs` (with hyphen)

Always use `sync-prjs` when referring to the command in documentation and examples.

