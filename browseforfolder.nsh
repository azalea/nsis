!ifndef __browseforfolder__
  !define __browseforfolder__ ; include guard

!include "LogicLib.nsh"
; Based on
; http://nsis.sourceforge.net/Windows_Vista_Folder_Selection
; Changes:
;; User can set default folder
;; Center window on $HWNDPARENT
; refs:
; http://nsis.sourceforge.net/Docs/System/System.html#funcaddr
;; To find out the index of a member in a COM interface, you need to search for the definition of this COM interface in the header files that come with Visual C/C++ or the Platform SDK. Remember the index is zero based.
; https://stackoverflow.com/a/20507257/1292238

!define CLSID_FileOpenDialog  {DC1C5A9C-E88A-4DDE-A5A1-60F82A20AEF7}
!define IID_IFileDialog       {42F85136-DB7E-439C-85F1-E4075D135FC8}
!define IID_IShellItem {43826d1e-e718-42ee-bc55-a1e261c37bfe}
!define CLSCTX_INPROC_SERVER  1
!define FOS_PICKFOLDERS       32
!define FOS_FORCEFILESYSTEM   64
!define SIGDN_FILESYSPATH     2147844096

!macro BrowseForFolder mypath

  Push $4
  Push $3
  Push $2
  Push $1
  Push $0

  System::Call 'ole32::CoCreateInstance(g "${CLSID_FileOpenDialog}", i 0, i ${CLSCTX_INPROC_SERVER}, g "${IID_IFileDialog}", *i .r0) i.r1'
  ${If} $1 == 0
    StrCpy $4 "error"
    System::Call "$0->9(i ${FOS_PICKFOLDERS}|${FOS_FORCEFILESYSTEM}) i.r1" ; IFileDialog::SetOptions
    System::Call 'SHELL32::SHCreateItemFromParsingName(w "${mypath}", i0, g "${IID_IShellItem}", *i.r2)'
    ${If} $2 <> 0
      System::Call '$0->12(i r2) i.r1' ; IFileDialog::SetFolder
    ${EndIf}
    ; !insertmacro repositionWindow $0
    System::Call "$0->3(i $HWNDPARENT) i.r1" ; IFileDialog::Show
    System::Call "$0->20(*i .r2) i.r1" ; IFileDialog::GetResult
    System::Call "$0->2()" ; IFileDialog::Release
    ${If} $1 == 0
      System::Call "$2->5(i ${SIGDN_FILESYSPATH}, *i .r3) i.r1" ; IShellItem::GetDisplayName
      ${If} $1 == 0
        System::Call "*$3(&w${NSIS_MAX_STRLEN} .r4)"
        System::Call "ole32::CoTaskMemFree(i $3)"
      ${EndIf}
      System::Call "$2->2()" ; IShellItem::Release
    ${EndIf}
  ${Else} ; fallback for pre-Vista Windows version
    nsDialogs::SelectFolderDialog "" "${mypath}"
    Pop $4
  ${EndIf}

  Pop $0
  Pop $1
  Pop $2
  Pop $3
  Exch $4
!macroend

!endif
