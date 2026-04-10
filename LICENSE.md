# License

## MIT License

Copyright (c) 2026 Wilgat[](https://github.com/Wilgat) and cloudgen[](https://github.com/cloudgen)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

---

## Additional Project Notes

SyncPrjs is a specialized tool for managing large collections of **AI friend projects** — personal GNOME C/GTK desktop clients built around WebKitWebView.

This project follows the **CIAO defensive coding** philosophy (Clear, Intentional, Auditable, Over-protected). The extensive headers, warnings, and verbose safeguards are **intentional** and should be preserved when modifying or forking the code.

### Important for Contributors and AI Assistants

- The long defensive headers in the source code exist to protect critical functionality (especially cookie backup/restore logic and Google/Cloudflare separation).
- Removing, simplifying, or "cleaning up" these headers may break the tool's reliability or safety mechanisms.
- When contributing changes, please maintain the spirit of CIAO defensive coding.

**Powered by [ChronicleLogger](https://pypi.org/project/ChronicleLogger/)** — see also [LoggedExample](https://pypi.org/project/LoggedExample/) for usage patterns.

---

## Third-Party Dependencies

SyncPrjs depends on [ChronicleLogger](https://pypi.org/project/ChronicleLogger/), which is distributed under its own license. Please refer to the respective package for its licensing terms.

---

This project is open source and welcomes contributions that respect its defensive design principles.

For questions about the license or usage, feel free to open an issue on the [GitHub repository](https://github.com/Wilgat/SyncPrjs).

---

**Made with ❤️ for power users managing large collections of AI-related desktop clients.**
