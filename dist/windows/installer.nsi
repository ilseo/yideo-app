; Yideo 
; Installer Source
; Version 1.0

;Include Modern UI
!include "MUI2.nsh"
!include "FileFunc.nsh"

;General Settings
!searchparse /file "../../package.json" `  "version": "` PT_VERSION `",`
!define /date builddate "%y.%m.%d-%H.%M"
Name "Yideo"
Caption "Yideo v${PT_VERSION}"
BrandingText "Yideo v${PT_VERSION}"
VIAddVersionKey "ProductName" "Yideo"
VIAddVersionKey "ProductVersion" "v${PT_VERSION}"
VIAddVersionKey "FileDescription" "Yideo"
VIAddVersionKey "FileVersion" "v${PT_VERSION}"
VIAddVersionKey "CompanyName" "Echipa Yideo.ro"
VIAddVersionKey "LegalCopyright" "http://yideo.ro"
VIAddVersionKey "OriginalFilename" "Yideo-${PT_VERSION}-Win.exe"
VIProductVersion "${PT_VERSION}.0"
!system 'mkdir -p ../../build/releases/Yideo/win/'
OutFile "../../build/releases/Yideo/win/Yideo-${PT_VERSION}-Win.exe"
CRCCheck on
SetCompressor /SOLID lzma
!define NW_VER "0.9.2"
!define UNINSTALLPATH "Software\Microsoft\Windows\CurrentVersion\Uninstall\Yideo"

;Default installation folder
InstallDir "$PROGRAMFILES\Yideo"
InstallDirRegKey HKLM "Software\Yideo" ""

;Request application privileges
RequestExecutionLevel admin

;Define UI settings
!define MUI_LICENSEPAGE_BGCOLOR /GRAY
!define MUI_UI_HEADERIMAGE_RIGHT "..\..\src\app\images\icon.png"
!define MUI_ICON "..\..\src\app\images\yideo.ico"
!define MUI_UNICON "..\..\src\app\images\yideo.ico"
!define MUI_WELCOMEFINISHPAGE_BITMAP "installer-image.bmp"
!define MUI_UNWELCOMEFINISHPAGE_BITMAP "uninstaller-image.bmp"
!define MUI_ABORTWARNING
!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "Start Yideo"
!define MUI_FINISHPAGE_RUN_FUNCTION "LaunchYideo.ro"
!define MUI_FINISHPAGE_LINK "Pagina oficiala Yideo"
!define MUI_FINISHPAGE_LINK_LOCATION "http://yideo.ro/"

;Define the pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "LICENSE.txt"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

;Load Language Files
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "Afrikaans"
!insertmacro MUI_LANGUAGE "Albanian"
!insertmacro MUI_LANGUAGE "Arabic"
!insertmacro MUI_LANGUAGE "Basque"
!insertmacro MUI_LANGUAGE "Belarusian"
!insertmacro MUI_LANGUAGE "Bosnian"
!insertmacro MUI_LANGUAGE "Breton"
!insertmacro MUI_LANGUAGE "Bulgarian"
!insertmacro MUI_LANGUAGE "Catalan"
!insertmacro MUI_LANGUAGE "Croatian"
!insertmacro MUI_LANGUAGE "Czech"
!insertmacro MUI_LANGUAGE "Danish"
!insertmacro MUI_LANGUAGE "Dutch"
!insertmacro MUI_LANGUAGE "Esperanto"
!insertmacro MUI_LANGUAGE "Estonian"
!insertmacro MUI_LANGUAGE "Farsi"
!insertmacro MUI_LANGUAGE "Finnish"
!insertmacro MUI_LANGUAGE "French"
!insertmacro MUI_LANGUAGE "Galician"
!insertmacro MUI_LANGUAGE "German"
!insertmacro MUI_LANGUAGE "Greek"
!insertmacro MUI_LANGUAGE "Hebrew"
!insertmacro MUI_LANGUAGE "Hungarian"
!insertmacro MUI_LANGUAGE "Icelandic"
!insertmacro MUI_LANGUAGE "Indonesian"
!insertmacro MUI_LANGUAGE "Irish"
!insertmacro MUI_LANGUAGE "Italian"
!insertmacro MUI_LANGUAGE "Japanese"
!insertmacro MUI_LANGUAGE "Korean"
!insertmacro MUI_LANGUAGE "Kurdish"
!insertmacro MUI_LANGUAGE "Latvian"
!insertmacro MUI_LANGUAGE "Lithuanian"
!insertmacro MUI_LANGUAGE "Luxembourgish"
!insertmacro MUI_LANGUAGE "Macedonian"
!insertmacro MUI_LANGUAGE "Malay"
!insertmacro MUI_LANGUAGE "Mongolian"
!insertmacro MUI_LANGUAGE "Norwegian"
!insertmacro MUI_LANGUAGE "NorwegianNynorsk"
!insertmacro MUI_LANGUAGE "Polish"
!insertmacro MUI_LANGUAGE "Portuguese"
!insertmacro MUI_LANGUAGE "PortugueseBR"
!insertmacro MUI_LANGUAGE "Romanian"
!insertmacro MUI_LANGUAGE "Russian"
!insertmacro MUI_LANGUAGE "Serbian"
!insertmacro MUI_LANGUAGE "SerbianLatin"
!insertmacro MUI_LANGUAGE "SimpChinese"
!insertmacro MUI_LANGUAGE "Slovak"
!insertmacro MUI_LANGUAGE "Slovenian"
!insertmacro MUI_LANGUAGE "Spanish"
!insertmacro MUI_LANGUAGE "SpanishInternational"
!insertmacro MUI_LANGUAGE "Swedish"
!insertmacro MUI_LANGUAGE "Thai"
!insertmacro MUI_LANGUAGE "TradChinese"
!insertmacro MUI_LANGUAGE "Turkish"
!insertmacro MUI_LANGUAGE "Ukrainian"
!insertmacro MUI_LANGUAGE "Uzbek"
!insertmacro MUI_LANGUAGE "Welsh"

AutoCloseWindow false
ShowInstDetails show
ShowUninstDetails show

Function .onInit
 
  ReadRegStr $R0 HKLM "${UNINSTALLPATH}" "UninstallString"
  StrCmp $R0 "" done
 
  MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION "Yideo is already installed. \
  $\n$\nClick `OK` to uninstall previous version or `Cancel` to abort this upgrade." \
  IDOK uninstall
  Abort
 
;Run the uninstaller
uninstall:
  ClearErrors
  ExecWait '$R0'
 
  IfErrors abort done
  abort:
    Abort
 
done:
 
FunctionEnd

Section ; App Files
	
	RMDir /r "$INSTDIR"
	
	;Set output path to InstallDir
	SetOutPath "$INSTDIR"

	;Add the files
	File "..\..\package.json" "..\..\README.md" "..\..\CHANGELOG.md" "..\..\LICENSE.txt"
	File "..\..\build\cache\win\${NW_VER}\*.dll" "..\..\build\cache\win\${NW_VER}\nw.pak"
	File "/oname=Yideo.exe" "..\..\build\cache\win\${NW_VER}\nw.exe"
	SetOutPath "$INSTDIR\node_modules"
	File /r /x "*grunt*" /x "stylus" /x "bower" /x "test*" /x "doc*" /x "example*" /x "demo*" /x "bin" /x ".*" "..\..\node_modules\*.*"
	SetOutPath "$INSTDIR\src"
	File /r /x "styl" /x "build" /x "docs" /x "test*" /x "examples" /x "reports" /x "public" "..\..\src\*.*"
	
	;Create uninstaller
	WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd

Section ; Shortcuts

	SetOutPath "$INSTDIR"
	File /oname=Yideo.ico "..\..\src\app\images\yideo.ico"

	;Working Directory Shortcut
	CreateShortCut "$INSTDIR\Start Yideo.lnk" "$INSTDIR\Yideo.exe" "" "$INSTDIR\Yideo.ico" "" "" "" "Start Yideo"

	;Start Menu Shortcut
	RMDir /r "$SMPROGRAMS\Yideo"
	CreateDirectory "$SMPROGRAMS\Yideo"
	CreateShortCut "$SMPROGRAMS\Yideo\Yideo.lnk" "$INSTDIR\Yideo.exe" "" "$INSTDIR\Yideo.ico" "" "" "" "Start Yideo"
	CreateShortCut "$SMPROGRAMS\Yideo\Uninstall.lnk" "$INSTDIR\Uninstall.exe"

	;Desktop Shortcut
	Delete "$DESKTOP\Yideo.lnk"
	CreateShortCut "$DESKTOP\Yideo.lnk" "$INSTDIR\Yideo.exe" "" "$INSTDIR\Yideo.ico" "" "" "" "Start Yideo"
	
	WriteRegStr HKLM "${UNINSTALLPATH}" "DisplayName" "Yideo"
	WriteRegStr HKLM "${UNINSTALLPATH}" "DisplayVersion" "${PT_VERSION}"
	WriteRegStr HKLM "${UNINSTALLPATH}" "Publisher" "Echipa Yideo.ro"
	WriteRegStr HKLM "${UNINSTALLPATH}" "UninstallString" "$\"$INSTDIR\Uninstall.exe$\""
	WriteRegStr HKLM "${UNINSTALLPATH}" "InstallLocation" "$\"$INSTDIR$\""
	WriteRegStr HKLM "${UNINSTALLPATH}" "DisplayIcon" "$\"$INSTDIR\Yideo.ico$\""
	WriteRegStr HKLM "${UNINSTALLPATH}" "URLInfoAbout" "http://yideo.ro/"
	WriteRegStr HKLM "${UNINSTALLPATH}" "HelpLink" "http://yideo.ro/help/"
	WriteRegDWORD HKLM "${UNINSTALLPATH}" "NoModify" 1
	WriteRegDWORD HKLM "${UNINSTALLPATH}" "NoRepair" 1
	${GetSize} "$INSTDIR" "/S=0K" $0 $1 $2
	IntFmt $0 "0x%08X" $0
	WriteRegDWORD HKLM "${UNINSTALLPATH}" "EstimatedSize" "$0"

SectionEnd

Section "uninstall" ; Uninstaller
	
	RMDir /r "$INSTDIR"
	RMDir /r "$SMPROGRAMS\Yideo"
	Delete "$DESKTOP\Yideo.lnk"
	DeleteRegKey HKLM "${UNINSTALLPATH}"
	
SectionEnd

Function LaunchYideo.ro
  ExecShell "" "$INSTDIR\Start Yideo.lnk"
FunctionEnd