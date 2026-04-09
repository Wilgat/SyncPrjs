# Design Document for `LoggedExample / logged-example`

## Overview
The `LoggedExample / logged-example` is a CyMaster-type Cython project serving as a template for integrating the `ChronicleLogger` utility into Python applications, demonstrating structured logging, CLI handling, and privilege-aware path resolution for Linux environments . It provides an `Example` class that initializes with a base directory and logger instance, supporting basic operations like displaying info messages while routing output through `ChronicleLogger` for timestamps, PIDs, levels, and components . The project supports dual naming: `LoggedExample` for Cython-compiled binaries (CamelCase preserved) and `logged-example` for Python scripts or pip installations (kebab-case via logger normalization) . Imported modules like `ChronicleLogger` are handled as `.so` files in the executable directory, with lazy evaluation for paths (`baseDir()`, `logDir()`) and debug mode via `DEBUG=show` environment variable . No external pip dependencies beyond `ChronicleLogger`; semantic version 1.1.0 with CHANGELOG.md for tracking updates .

For installation via pip (system-wide or virtual environment), use:
```
pip install LoggedExample
```
This installs the package, enabling imports like `from LoggedExample import Example` and CLI execution via `logged-example info` . For development, use editable install: `pip install -e .` after cloning the repo, ensuring requirements.txt includes `ChronicleLogger` for logging support .

## Target Operating System
- **Linux**: Designed for Linux (e.g., Ubuntu 24.04 default), leveraging POSIX features like `os.geteuid()` for root detection, `os.path.expanduser("~")` for user paths, and `subprocess.Popen` for non-interactive sudo checks without prompts . Path resolution uses `/var/log/<app>` for native root (euid==0 without sudo) and `~/.app/<app>/log` for sudo-elevated or normal users, aligning with filesystem standards; test on other distros for `/var/log` variations . On non-Linux (e.g., macOS/Windows via Git Bash/WSL), adapt via `os.path.join()` for cross-platform paths, but privilege detection assumes Unix semantics—use Docker for emulation if needed .

## Folder Structure
The project follows a standard CyMaster Cython layout for maintainability, separating source, docs, and builds with Git integration for version control . Key files include `__init__.py` exposing `ChronicleLogger` and `Example`, `__main__.py` for direct execution, and `cli.py` for CLI logic; use `.gitignore` to exclude `__pycache__`, `build/`, and `dist/` . Example structure:

```
LoggedExample/
├── README.md
├── build/                  # Build artifacts (e.g., bdist.linux-x86_64)
├── build.sh                # POSIX sh script for builds (e.g., python setup.py build_ext --inplace)
├── cy-master               # CyMaster integration folder
├── cy-master.ini           # Config: [project] srcFolder=src, buildFolder=build, targetName=LoggedExample, targetType=bin, require=ChronicleLogger 
├── docs/
│   ├── CHANGELOG.md        # Version history (e.g., "v1.1.0: Integrated ChronicleLogger") 
│   ├── LoggedExample-spec.md  # This design document
│   └── folder-structure.md    # Tree visualization
├── pyproject.toml          # Hatchling backend for builds (optional; requires-python >=2.7, no deps) 
├── requirements.txt        # Testing deps only (e.g., pytest==4.6.11, mock for Py2) 
├── .gitignore              # Ignores __pycache__/, build/, dist/, *.pyc, .env 
└── src/
    ├── LoggedExample.pyx   # Cython source (compiles to .c/.so)
    ├── LoggedExample/      # Package subdir
    │   ├── __init__.py     # Exposes ChronicleLogger, Example; __version__="1.1.0", __all__=["ChronicleLogger", "Example"]
    │   ├── __main__.py     # Entry: from .cli import main; if __name__ == "__main__": main()
    │   └── cli.py          # CLI: Example class, main() with logger init and 'info' command
    └── setup.py             # Packaging: from setuptools import setup; from Cython.Build import cythonize; ext_modules=cythonize("LoggedExample.pyx", compiler_directives={"language_level": "3"})
```

For setup: `git init; git add .; git commit -m "Initial commit"`; add to requirements.txt: `ChronicleLogger`; install: `pip3 install -r requirements.txt` . Docker support via Dockerfile (FROM python:3.12-slim; RUN pip install -e .) and docker-compose.yml for multi-container testing with DEBUG=show .

### Parameters
- **info**: CLI command to display an example message via `app.info()`, logged through ChronicleLogger .

## Project Name Conversion Rules
- **CamelCase to Kebab/Snake Case**: In Python mode, `logName()` converts input (e.g., "LoggedExample") to kebab-case ("logged-example") via regex `re.sub(r'(?<!^)(?=[A-Z])', '-', name).lower()` for paths and filenames; preserved as CamelCase in Cython binaries . Directories use kebab-case for user contexts (`~/.app/logged-example/log`) or CamelCase for root (`/var/log/LoggedExample`) .
- **Path Adaptation**: `baseDir()` defaults to `/var/<app>` (root) or `~/.app/<app>` (user); `logDir()` appends `/log`. Custom overrides via init params ignore conversion .
- **File Handling**: CLI executable as `logged-example` post-pip install; binary as `LoggedExample` after `python setup.py build_ext --inplace` .

## Class Structure
The `Example` class (in cli.py) demonstrates ChronicleLogger integration for logging in apps, with static versioning and fallback print if no logger provided .

### Attributes
| Variable Name       | Description                                               |
|---------------------|-----------------------------------------------------------|
| `basedir`           | Base directory path (default "/var/app"), independent of logger paths for configs . |
| `logger`            | Optional ChronicleLogger instance for structured output (timestamps, PID, levels) . |
| `CLASSNAME`         | Static string "Example" for versioning . |
| `MAJOR_VERSION`, `MINOR_VERSION`, `PATCH_VERSION` | Static integers (1.1.0) for semantic versioning . |

### Methods

#### Instance Methods
- **`__init__(self, basedir="/var/app", logger=None)`**
  - **Logic**: Sets `self.basedir` and `self.logger`; uses ChronicleLogger for privilege-aware paths if provided .
  - **Input Parameters**:
    - `basedir` (str/bytes): Custom base dir (e.g., "/opt/app"); defaults to privilege-derived path .
    - `logger` (ChronicleLogger or None): Logger instance; falls back to print() if absent .
  - **Return Parameters**: None.
  - **Notes**: Lazy init; logs via `self.log()` route to file/console with rotation/archiving .

- **`log(self, message, level="INFO", component="")`**
  - **Logic**: Calls `logger.log_message()` if available; else prints raw message .
  - **Input Parameters**:
    - `message` (str/bytes): Log content, UTF-8 handled via strToByte/byteToStr .
    - `level` (str, default "INFO"): Log level (e.g., "ERROR" to stderr) .
    - `component` (str, default ""): Optional prefix (e.g., "main") in format `@<COMPONENT>` .
  - **Return Parameters**: None.

- **`info(self)`**
  - **Logic**: Prints/Logs "This is an example app" via `self.log()` .
  - **Input Parameters**: None.
  - **Return Parameters**: None.
  - **Notes**: Demonstrates basic functionality; in CLI, triggered by `info` arg .

#### Static Methods
- **`class_version()`**
  - **Logic**: Returns formatted string e.g., "Example v1.1.0" .
  - **Input Parameters**: None.
  - **Return Parameters**: str (version string).

CLI `main()`: Initializes logger with `logname='LoggedExample'`, normalizes to kebab-case, derives paths, handles args (e.g., `info`), creates `Example` instance, and calls `info()`; exits on invalid cmds with usage .

## Functionality Supported
- **Logging Integration**: Routes all output via ChronicleLogger for daily rotation (e.g., `<app>-YYYYMMDD.log`), archiving (>7 days tar.gz), removal (>30 days), and console mirroring (stdout INFO/DEBUG, stderr ERROR/CRITICAL/FATAL) .
- **CLI Handling**: Parses `sys.argv` for commands like `info`; supports debug mode to log versions and file paths on rotation .
- **Privilege Awareness**: Paths adapt via `_Suroot`: system (/var/log) for native root, user (~/.app) for sudo/normal; kebab-casing in Python, preserved in Cython .
- **Versioning and Fallbacks**: Static class_version(); print() if no logger; UTF-8/byte handling for Py2/3 compat .
- **Build/Deploy**: Cython compilation for binaries; pip install for scripts; no deps beyond ChronicleLogger .

## Usage Example
For pip install: `pip install LoggedExample`; run CLI: `logged-example info` (logs "This is an example app" to file/console) .

In code (post-install or editable):

```python
from LoggedExample import Example, ChronicleLogger  # From __init__.py

# Init logger (privilege-aware)
logger = ChronicleLogger(logname="LoggedExample")  # Normalizes to "logged-example" in Py mode
appname = logger.logName()  # "logged-example"
basedir = logger.baseDir()  # e.g., "/var/logged-example" (root) or "~/.app/logged-example" (user)

# Create instance
app = Example(basedir=basedir, logger=logger)

# Log via class
app.log("Custom message", level="INFO", component="main")
app.info()  # "This is an example app" via logger

# Debug: Set DEBUG=show; logs versions on init
print(Example.class_version())  # "Example v1.1.0"
```

CLI direct: `python -m LoggedExample info` (via __main__.py) or compiled binary `LoggedExample info` . For root: Uses /var paths; sudo/normal: User paths; enable DEBUG=show for path/version output .

## Conclusion
The `LoggedExample / logged-example` serves as a template for CyMaster Cython projects, emphasizing ChronicleLogger integration for reliable logging in CLI apps on Linux . It promotes POSIX compliance, semantic versioning, and easy deployment via pip or builds, with tests in `tests/test_example.py` (e.g., mock logger, assert info output) .

### Future Considerations
- Add multi-OS path fallbacks (e.g., /tmp for non-Linux) and unit tests for CLI/privileges via pytest (pin 4.6.11 for Py2) .
- Extend to project conversion (CamelCase to snake_case) if needed, copying .pyx to .py with cy-master.ini .
- Maintain resolveSysPath-like logic in imports for .so handling in pipelines/Jupyter .