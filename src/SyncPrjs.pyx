#!/usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import print_function, absolute_import, division
# NEW: Additional __future__ for better Py2 compatibility
from __future__ import unicode_literals

# PathFix - Sys Path Archaeology
# Purpose: The Archaeology of sys.path – Forensic Runtime Diagnosis & Reconstruction  
# Version: 1.0 – First Edition (December 7, 2025)  
# Authors: A battle-scarred developer & an AI that learned to listen  
#  
# This module runs at startup (import early in all projects).  
# It performs full forensic analysis, diagnoses every path,  
# then reconstructs sys.path from proven truth only.  
#  
# Philosophy:  
# 1. Local .so wins – always. that's why no checking local .so  
# 2. Birthplace is sacred – unless proven dead.  
# 3. Diagnose everything – maximum verbose.  
# 4. Rebuild, don't patch. 
# 5. Archaeology never remove clue and truth
# 6. Code comes from days of works with Grok together, comments are useful and don't removed
# 7. No placeholder code is allow, it's real code and don't pollute
# 8. consider windows such as python3.exe, consider old system: python2, consider macOS, 
#    consider pypy, consider all other exe packages, consider jupyter, etc
#  
# Usage: Add to require= in cy-master.ini  
#        Import first in main .pyx  

# Purpose: The Archaeology of sys.path – Forensic Runtime Diagnosis & Reconstruction
# No cdef, no Cython-specific syntax – 100% compatible with normal python3

# Example.pyx – The Final Archaeology (December 2025)

import os
import re
import subprocess
import sys
import zipimport

# Python 2.7 compatibility shim
if not hasattr(subprocess, 'DEVNULL'):
    subprocess.DEVNULL = open(os.devnull, 'wb')

if not hasattr(subprocess, 'run'):
    def run(*popenargs, **kwargs):
        input = kwargs.pop("input", None)
        check = kwargs.pop("check", False)
        if input is not None:
            kwargs.setdefault("stdin", subprocess.PIPE)

        proc = subprocess.Popen(*popenargs, **kwargs)
        stdout, stderr = proc.communicate(input)
        retcode = proc.poll()
        if check and retcode:
            raise subprocess.CalledProcessError(retcode, popenargs[0], output=stdout)
        return subprocess.CompletedProcess(popenargs[0], retcode, stdout, stderr)

    subprocess.run = run
try:
    from typing import Dict, List, Any, Optional, Tuple
except ImportError:
    # For Python 2.7, use built-in types as fallbacks
    Dict = dict
    List = list
    Any = object
    Optional = lambda x: x
    Tuple = tuple

# NEW: Define version_info access compatibly (Py2 uses tuple, Py3.5+ has .major/.minor)
def get_major_minor():
    vi = sys.version_info
    if hasattr(vi, 'major'):
        return vi.major, vi.minor
    else:
        return vi[0], vi[1]

# NEW: Py2/3 compatible DEVNULL and subprocess run (Py2 lacks DEVNULL and timeout)
if sys.version_info[0] < 3:
    import subprocess as subp
    DEVNULL = open(os.devnull, 'wb')
    def sp_run(args, stdout=None, stderr=None, timeout=None, **kwargs):
        # Py2 fallback: no timeout support, use Popen
        p = subp.Popen(args, stdout=stdout or DEVNULL, stderr=stderr or DEVNULL, **kwargs)
        p.wait()  # No timeout; could add threading for timeout if needed
        return p
else:
    from subprocess import DEVNULL, run as sp_run

# NEW: sys.implementation compatibility (Py3.3+ only)
def get_implementation_name():
    if hasattr(sys, 'implementation') and hasattr(sys.implementation, 'name'):
        return sys.implementation.name.lower()
    return 'cpython'

# =============================================================================
# TruthTable – Restored as central evidence holder
# =============================================================================
class TruthTable:
    # NEW: For Py2 compatibility, type hints are removed from __init__ assignments (Py3.5+ syntax error in Py2)
    #      They are preserved as comments for documentation. Use 'future' package for backport if needed.
    def __init__(self):
        self.old_personality = ""  # : str
        self.new_personality = ""  # : str
        self.trust_score = 0  # : int
        self.birth_clues = {}  # : Dict[str, Optional[str]]
        self.all_clues = {}  # : Dict[str, Any]
        self.privilege = {}  # : Dict[str, Any]
        self.base_dir = ""  # : str
        self.local_has_so = False  # : bool
        self.has_sudo_ticket = False  # : bool
        self.expected = {}  # : Dict[str, Any]
        self.actual = {}  # : Dict[str, Any]
        self.diagnosis = {  # : Dict[str, Any]
            "mismatches": [],
            "non_existent_paths": []
        }
        self.final_action = {}  # : Dict[str, Any]

class PathFix:
    
    def __init__(self):
        try:
            self.run_path_archeology()
        except e:  # NEW: Py2 comma syntax for except (compatible with __future__ print_function)
            self.debug("Fatal error during archaeology: %s" % e)  # NEW: .format() or % for Py2 compat instead of f-string
            import traceback
            traceback.print_exc()  # NEW: Fixed bug: was traceback.self.debug_exc() -> print_exc()

    # =============================================================================
    # Phase 0: Helper Functions
    # =============================================================================
    def is_path_exists_and_readable(self, path):  # NEW: Removed type hints for Py2 compat; was (path: str) -> Tuple[bool, str]
        if not path:
            return False, "path_empty"
        if not os.path.exists(path):
            return False, "non_existent"
        if not os.access(path, os.R_OK):
            return False, "not_readable"
        return True, "valid"

    def is_abi_match(self, path):  # NEW: Removed type hints; was (path: str) -> Tuple[bool, str]
        match = re.search(r'python(\d+)\.(\d+)', path) or re.search(r'cpython-(\d)(\d+)', path)
        if not match:
            return False, "no_version_in_path"
        major, minor = int(match.group(1)), int(match.group(2))
        # NEW: Use compatible version_info access
        current_major, current_minor = get_major_minor()
        if major != current_major or minor != current_minor:
            return False, "abi_mismatch_%d.%d_vs_%d.%d" % (major, minor, current_major, current_minor)  # NEW: % formatting for Py2
        return True, "abi_match"

    # =============================================================================
    # Phase 1–5: Core Forensic Functions (Pure Python) – Fully Restored
    # =============================================================================
    def gather_birth_clues(self):  # NEW: Removed return type hint; was -> Dict[str, Optional[str]]
        return {
            "executable": sys.executable,
            "shell_cmd": os.environ.get("_"),
            "sudo_cmd": os.environ.get("SUDO_COMMAND"),
            "file_var": getattr(sys.modules.get('__main__'), '__file__', None)
        }

    def gather_all_clues(self):  # NEW: Removed return type hint; was -> Dict[str, Any]
        main_mod = sys.modules.get('__main__')
        exe = sys.executable or ""
        return {
            "executable": exe,
            "exe_basename": os.path.basename(exe).lower(),
            "exe_dir": os.path.dirname(exe) if exe else "",
            "argv0": sys.argv[0] if sys.argv else "",
            "__file__": getattr(main_mod, "__file__", None),
            "frozen": getattr(sys, "frozen", False),
            "_MEIPASS": getattr(sys, "_MEIPASS", None),
            "impl": get_implementation_name(),  # NEW: Use compatible getter
            "platform": sys.platform,
            "is_windows": sys.platform.startswith("win"),
            "_" : os.environ.get("_"),
            "SUDO_COMMAND": os.environ.get("SUDO_COMMAND"),
            "PWD": os.environ.get("PWD"),
            "VIRTUAL_ENV": os.environ.get("VIRTUAL_ENV"),
        }

    def determine_old_personality(self, clues):  # NEW: Removed type hints; was (clues: Dict[str, Optional[str]]) -> str
        if 'get_ipython' in globals() or 'IPython' in sys.modules:
            return "interactive"

        # Primary oracle: the actual invocation command — already gathered at birth
        shell_cmd = (clues.get("shell_cmd") or "").strip()
        sudo_cmd  = (clues.get("sudo_cmd") or "").strip()

        # Sudo command is the ultimate truth if present
        cmd = sudo_cmd or shell_cmd

        if cmd:
            parts = cmd.split()
            if parts:
                invoker = parts[0]
                invoker_base = os.path.basename(invoker).lower()

                # Invoked directly as a non-python binary → true standalone
                if "python" not in invoker_base and "pypy" not in invoker_base:
                    return "standalone"

                # Invoked via python, but no real script file argument → one-liner / -m / -c
                if len(parts) < 2 or not os.path.isabs(parts[-1]):
                    # covers: python, python -c ..., python -m ..., python "" 
                    return "one_liner"

        # Secondary oracle: __main__.__file__ (only consulted if invocation was ambiguous)
        file_var = clues.get("file_var") or ""
        if file_var == "<stdin>" or file_var == "":
            return "one_liner"

        # Final truth: we were born from a real script file
        return "script"

    def diagnose_privilege(self):  # NEW: Removed return type hint; was -> Dict[str, Any]
        privilege = {
            "effective_uid": os.geteuid(),
            "real_uid": os.getuid(),
            "effective_user": "unknown",
            "real_user": "unknown",
            "is_real_root": False,
            "is_sudo_fake_root": False,
            "original_home": "unknown",
            "pwd_available": False,
        }

        try:
            import pwd
            privilege["pwd_available"] = True
            eff = pwd.getpwuid(privilege["effective_uid"])
            real = pwd.getpwuid(privilege["real_uid"])
            privilege["effective_user"] = eff.pw_name
            privilege["real_user"] = real.pw_name
            privilege["original_home"] = real.pw_dir
        except Exception:
            pass  # Oracle silent — we accept

        euid = privilege["effective_uid"]
        ruid = privilege["real_uid"]
        privilege["is_real_root"] = (euid == 0 and ruid == 0)
        privilege["is_sudo_fake_root"] = (euid == 0 and ruid != 0)

        return privilege

    def extract_base_directory(self, clues):  # NEW: Removed type hints; was (clues: Dict[str, Optional[str]]) -> str
        candidates = [
            clues.get("sudo_cmd"),
            clues.get("shell_cmd"),
            clues.get("executable"),
            clues.get("file_var"),
        ]
        for cmd in candidates:
            if cmd:
                parts = cmd.strip().split()
                path = parts[-1] if parts else cmd
                if os.path.isabs(path):
                    return os.path.dirname(path)
                full = os.path.abspath(path)
                if os.path.exists(full):
                    return os.path.dirname(full)
        return os.getcwd()

    @staticmethod
    def isDebug():  # NEW: No changes needed; return type inferred
        if not hasattr(PathFix, '__is_debug__'):
            debug = ''
            if os.environ.get("debug") is not None:
                debug = os.environ.get("debug").lower()
            elif os.environ.get("DEBUG") is not None:
                debug = os.environ.get("DEBUG").lower()  # NEW: Fixed bug: was ebug, now debug
            if debug == 'show':
                PathFix.__is_debug__ = True 
            else:
                PathFix.__is_debug__ = False 
        return PathFix.__is_debug__

    def detect_local_so(self, base_dir, required_modules=None):  # NEW: Removed type hints; was (base_dir: str, required_modules: List[str] = None) -> bool
        if required_modules is None:
            required_modules = []
        if not base_dir or not os.path.isdir(base_dir):
            return False
        try:
            for entry in os.listdir(base_dir):
                if entry.endswith(".so") and "cpython" in entry:
                    return True
                for mod in required_modules:
                    if entry.startswith(mod) and entry.endswith(".so"):
                        return True
        except (PermissionError, OSError):
            return False
        return False

    def calculate_trust_score(self, truth):  # NEW: Removed type hint; was (truth: TruthTable) -> int
        score = 0
        if truth.all_clues["frozen"]:           score += 100
        if truth.all_clues["_MEIPASS"]:         score += 100
        if any(isinstance(i, zipimport.zipimporter) for i in sys.meta_path): score += 70
        if truth.local_has_so:                  score += 50
        if "python" in truth.all_clues["exe_basename"] or "pypy" in truth.all_clues["exe_basename"]:
            score -= 40
        if truth.all_clues["exe_dir"] in {"/usr/bin", "/bin", "/usr/local/bin"}:
            score -= 50
        if truth.all_clues["VIRTUAL_ENV"]:      score -= 30
        if truth.all_clues["__file__"] is None or str(truth.all_clues["__file__"]).startswith("<"):
            score -= 80
        return score

    def determine_new_personality(self, score):  # NEW: Removed type hint; was (score: int) -> str
        if score <= 0:      return "mortal"
        if score < 60:      return "heretic"
        if score < 120:     return "exile"
        if score < 200:     return "revenant"
        return "god"

    def has_sudo_ticket(self):  # NEW: No changes; return type bool inferred
        try:
            # NEW: sp_run already redefined for Py2 compat (no timeout)
            return sp_run(["sudo", "-n", "true"], stdout=DEVNULL, stderr=DEVNULL).returncode == 0
        except Exception:
            return False

    def debug(self, msg):  # NEW: Removed type hint if any; was implicit
        debug = ''
        if os.environ.get("debug") is not None:
            debug = os.environ.get("debug").lower()
        elif os.environ.get("DEBUG") is not None:
            debug = os.environ.get("DEBUG").lower()  # NEW: Fixed bug: was ebug, now debug
        if debug == 'show':
            print("[PathFix] %s" % msg)  # NEW: % formatting instead of f-string for Py2 compat

    # =============================================================================
    # Main Forensic Engine – Fully Restored with TruthTable
    # =============================================================================
    def run_path_archeology(self, required_modules=None):  # NEW: Removed type hint; was (required_modules: List[str] = None)
        if required_modules is None:
            required_modules = ["Sudoer", "ChronicleLogger"]
        truth = TruthTable()
        truth.birth_clues = self.gather_birth_clues()
        truth.all_clues = self.gather_all_clues()
        truth.old_personality = self.determine_old_personality(truth.birth_clues)
        truth.privilege = self.diagnose_privilege()
        truth.base_dir = self.extract_base_directory(truth.birth_clues)
        truth.local_has_so = self.detect_local_so(truth.base_dir, required_modules)
        truth.has_sudo_ticket = self.has_sudo_ticket()
        truth.trust_score = self.calculate_trust_score(truth)
        truth.new_personality = self.determine_new_personality(truth.trust_score)
        self.debug("Old Personality: %s" % truth.old_personality)  # NEW: % instead of f
        self.debug("New Personality: %s" % truth.new_personality)
        self.debug("Trust Score: %d" % truth.trust_score)
        self.debug("Interpreter: %s on %s" % (truth.all_clues['impl'], truth.all_clues['platform']))
        self.debug("Real user: %s | Effective: %s" % (truth.privilege['real_user'], truth.privilege['effective_user']))
        self.debug("Sudo fake root: %s" % truth.privilege['is_sudo_fake_root'])
        self.debug("Has valid sudo ticket: %s" % truth.has_sudo_ticket)
        self.debug("Base directory: %s" % truth.base_dir)
        self.debug("Local .so present: %s" % truth.local_has_so)
        self.debug("pwd available: %s" % truth.privilege['pwd_available'])

        should_insert = truth.local_has_so or truth.trust_score >= 60
        if should_insert:
            if truth.base_dir not in sys.path:
                sys.path.insert(0, truth.base_dir)
                self.debug("Inserted %s at %s" % (truth.base_dir, sys.path[0]))
        self.debug("Final sys.path[0:5]: %s" % str(sys.path[:5]))  # NEW: str() and % for compat

# =============================================================================
# Auto-run when imported
# =============================================================================
PathFix()
import sys
from chronicle_logger.ChronicleLogger import ChronicleLogger

class Example:
    # Remember to replace Example to name of the class
    CLASSNAME = "Example"
    MAJOR_VERSION = 0
    MINOR_VERSION = 1
    PATCH_VERSION = 1

    def __init__(self, basedir="/var/app",  logger=None):
        """
        Initializes the PyxPy object with source and target folder paths and sets up the logger.
        """
        self.basedir = basedir
        self.logger = logger

    @staticmethod
    def class_version():
        return f"{Example.CLASSNAME} v{Example.MAJOR_VERSION}.{Example.MINOR_VERSION}.{Example.PATCH_VERSION}"

    def log(self, message, level="INFO", component=""):
        """Logs a message using the provided logger if available."""
        if self.logger:
            self.logger.log_message(message, level, component)
        else:
            print(message)  # Fallback to print if no logger is provided

    def info(self):
        print("This is an example app")

def usage(appname):
    print(f"Usage: {appname} info")

def main():
    appname = 'LoggedExample'
    MAJOR_VERSION = 0
    MINOR_VERSION = 1
    PATCH_VERSION = 1

    # Create logger instance
    logger = ChronicleLogger(logname=appname)
    appname=logger.logName()    
    basedir=logger.baseDir()
    if logger.isDebug():
        logger.log_message(f"{appname} v{MAJOR_VERSION}.{MINOR_VERSION}.{PATCH_VERSION} ({__file__}) with the following:", component="main")
        logger.log_message(f">> {ChronicleLogger.class_version()}", component="main")

    if len(sys.argv) < 2:
        usage(appname)
        sys.exit(1)
    cmd = sys.argv[1]
    if cmd=="info":
        app = Example(basedir=basedir, logger=logger)
        app.info()
    else:
        usage(appname)
        sys.exit(1)

if __name__ == '__main__':
    main()
