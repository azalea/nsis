nsis
----
Collections of nsis scripts, macros, and functions

browseforfolder
===============
Select a folder using Vista-style native file dialog

instdir
=======
Custom select-directory page that uses Vista-style native file dialog, which is to replace MUI_PAGE_DIRECTORY

prependpath
===========
Prepend path to PATH environment variable using Windows API.

It is advised against manipulating PATH with NSIS strings, because strings longer than ${NSIS_MAX_STRLEN} will get truncated/corrupted.

See: http://nsis.sourceforge.net/Path_Manipulation

Usage
-----
Macros / functions have the extension `.nsh`

Examples of the respective macro / function have the suffix `_example` and the extension `.nsi`