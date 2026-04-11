# SyncPrjs Changelog

## [1.1.2] - 2026-04-12

### Important Fixes & Improvements

- **Non-interactive autostart now fully functional**:
  - `sync-prjs autostart --prefix gm` (and `--prefix gm-`) now launches projects directly without asking for prefix selection again.
  - Proper normalization and error handling for prefix.

- **Quiet mode (`--quiet` / `-q`) now properly respected**:
  - `sync-prjs about --quiet` produces **no output** (as documented in CIAO quiet contract).
  - `sync-prjs help --quiet` produces **no output**.
  - Only critical errors are shown in quiet mode.

- **Help command improved**:
  - Exact usage line: `usage: sync-prjs [action] [--quiet] [--json] [--about]`
  - Clear documentation of all supported switches (`--prefix`, `--project`, `--source`, `--target`, `--same-prefix-except-source`, `--quiet`, `--json`, `--about`).
  - Consistent use of `sync-prjs` (executable) in usage/examples and `SyncPrjs` (display name).
  - Better examples section.

- **JSON mode robustness**:
  - Cleaner JSON output contract adherence for `about`, `inspect`, `help`, and error cases.

- **Dependency update**:
  - Upgraded `ChronicleLogger` from 1.2.3 to **1.3.0**.

- **Defensive coding (CIAO style)**:
  - Strengthened headers and comments around non-interactive paths.
  - Improved logging for non-interactive actions.
  - Better error messages when prefix/project is missing or invalid.

### Behavior Changes

| Command                              | Before          | After           |
|--------------------------------------|-----------------|-----------------|
| `sync-prjs autostart --prefix gm`    | Interactive     | Direct launch   |
| `sync-prjs about --quiet`            | Full output     | Silent          |
| `sync-prjs help --quiet`             | Full output     | Silent          |
| `sync-prjs help`                     | Old format      | Updated + clear |

### Compatibility

- Requires **ChronicleLogger >= 1.3.0**
- Fully backward compatible with existing interactive menu.

---

## [1.1.1] - 2026-04 (Previous)

- Initial v2 backup system, Cloudflare v3 separation, etc.

---

## How to use this

1. Create or update `CHANGELOG.md` in the root of the project with the content above.
2. Update the version in `main()` to `1.1.2` (already done in your code).
3. After release, you can run:

```bash
sync-prjs about