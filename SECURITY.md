# Security Policy

## Overview

**SyncPrjs** is a specialized tool for managing large collections of **AI-friendly projects** — personal GNOME C/GTK desktop clients that use `WebKitWebView` to interact with AI services (Grok, Poe, Claude, etc.).

The core responsibility of SyncPrjs is **safe synchronization and persistence of browser cookies**, particularly:
- Google-related sessions (`*.google.com`, `*.youtube.com`, `*.accounts.google.com`, etc.)
- Cloudflare-related challenge cookies (`cf_clearance`, `__cf_bm`, etc.)

Because it directly modifies SQLite cookie databases in `~/.app/<project-name>/cookies/cookies.sqlite`, security, reliability, and auditability are paramount.

SyncPrjs follows the **CIAO defensive coding** philosophy (Clear, Intentional, Auditable, Over-protected) to minimize risks when the code is edited by humans or AI assistants.

---

## Threat Model

### What SyncPrjs Protects
- Long-lived Google login sessions across dozens or hundreds of prefix-suffix projects
- Cloudflare bypass/clearance tokens
- User sessions in AI web interfaces

### Potential Risks
- **Cookie destruction or corruption** during sync/merge operations
- Mixing of unrelated cookies (Google vs Cloudflare)
- Incorrect backup naming leading to unrecoverable sessions
- Accidental simplification of defensive code by AI assistants
- Privilege escalation or path traversal (though the tool runs under normal user privileges)

### Out of Scope
- Network-level attacks on the managed WebKitWebView applications
- Compromise of the underlying GNOME/GTK/WebKit environment
- Secrets stored outside of the cookie SQLite files

---

## Security Design Principles (CIAO)

SyncPrjs applies **CIAO defensive coding** throughout:

1. **Clear** — Extensive header comments explain intent, history of past failures, and exact rules (especially around backup naming and Cloudflare vs Google separation).
2. **Intentional** — Every critical function (cookie merge, backup, restore) has explicit warnings and does **only** what the name suggests.
3. **Auditable** — Full traceability via [ChronicleLogger](https://pypi.org/project/ChronicleLogger/). Every major operation is logged with component and level.
4. **Over-protected** — 
   - Mandatory backups using `create_cookie_backup_v2` **before** any write to `cookies.sqlite`
   - Safe merge logic that preserves non-target cookies
   - Explicit project name parameter (never derived from path to avoid the old "cookies" collision bug)
   - Strict Cloudflare-only filtering in `sync_cloudflare_cookies_v3`

These measures were added after real-world incidents where cookie collections were lost across 300+ projects.

---

## Cookie Handling Security

- **Backup Strategy**: Every modification triggers a timestamped backup in the format  
  `~/.app/<full-project-name>.YYYYMMDD-N.bak/cookies.sqlite`
- **Google Sync**: Uses `gm-*` projects as the single source of truth. Only Google-related cookies are replaced; all others are preserved.
- **Cloudflare Sync v3**: **Only** handles Cloudflare-related cookies (`cf_clearance`, `__cf_bm`, names/hosts containing "cf"). Never touches Google cookies.
- **Restore**: Requires explicit user confirmation and creates a new backup of the current state before restoring.
- **Inspection**: Read-only access with detailed statistics.

All database operations use temporary files + atomic `shutil.move` to reduce corruption risk.

---

## JSON and Quiet Mode Security

- `--json` mode outputs **exactly one** valid JSON object per run and implies `--quiet`.
- This prevents mixing of human-readable text with machine data, reducing parsing errors in automation scripts.
- Critical for secure integration in larger workflows.

---

## Reporting a Vulnerability

If you discover a security issue in SyncPrjs, please report it responsibly.

**Preferred method**:
1. Open a **private** issue on GitHub (if possible) or
2. Contact the maintainer directly via GitHub (Wilgat) with the subject "**SyncPrjs Security Report**".

Please include:
- Description of the vulnerability
- Steps to reproduce
- Potential impact (especially regarding cookie loss or session exposure)
- Suggested fix (if any)

We will acknowledge receipt within 48 hours and aim to address critical issues quickly.

**Do not** publicly disclose the vulnerability until a fix has been released.

---

## Best Practices for Users

- Always run SyncPrjs in a terminal you control.
- Review the interactive menu carefully before confirming destructive actions (sync, restore, clean backups).
- Keep regular backups of the entire `~/.app/` directory.
- Use the tool's built-in backup and restore features instead of manual file operations.
- When editing the code, **never remove or simplify** the defensive headers — they exist to protect against accidental breakage by AI assistants or future maintainers.

---

## Dependency Security

- The only runtime dependency is **[ChronicleLogger](https://pypi.org/project/ChronicleLogger/)**.
- We recommend installing from PyPI and keeping it updated.
- For development, use a virtual environment (`pip install -e .`).

---

## AI-Assisted Development Note

This project is deliberately written in a verbose, heavily commented style to survive repeated editing by large language models.  
If you are an AI assistant helping with this codebase:

- **Do not** remove, shorten, or "clean up" the long header comments.
- **Never** turn real defensive functions into placeholders.
- Respect the strict rules documented in the code (especially backup naming v2, Cloudflare-only logic, and JSON output contract).

These protections exist because past AI "improvements" have caused permanent loss of working cookie sessions.

---

## Contact

- Repository: https://github.com/Wilgat/SyncPrjs
- Maintainer: Wilgat

---

**Last updated**: April 2026  
**Version**: 1.1.1+

