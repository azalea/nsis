!include "browseforfolder.nsh"

Section ""
  !insertmacro BrowseForFolder $TEMP
  Pop $0
  DetailPrint $0
SectionEnd
