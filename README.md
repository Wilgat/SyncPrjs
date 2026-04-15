# SyncPrjs - Universal Multi-Prefix Project Manager

[![Version](https://img.shields.io/badge/Version-1.3.3-blue?style=flat-square)](https://github.com/Wilgat/SyncPrjs)
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
- Auto-start with staggered delay
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
# Start all projects under a specific prefix with 20-second delay
sync-prjs autostart --prefix gm
sync-prjs autostart --prefix grok
sync-prjs autostart --prefix poe
sync-prjs autostart --prefix cf
```

#### Cookie Inspection

```bash
# Inspect a specific project
sync-prjs inspect --project gm-wilgat

# JSON output (perfect for scripting)
sync-prjs inspect --project gm-wilgat --json

# Quiet inspection
sync-prjs inspect --project gm-wilgat --quiet
```

#### Google Cookie Sync

```bash
# Smart merge (recommended - preserves non-Google cookies)
sync-prjs google-sync

# Only new/missing project folders
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
sync-prjs schema --project gm-wilgat --json
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
| `sync-prjs autostart`         | Non-interactive   | `--prefix <gm\|grok\|poe\|cf...>`    | Auto-launch projects |
| `sync-prjs inspect`           | Non-interactive   | `--project <name>`, `--json`         | Cookie statistics |
| `sync-prjs google-sync`       | Non-interactive   | -                                    | Smart Google cookie merge |
| `sync-prjs google-missing`    | Non-interactive   | -                                    | Copy to missing folders only |
| `sync-prjs cf-sync`           | Non-interactive   | `--source <project>`                 | Cloudflare-only sync (v3) |
| `sync-prjs code-sync`         | Non-interactive   | `--source <project>`                 | Code + suffix sync |
| `sync-prjs restore`           | Interactive       | -                                    | Restore from backup |
| `sync-prjs clean-backups`     | Interactive       | -                                    | Delete old backups |
| `sync-prjs schema`            | Non-interactive   | `--project <name>`, `--json`         | Show DB structure |

---

### JSON Mode Examples (for scripting/automation)

```bash
# Get cookie stats in JSON
sync-prjs inspect --project gm-wilgat --json

# About information
sync-prjs about --json
```

Example output:
```json
{
  "type": "inspect",
  "command": "inspect",
  "project": "gm-wilgat",
  "success": true,
  "total_cookies": 107,
  "google_cookies": 89,
  "cloudflare_cookies": 2,
  "other_cookies": 16,
  "timestamp": "20260412-014500"
}
```

---

## Project Naming Convention

All projects must follow: `<prefix>-<suffix>`

**Common prefixes:**
- `gm-` → Google Master (source of truth for Google cookies)
- `grok-`, `poe-`, `cf-`, `gacc-`, `yt-`, etc.

---

## Cookie Storage Location

```
~/.app/<full-project-name>/cookies/cookies.sqlite
```

Example: `~/.app/gm-wilgat/cookies/cookies.sqlite`

---

## Important Notes

- Always run SyncPrjs from the directory containing your prefix-suffix project folders.
- Cookie backups are created automatically before any modification using the safe format: `~/.app/{project}.YYYYMMDD-N.bak/`
- Cloudflare sync (v3) only touches Cloudflare-related cookies.
- Google sync uses `gm-*` projects as the authoritative source.

---

## Development Philosophy

This tool is built with **CIAO Defensive Programming Principles v2.9.1**  (Short form: [CIAO](https://github.com/cloudgen/ciao) ) to survive repeated AI-assisted modifications without losing critical safety features.

**Requires ChronicleLogger 1.3.0+**

---

## Links

- [ChronicleLogger on PyPI](https://pypi.org/project/ChronicleLogger/)
- [CIAO Philosophy](https://github.com/Wilgat/ciao)
- Related projects: [github-client](https://github.com/cloudgen/github-client), [pix-client](https://github.com/Wilgat/pix-client), [poe-client](https://github.com/Wilgat/poe-client),
[pix-client](https://github.com/Wilgat/pix-client)

---

**Made with ❤️ for power users managing large collections of AI desktop clients.**
```
