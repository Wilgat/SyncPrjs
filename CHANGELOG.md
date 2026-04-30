# CHANGELOG.md

## [1.4.0] - 2026-04-30

### Added
- **Enhanced Option 0 (Auto-start projects by prefix)**:
  - After choosing prefix and delay, user is now prompted for **SHUTDOWN time in seconds**
  - Default = `0` (never shutdown)
  - Input validation (non-negative integer only)
- Each launched project now receives:
  - `SHUTDOWN=N` environment variable (as requested)
  - `JSON=1` environment variable (prepares full automation / quiet mode integration)
- Updated `start_project()` method to support custom environment variables (`extra_env` dict)
- Full logging of SHUTDOWN value for each launched project

### Changed
- Option 0 menu description updated to reflect new SHUTDOWN feature
- Auto-start now passes both `SHUTDOWN` and `JSON` env vars to every project (gm-*, grok-*, poe-*, etc.)
- Version bumped to **1.4.0** across all files
- Improved defensiveness in environment handling for launched processes

### Fixed
- Fixed `start_project()` signature mismatch that caused "unexpected keyword argument 'extra_env'" error

### Notes
- Fully respects CIAO Defensive Coding principles (minimal change, strong protection, clear intent)
- Maintains backward compatibility (pressing Enter = SHUTDOWN=0 = no change in previous behavior)
- Perfect for automation pipelines: `sync-prjs 0 --prefix gm` combined with SHUTDOWN and JSON modes

---

## [1.3.5] - 2026-04-17

### Added
- New feature: **Suspend projects by suffix** (Option 10)
- New feature: **Un-suspend projects by suffix** (Option 11)
- Option 0 (Auto-start): Now prompts for custom delay between launches (default 20 seconds)

### Fixed
- Fixed suffix extraction bug in un-suspend feature
- Fixed `logger.warning()` violation in `main()`

### Changed
- Updated menu: Option 0 text changed to "Auto-start projects by prefix (configurable delay)"
- Version bumped to 1.3.5

---

## [1.3.4] - 2026-04-15
### Added
- **Cloudflare Cookie Sync v3** (safe Cloudflare-only merge)
- Backup v2 system with correct naming (`{full-project-name}.YYYYMMDD-N.bak`)
- Restore cookies, Remove backup folders, Show database structure, etc.
- Strict SQLite schema protection

*(previous entries unchanged)*

---

## [Unreleased]
*(kept for future changes)*

---

**Last updated**: April 30, 2026