!include "prependpath.nsh"
!insertmacro ProcessEnvPrependPath ""
; ^ for installer
; for uninstaller, use: !insertmacro ProcessEnvPrependPath "un."

Section ""
  ExpandEnvStrings $0 "%PATH%"
  DetailPrint 'BEFORE: PATH: $0'  
  Push $TEMP
  Call ProcessEnvPrependPath
  ExpandEnvStrings $0 "%PATH%"
  DetailPrint 'AFTER: PATH: $0'  
SectionEnd
