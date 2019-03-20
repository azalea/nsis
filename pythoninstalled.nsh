!ifndef __pythoninstalled__
  !define __pythoninstalled__ ; include guard
; ref: https://github.com/python/cpython/tree/master/Tools/msi

!include "LogicLib.nsh"
!macro PythonInstalled majorVersion fullVersion path
  ; Check to see whether Python $fullVersion is installed in $path
  ; majorVersion: 3.6
  ; fullVersion: 3.6.6
  ; path: C:\Python36
  DetailPrint "PythonInstalled majorVersion ${majorVersion} fullVersion ${fullVersion} path ${path}"
  StrCpy $R2 "SOFTWARE\Python\PythonCore\${majorVersion}" ;setting
  ; $R0 Version
  ; $R1 installPath
  ; $R3 result:
  ;     0: not installed
  ;     1: installed correct version and location
  ;     2: installed but incorrect version (differs only in revision number)
  ;     3: installed but incorrect location
  SetRegView 64
  ; Check global install location
  ReadRegStr $R0 HKLM $R2 "Version"
  IfErrors pythoninstalled_not_global +1
  ${If} $R0 == ""
    DetailPrint "Global python ${majorVersion} registry Version record may be corrupted."
    GoTo pythoninstalled_not_global
  ${Else}
    ReadRegStr $R1 HKLM "$R2\InstallPath" ""
    ${If} ${Errors}
      DetailPrint "Global python ${majorVersion} registry InstallPath record may be corrupted."
      GoTo pythoninstalled_not_global
    ${EndIf}
    GoTo pythoninstalled_version_found
  ${EndIf}

pythoninstalled_not_global:
  ; Check current user install location
  ; assume Python can be installed either globally or locally, NOT BOTH
  ; because official Python installer checks this
  ; the above assumption may be wrong, if not installed via Python installer
  ReadRegStr $R0 HKCU $R2 "Version"
  IfErrors pythoninstalled_not_found +1
  ${If} $R0 == ""
    DetailPrint "Local python ${majorVersion} registry Version record may be corrupted."
    GoTo pythoninstalled_not_found
  ${Else}
    ReadRegStr $R1 HKCU "$R2\InstallPath" ""
    ${If} ${Errors}
      DetailPrint "Local python ${majorVersion} registry InstallPath record may be corrupted."
      GoTo pythoninstalled_not_found
    ${EndIf}
    GoTo pythoninstalled_version_found
  ${EndIf}

pythoninstalled_version_found:
  ${If} $R0 == ${fullVersion}
     ; Check install path
     !insertmacro TrimTrailingSlash $R1
     StrCpy $R2 ${path} ; reuse / overwrite $R2
     !insertmacro TrimTrailingSlash $R2
     DetailPrint "expected Python install path: $R2; actual path: $R1"
     ${If} $R1 == $R2
       StrCpy $R3 1
       GoTo pythoninstalled_check_done
     ${Else}
       StrCpy $R3 3
       GoTo pythoninstalled_check_done
     ${EndIf}
  ${Else}
    StrCpy $R3 2
    GoTo pythoninstalled_check_done
  ${EndIf}
pythoninstalled_not_found:
  StrCpy $R3 0
pythoninstalled_check_done:
  Push $R3
!macroend

!macro TrimTrailingSlash var
  Strcpy $0 ${var} "" -1
  Strcmp $0 "\" 0 +2
  Strcpy ${var} ${var} -1
!macroend

!endif
