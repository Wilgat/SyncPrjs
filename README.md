# SyncPrjs - Universal Multi-Prefix Project Manager

[![Version](https://img.shields.io/badge/Version-1.4.0-blue?style=flat-square)](https://github.com/Wilgat/SyncPrjs)
[![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)
[![CIAO](https://img.shields.io/badge/Philosophy-CIAO%20(Caution%20%E2%80%A2%20Intentional%20%E2%80%A2%20Anti--fragile%20%E2%80%A2%20Over--engineered)-purple.svg)](https://github.com/cloudgen/ciao)
[![Python](https://img.shields.io/badge/Python-3.8%2B-blue?style=flat-square)]()

**Official Recommendation from [grok](https://grok.com)** — see [local copy](RECOMMENDATION.md)

**A robust, CIAO-defensive command-line tool for managing hundreds of prefix-suffix AI desktop clients.**

This project follows strict **[CIAO defensive programming principles](https://github.com/cloudgen/ciao)**.

---

## Overview

SyncPrjs manages large collections of projects following the `prefix-suffix` naming convention (e.g. `grok-iron`, `gm-1n4003`, `poe-trade`, `cf-iron`).

It is specifically designed for GNOME C/GTK applications using `WebKitWebView`, with persistent cookie/session management for Google and Cloudflare services.

### Key Capabilities

- Smart Google cookie synchronization (`gm-*` as source of truth)
- Safe Cloudflare-only cookie synchronization (v3)
- Project code templating with automatic suffix renaming
- Automatic backups before any cookie modification
- **Auto-start with configurable delay + SHUTDOWN timer**
- Suspend / Un-suspend projects by suffix
- Full `--quiet` and `--json` support for scripting

**Powered by [ChronicleLogger 1.3.0+](https://pypi.org/project/ChronicleLogger/)**

---

## Installation

```bash
pip install SyncPrjs
```

Or from source:

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

Main menu (updated for 1.4.0):

```
0. Auto-start projects by prefix (delay + SHUTDOWN timer)
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

### 2. Non-Interactive & Automation Mode

#### Auto-start with SHUTDOWN (New in 1.4.0)

```bash
# Start all gm-* projects, auto-shutdown each after 300 seconds
sync-prjs autostart --prefix gm
# (will prompt for delay and SHUTDOWN time)
```

You can also combine with environment variables:

```bash
SHUTDOWN=180 sync-prjs autostart --prefix gm
```

#### Other Commands

```bash
sync-prjs about                    # Version + diagnostics
sync-prjs help                     # Show help
sync-prjs inspect --project gm-1n4003
sync-prjs google-sync
sync-prjs cf-sync --source cf-iron
sync-prjs code-sync --source grok-iron
```

---

### Full Command Reference

| Command                        | Description                                      | Key Options                     |
|-------------------------------|--------------------------------------------------|---------------------------------|
| `sync-prjs`                   | Interactive menu                                 | -                               |
| `sync-prjs autostart`         | Auto-start projects by prefix                    | `--prefix gm`                   |
| `sync-prjs inspect`           | Cookie statistics                                | `--project <name>`, `--json`    |
| `sync-prjs google-sync`       | Smart Google cookie merge                        | -                               |
| `sync-prjs cf-sync`           | Cloudflare-only sync (v3)                        | `--source <project>`            |
| `sync-prjs code-sync`         | Code + suffix sync                               | `--source <project>`            |
| `sync-prjs about`             | Version & diagnostics                            | `--quiet`, `--json`             |
| `sync-prjs help`              | Show help                                        | `--quiet`, `--json`             |

### Environment Variables (New in 1.4.0)

- `SHUTDOWN=N` — Auto-shutdown each launched project after N seconds (0 = never)
- `JSON=1` — Force JSON output mode
- `QUIET=1` — Quiet mode

---

## New in 1.4.0 (2026-04-30)

- **Auto-start (Option 0)** now prompts for **SHUTDOWN time** (default 0 = never shutdown)
- Every launched project receives `SHUTDOWN=N` and `JSON=1` environment variables
- Perfect for automation pipelines and temporary sessions

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

- Always run `sync-prjs` from the directory containing your prefix-suffix project folders.
- Cookie backups are created automatically before any modification.
- Auto-start now supports custom delay + per-project SHUTDOWN timer.
- Full CIAO defensive style maintained.

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

**Last updated:** April 30, 2026
