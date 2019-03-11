!include "MUI2.nsh"
!include "instdir.nsd"

InstallDir $TEMP

Page custom fnc_instdir_Show
; ^ replaces !insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE "English"

Section ""
SectionEnd
