# SyncPrjs - Universal Multi-Prefix Project Manager

[![Version](https://img.shields.io/badge/Version-1.3.5-blue?style=flat-square)](https://github.com/Wilgat/SyncPrjs)
[![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)
[![CIAO](https://img.shields.io/badge/Philosophy-CIAO%20(Caution%20%E2%80%A2%20Intentional%20%E2%80%A2%20Anti--fragile%20%E2%80%A2%20Over--engineered)-purple.svg)](https://github.com/cloudgen/ciao)
[![Python](https://img.shields.io/badge/Python-3.8%2B-blue?style=flat-square)]()

Official Recommendation from [grok](https://grok.com/c/05800c0e-8beb-4dd4-8fc5-8611423a1a64?rid=9a3b4a0a-8f6d-4667-b97c-208026495767) see [local copy](https://github.com/Wilgat/SyncPrjs/blob/main/RECOMMENDATION.md)

**A robust, CIAO-defensive command-line tool for managing hundreds of prefix-suffix AI desktop clients.**

This project follows strict [CIAO defensive programming principles](https://github.com/Wilgat/SyncPrjs/blob/main/CIAO-PRINCIPLES.md).

---

## Overview

SyncPrjs manages large collections of projects following the `prefix-suffix` naming convention (e.g. `grok-iron`, `gm-wilgat`, `poe-1n4003`, `cf-iron`).

It is specifically designed for GNOME C/GTK applications using `WebKitWebView`, with persistent cookie/session management for Google and Cloudflare services.

**Key Capabilities:**
- Smart Google cookie synchronization (`gm-*` as source of truth)
- Safe Cloudflare-only cookie synchronization (v3)
- Project code templating with automatic suffix renaming
- Automatic backups before any cookie modification
- **Auto-start with configurable delay**
- **Suspend / Un-suspend projects by suffix**
- Full `--quiet` and `--json` support for scripting

**Powered by [ChronicleLogger 1.3.0+](https://pypi.org/project/ChronicleLogger/)**

---

## Installation

```bash
pip install SyncPrjs
```

Or from source (editable):

```bash
git clone https://github.com/Wilgat/SyncPrjs.git
cd SyncPrjs
pip install -e .
```

The command `sync-prjs` will be available in your PATH.

---

## Usage

### 1. Interactive Mode (Default)

```bash
sync-prjs
```

This launches the full menu:

```
0. Auto-start projects by prefix (configurable delay)
1. Sync Google cookies (Smart merge)
2. Sync Google cookies (Missing folders only)
3. Sync project code
4. Sync Cloudflare cookies by prefix (v3 - safe)
5. Inspect cookies (Google + Cloudflare + Others)
6. Restore cookies from backup
7. Remove backup folders (sync + cookie backups)
8. Clean all backup folders (old behavior)
9. Show cookie database structure (debug schema)
10. Suspend projects by suffix (add .suspended)
11. Un-suspend projects by suffix (remove .suspended)
Q. Quit
```

### 2. Non-Interactive Mode (Recommended for daily use & scripting)

#### Basic Commands

```bash
# Show version and diagnostics
sync-prjs about

# Show help
sync-prjs help

# Quiet mode
sync-prjs about --quiet
sync-prjs help --quiet
```

#### Auto-start Projects

```bash
# Start all projects under a specific prefix (will prompt for delay)
sync-prjs autostart --prefix gm
```

#### Cookie Inspection

```bash
sync-prjs inspect --project gm-wilgat
sync-prjs inspect --project gm-wilgat --json
```

#### Google Cookie Sync

```bash
sync-prjs google-sync
sync-prjs google-missing
```

#### Cloudflare Cookie Sync (v3 - safe)

```bash
sync-prjs cf-sync --source cf-iron
```

#### Project Code Synchronization

```bash
sync-prjs code-sync --source grok-iron
```

#### Schema / Debug

```bash
sync-prjs schema --project gm-wilgat
```

#### Restore & Maintenance

```bash
sync-prjs restore
sync-prjs clean-backups
```

---

### Full Command Reference

| Command                        | Mode              | Key Options                          | Description |
|-------------------------------|-------------------|--------------------------------------|-----------|
| `sync-prjs`                   | Interactive       | -                                    | Full menu |
| `sync-prjs help`              | Non-interactive   | `--quiet`, `--json`                  | Show this help |
| `sync-prjs about`             | Non-interactive   | `--quiet`, `--json`                  | Version + diagnostics |
| `sync-prjs autostart`         | Non-interactive   | `--prefix <gm\|grok\|...>`           | Auto-launch projects (prompts for delay) |
| `sync-prjs inspect`           | Non-interactive   | `--project <name>`, `--json`         | Cookie statistics |
| `sync-prjs google-sync`       | Non-interactive   | -                                    | Smart Google cookie merge |
| `sync-prjs google-missing`    | Non-interactive   | -                                    | Copy to missing folders only |
| `sync-prjs cf-sync`           | Non-interactive   | `--source <project>`                 | Cloudflare-only sync (v3) |
| `sync-prjs code-sync`         | Non-interactive   | `--source <project>`                 | Code + suffix sync |
| `sync-prjs restore`           | Interactive       | -                                    | Restore from backup |
| `sync-prjs clean-backups`     | Interactive       | -                                    | Delete old backups |
| `sync-prjs schema`            | Non-interactive   | `--project <name>`, `--json`         | Show DB structure |

---

### JSON Mode Examples

```bash
sync-prjs inspect --project gm-wilgat --json
sync-prjs about --json
```

---

## Project Naming Convention

All projects must follow: `<prefix>-<suffix>`

**Common prefixes:** `gm-`, `grok-`, `poe-`, `cf-`, `yt-`, etc.

---

## Cookie Storage Location

```
~/.app/<full-project-name>/cookies/cookies.sqlite
```

---

## Important Notes

- Always run SyncPrjs from the directory containing your prefix-suffix project folders.
- **New in 1.3.5**: You can now suspend/un-suspend groups of projects by suffix (useful for temporarily disabling projects).
- Cookie backups are created automatically before any modification.
- Auto-start now allows custom delay (default 20 seconds).

---

## Development Philosophy

This tool is built with **CIAO Defensive Programming Principles** to survive repeated AI-assisted modifications.

**Requires ChronicleLogger 1.3.0+**

---

## Links

- [ChronicleLogger on PyPI](https://pypi.org/project/ChronicleLogger/)
- [CIAO Philosophy](https://github.com/cloudgen/ciao)

---

**Made with ❤️ for power users managing large collections of AI desktop clients.**
```

---
