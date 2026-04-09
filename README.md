# My Project

A modern Python project template optimized for Linux development, supporting Python 3.8+ with optional Cython builds for performance. It includes structured folders for docs, src, and tests, Git integration, and containerization via Docker for easy deployment and testing . No external dependencies by default; uses hatchling for packaging and pytest for testing, following 2025 best practices for PyPI uploads with README.md as the front page .

## Features
- Modular structure: src/ for source code, docs/ for specifications and changelog, tests/ for unit tests .
- Git-ready: Pre-configured .gitignore to exclude compiled modules, caches, and env files .
- Build system: pyproject.toml with hatchling backend for sdist/wheel generation; optional Dockerfile and docker-compose.yml for containerized runs .
- Documentation: update-log.md in docs/ for tracking project evolution, ensuring clear communication to contributors .
- Testing: Basic setup with test_main.py; integrate pytest via requirements.txt .

## Installation
Create an isolated environment (venv recommended) and install dependencies :

```bash
# Confirm Python version: python3 --version (requires >=3.8)
python3 -m venv venv
source venv/bin/activate  # Linux/macOS; on Windows: venv\Scripts\activate

# Install from requirements.txt (example: pytest for testing)
pip install -r requirements.txt  # Add deps like "pytest>=7.0" to file 
```

For editable development install (links src/ for changes) :

```bash
# Install build tools
pip install hatchling setuptools

# Editable install
pip install -e .
```

Build wheel/sdist: `hatch build` (uses pyproject.toml) or `python setup.py sdist bdist_wheel` if using setup.py . For PyPI upload: `hatch publish` after `git tag v0.1.0; git push --tags` .

Containerized setup (optional) :

```bash
# Build and run with Docker
docker build -t my-project .
docker run --rm my-project  # Or use docker-compose up for multi-service
```

## Project Structure
Follow this clean layout for scalability, separating concerns for source, docs, tests, and builds :

```
my_project/
├── docs/                   # Documentation and specs
│   ├── update-log.md       # Project evolution and changelog 
│   └── folder-structure.md # Visualize tree with tools like tree or DirTree
├── src/                    # Source code
│   └── main.py             # Entry point (e.g., from __future__ import ...; def main(): ...)
├── tests/                  # Unit/integration tests
│   └── test_main.py        # e.g., import pytest; def test_main(): assert True
├── .gitignore              # Excludes caches, builds, envs 
├── README.md               # This file; becomes PyPI front page via pyproject.toml 
├── requirements.txt        # Runtime/testing deps (e.g., pytest==7.4.0) 
├── pyproject.toml          # Build config (hatchling backend, no CLI by default) 
├── LICENSE                 # e.g., MIT license file 
├── Dockerfile              # Container build (FROM python:3.12-slim; COPY . .; RUN pip install -e .) 
└── docker-compose.yml      # Services config (version: '3.8'; services: app: build: .) 
```

To initialize :

```bash
mkdir -p my_project/{docs,src,tests}
cd my_project
touch .gitignore README.md requirements.txt docs/update-log.md src/main.py tests/test_main.py LICENSE Dockerfile docker-compose.yml
git init
git add .
git commit -m "Initial commit"
```

Example .gitignore :

```
# Compiled python modules
.env
__pycache__/
*.pyc
*.pyo
*.pyd
.Python
build/
dist/
*.egg-info/
.coverage
htmlcov/
```

Example requirements.txt :

```
pytest>=7.0
# Add project-specific deps here, e.g., requests==2.31.0
```

Example pyproject.toml (copy-paste for PyPI-ready setup) :

```toml
[build-system]
requires = ["hatchling >= 1.18"]
build-backend = "hatchling.build"

[project]
name = "my-project"                     # Change to your project name
version = "0.1.0"
description = "Amazing one-liner that appears under the title on PyPI"
readme = "README.md"                    # PyPI will show this exact file as the front page
requires-python = ">=3.8"
license = { text = "MIT" }
dependencies = []                       # No runtime deps; add via requirements.txt
```

For CLI entry (optional, add to pyproject.toml under [project.scripts]) :

```toml
[project.scripts]
my-project = "src.main:main"
```

## Usage
Run the main script directly :

```python
# src/main.py example
#!/usr/bin/env python3
from __future__ import print_function
import sys

def main():
    if len(sys.argv) > 1 and sys.argv[1] == "info":
        print("Project info: Running on Python 3.x")
    else:
        print("Usage: python -m my_project info")

if __name__ == "__main__":
    main()
```

Execute: `python -m src.main info` or post-install: `my-project info` (if CLI configured) .

For testing :

```bash
pip install -r requirements.txt
pytest tests/ -v  # Runs test_main.py
```

Container run :

```yaml
# docker-compose.yml example
version: '3.8'
services:
  app:
    build: .
    volumes:
      - .:/app
    command: python -m src.main info
```

`docker-compose up` to test in isolation .

Example test_main.py :

```python
import pytest
from src.main import main

def test_main(capsys):
    main()
    captured = capsys.readouterr()
    assert "Usage" in captured.out
```

## Building and Deployment
Build: `hatch build` (outputs to dist/) . Install wheel: `pip install dist/my_project-0.1.0-py3-none-any.whl`.

Git workflow: `git add .; git commit -m "Update main.py"; git push` . Update docs/update-log.md for changes (e.g., "Added CLI support") to track evolution .

## Changelog
See docs/update-log.md for detailed history; follow reverse chronological order with categories (Added, Changed, etc.) .

For issues: Ensure venv activation; run `which python3` to confirm interpreter . Contribute via PRs after forking the repo.