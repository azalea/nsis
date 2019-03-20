nsis
----
Collections of nsis scripts, macros, and functions

browseforfolder
===============
Select a folder using Vista-style native file dialog.

instdir
=======
Custom select-directory page that uses Vista-style native file dialog, which is to replace MUI_PAGE_DIRECTORY.

prependpath
===========
Prepend path to PATH environment variable using Windows API.

It is advised against manipulating PATH with NSIS strings, because strings longer than ${NSIS_MAX_STRLEN} will get truncated/corrupted.

See: http://nsis.sourceforge.net/Path_Manipulation

clearenvvar
===========
Clear the given environment variable permanently and in the installer session.

pythoninstalled
===============
Offical [Python installer](https://www.python.org/downloads/windows/) will not install if there exists a Python version that differs only in revision number (e.g. If installer is for 3.6.6 but 3.6.7 is already installed).

This macro checks for a given Python version (3.6) and returns a code on the stack:
```
    0: not installed
    1: installed correct version and location
    2: installed but incorrect version (differs only in revision number)
    3: installed but incorrect location
```

Usage
-----
Macros / functions have the extension `.nsh` / `.nsd`

Examples of the respective macro / function have the suffix `_example` and the extension `.nsi`

Compile with

    makensis /V4 xxx_example.nsi

Run the corresponding `xxx_example.exe`