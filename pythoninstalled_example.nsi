!include "pythoninstalled.nsh"
Section ""
  Var /global pythonPath
  Var /global majorVersion
  Var /global fullVersion
  StrCpy $pythonPath "C:\Python36"
  StrCpy $majorVersion "3.6"
  StrCpy $fullVersion "3.6.6"
  pythoninstalled_retry_clicked:
    !insertmacro PythonInstalled $majorVersion $fullVersion $pythonPath
    Pop $0
    DetailPrint "Check PythonInstalled result: $0"
    ${If} $0 == 1
      GoTo python_installed
    ${ElseIf} $0 == 0
      GoTo install_python
    ${Else}
      ${If} $0 == 2
        StrCpy $R0 "Python $majorVersion is installed, but has a different revision version from $fullVersion."
      ${ElseIf} $0 == 3
        StrCpy $R0 "Python $fullVersion is installed in a location other than $pythonPath."
      ${EndIf}
      DetailPrint $R0
      ; ref: https://nsis.sourceforge.io/Opening_Control_Panel_/_Display_Properties
      ; ref 2: https://www.thewindowsclub.com/rundll32-shortcut-commands-windows
      Exec 'RunDll32.exe shell32.dll,Control_RunDLL appwiz.cpl,,0'
      MessageBox MB_RETRYCANCEL "$R0 Please uninstall the existing Python $majorVersion from Control Panel and retry." IDRETRY pythoninstalled_retry_clicked IDCANCEL pythoninstalled_cancel_clicked
      pythoninstalled_cancel_clicked:
        Quit
    ${EndIf}
  install_python:
    DetailPrint 'Installing Python'
  python_installed:
    DetailPrint 'Python installed'
SectionEnd
