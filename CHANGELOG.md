# CHANGELOG.md

## [1.3.5] - 2026-04-17

### Added
- New feature: **Suspend projects by suffix** (Option 10)
  - User can enter a normal suffix (e.g. `atwork`, `trade`)
  - Automatically finds and renames matching projects to `<project>.suspended`
  - Creates backup before renaming
- New feature: **Un-suspend projects by suffix** (Option 11)
  - User selects a suffix to restore
  - Automatically renames `<project>.suspended` back to original name
  - Creates backup before renaming
- Option 0 (Auto-start): Now prompts for **custom delay** between launches (default 20 seconds)
  - Input validation (must be positive integer)
  - Press Enter to use default 20s

### Fixed
- Fixed suffix extraction bug in un-suspend feature (no more truncated names like "atwor", "trad")
- Fixed `logger.warning()` violation in `main()` to use `logger.log_message()` per CIAO rule
- Improved robustness of suspended project detection

### Changed
- Updated menu: Option 0 text changed to "Auto-start projects by prefix (configurable delay)"
- Version bumped to 1.3.5 across all files

### Notes
- All existing features (including Option 9 - Show database structure) preserved
- Full CIAO defensive style maintained
- No breaking changes

---

## [Version 1.3.4] - 2026-04-15
### Added
- **Cloudflare Cookie Sync v3** (`sync_cloudflare_cookies_v3`): Fully interactive safe merge that synchronizes *only* Cloudflare-related cookies (cf_clearance, __cf_bm, __cf*, any "cf" in name or host). Source is now user-selected (any project under the prefix) instead of hard-coded gm-*. Preserves all non-Cloudflare cookies (including Google sessions).
- `safe_merge_cloudflare_only()`: Dedicated Cloudflare-only merge logic using temporary DB + atomic move.
- **Backup v2 system** (`create_cookie_backup_v2`): Mandatory backup before any cookie modification. Uses explicit full project name (never derived from path) and correct format: `~/.app/{full-project-name}.YYYYMMDD-N.bak/cookies.sqlite`.
- `restore_cookies()`: Updated to scan top-level `~/.app/` for v2-format backups, shows newest first, requires explicit confirmation, and creates a new backup before restore.
- `remove_backup_folders()` (new Option 7): Allows selective removal of sync backups or cookie backups (or both) with clear scanning in project parents and `~/.app/`.
- Strict SQLite schema protection across all cookie operations (only real moz_cookies columns: id, name, value, host, path, expiry, lastAccessed, isSecure, isHttpOnly, sameSite).
- `show_database_structure()` (new Option 9): Displays PRAGMA table_info + full CREATE TABLE statement (supports both interactive and `--json --project` modes).
- Improved non-interactive CLI support for `autostart --prefix <prefix>` with better normalization, error messages, and JSON output.
- Comprehensive **CIAO defensive coding headers** throughout the codebase with explicit warnings against simplification, removal of comments, mixing Google/Cloudflare logic, or path-derived project names.

### Changed
- Renamed `sync_cookies` → `sync_google_cookies` for crystal-clear separation from Cloudflare functionality.
- `safe_merge_google_cookies()` and `full_cookie_copy()` now enforce mandatory v2 backups before any write.
- `clean_backups()` updated to correctly scan v2 backup locations.
- Enhanced quiet/JSON mode with documented output contract (examples for about/inspect/help/error). `output_text()` and `output_json()` are now the single source of truth.
- Updated main menu: Option 7 is now "Remove backup folders", old clean behavior moved to Option 8.
- Strengthened logging enforcement: always uses `logger.log_message(level=..., component=...)` (ChronicleLogger compatible).
- Code sync flow made more explicit with separate helpers for missing suffixes, target selection, and final confirmation (clear (NEW) markers and target list before proceeding).

### Fixed
- Critical backup naming bug that caused collisions into "cookies.202604XX-N.bak" folders (making restore impossible).
- Past Cloudflare sync issues where Google logic was incorrectly copied into Cloudflare functions.
- Restore and clean operations now correctly locate v2 backups in `~/.app/`.
- Schema-related crashes by never assuming Firefox-style columns (creationTime, baseDomain, etc.).
- Improved edge-case handling in non-interactive modes and prefix normalization.

### Security
- All cookie-modifying paths now create backups first.
- Loud, repeated defensive headers to protect against future AI-assisted destructive "cleanups" or simplifications.
- Strict separation of Google (gm-* source) and Cloudflare (user-chosen source) logic.

---

## [Version 1.3.3] - 2026-04-13
### Changed
- align version to 1.3.3

---

## [Version 1.3.1] - 2026-04-12
### Added
- `quiet()` method to get or set the `__is_quiet__` flag after object instantiation.
  This allows dynamic enabling/disabling of console output (`prn()` / `prn_err()`) without recreating the logger.

### Changed
- Updated class version to 1.3.1 (internal `MAJOR_VERSION`, `MINOR_VERSION`, `PATCH_VERSION` should be bumped accordingly if not already done).

---

## [Unreleased]
### Added
- Initial support for semantic versioning tracking in documentation.
- Recommendations for Git initialization and .gitignore integration to track changelog updates.

### Changed
- Updated changelog structure to follow standard categories (Added, Changed, Deprecated, Removed, Fixed, Security) for better readability and reverse chronological order.
- Renamed file header to "CHANGELOG.md" for consistency with common project conventions.

### Fixed
- Corrected version dates and descriptions for clarity; ensured concise, informative entries.

---

## [Version 1.1.0] - 2025-09-26
... (rest of your original content unchanged)