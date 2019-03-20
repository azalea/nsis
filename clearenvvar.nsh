!macro ClearEnvVar envvar
  ;; clear envvar permanently for current user, system, and in this session
  ; ref : https://stackoverflow.com/questions/573817/where-are-environment-variables-stored-in-registry
  DetailPrint "Clear ${envvar} environment variable if present" ; DeleteRegKey does not work somehow
  StrCpy $R0 "Environment"
  StrCpy $R1 "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
  ReadRegStr $0 HKCU $R0 ${envvar}
  IfErrors +2 0
  WriteRegStr HKCU $R0 ${envvar} ""  ; clear for current user
  ReadRegStr $0 HKLM $R1 ${envvar}
  IfErrors +2 0
  WriteRegStr HKLM $R1 ${envvar} ""  ; clear for system
  System::Call 'Kernel32::SetEnvironmentVariable(t, t)i ("${envvar}", "").r0'
  ; ^ for this session, required, because previous change does not take effect in this installer session
!macroend
