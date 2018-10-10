!macro ProcessEnvPrependPath UN
    ;; ref: http://stackoverflow.com/a/32384667/1292238
    !ifndef ERROR_ENVVAR_NOT_FOUND
        !define ERROR_ENVVAR_NOT_FOUND 203
    !endif
    !if "${NSIS_PTR_SIZE}" <= 4
    !include LogicLib.nsh
    Function ${UN}ProcessEnvPrependPath ; IN:Path OUT:N/A
    System::Store S
    Pop $1
    System::Call 'KERNEL32::GetEnvironmentVariable(t "PATH", t, i0)i.r0'
    DetailPrint 'Before PrependPath: length is $0'
    ${If} $0 = 0
        System::Call 'KERNEL32::SetEnvironmentVariable(t "PATH", tr1)'
    ${Else}
        StrLen $2 $1
        System::Call '*(&t$2,&t1,&t$0)i.r9'
        StrCpy $3 '$1;'
        System::Call 'KERNEL32::lstrcat(ir9, tr3)'
        System::Call '*(&t$0)i.r8'
        System::Call 'KERNEL32::GetEnvironmentVariable(t "PATH", ir8, ir0)i.r0'
        System::Call 'KERNEL32::lstrcat(ir9, ir8)'
        System::Call 'KERNEL32::SetEnvironmentVariable(t "PATH", ir9)'
        System::Free $9
    ${EndIf}
    System::Call 'KERNEL32::GetEnvironmentVariable(t "PATH", t, i0)i.r0'
    DetailPrint 'After PrependPath: length is $0'
    System::Store L
    FunctionEnd
    !endif
!macroend
