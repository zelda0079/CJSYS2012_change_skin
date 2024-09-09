;NSIS Modern User Interface

;Regard all warnings as errors
!pragma warning error all

;--------------------------------
;Unicode Installer

  ;Properly display all languages 
  ;(Installer will not work on Windows 95, 98 or ME!)
  Unicode true

;--------------------------------
;Set Compressor

  ;Set the compression algorithm
  SetCompressor /SOLID /FINAL lzma
;--------------------------------
;Include header files

  !include "MUI2.nsh"            ;MUI
  !include "TextFunc.nsh"      ;Text functions

;--------------------------------
;Define LANG ID (values from TradChinese.nlf & SimpChinese.nlf)
;Workaround for conflicts between LoadLanguageFile & MUI_LANGUAGE

  !define LANG_TRADCHINESE 1028
  !define LANG_SIMPCHINESE 2052

;--------------------------------
; App info

  !define APP_NAME "CJSYS"
  !define PRODUCT_NAME "倉頡平台"
  !define PRODUCT_VER_MAJOR "2012"
  !define PRODUCT_VER_MINOR "250"
  !define PRODUCT_VER_PATCH "0"
  !define PRODUCT_VER_BUILD "3"
  !define PRODUCT_VERSION "${PRODUCT_VER_MAJOR}.${PRODUCT_VER_MINOR}.${PRODUCT_VER_PATCH}.${PRODUCT_VER_BUILD}"
  !define PLATFORM_NAME "小小输入法"
  !define PLATFORM_VERSION "2.5.0"
  !define INSTALLER_VERSION "${PRODUCT_VER_MAJOR}.Y${PRODUCT_VER_MINOR}.${PRODUCT_VER_PATCH}.${PRODUCT_VER_BUILD}"
  !define INSTALLER_FULL_NAME "${APP_NAME}-${INSTALLER_VERSION}.exe"
  !define PRODUCT_PUBLISHER "倉頡之友·馬來西亞"
  !define PRODUCT_WEB_SITE "http://chinesecj.com"
  !define PRODUCT_DONATION_URL "http://chinesecj.com/forum/forum.php?mod=viewthread&tid=2061"
  !define PRODUCT_PUBLISH_URL "http://www.chinesecj.com/forum/forum.php?mod=viewthread&tid=2596"
  !define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}"
  !define PRODUCT_UNINST_ROOT_KEY "HKLM"

;--------------------------------
;General

  ;Set UI Style
  XPStyle on

  ;Name and file
  Name "${PRODUCT_NAME} ${PRODUCT_VER_MAJOR}-Y${PRODUCT_VER_MINOR}"
  OutFile "${__FILEDIR__}\..\${INSTALLER_FULL_NAME}"

  ;Default installation folder
  InstallDir $PROGRAMFILES\${APP_NAME}
  
  ;Get installation folder from registry if available
  InstallDirRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "InstallLocation"
  
  ;Set branding text
  BrandingText "${PRODUCT_NAME} - ${PRODUCT_WEB_SITE}"

  ;Request application privileges for Windows Vista or above
  RequestExecutionLevel admin

;--------------------------------
;Variables

  Var StartMenuFolder

;--------------------------------
;Version Information

  VIProductVersion "${PRODUCT_VERSION}"
  VIFileVersion "${PRODUCT_VERSION}"
  VIAddVersionKey /LANG=${LANG_TRADCHINESE} "ProductName" "${PRODUCT_NAME}"
  VIAddVersionKey /LANG=${LANG_TRADCHINESE} "ProductVersion" "${PRODUCT_VERSION}"
  VIAddVersionKey /LANG=${LANG_TRADCHINESE} "Comments" "${PRODUCT_NAME}"
  VIAddVersionKey /LANG=${LANG_TRADCHINESE} "OriginalFilename" "${INSTALLER_FULL_NAME}"
  VIAddVersionKey /LANG=${LANG_TRADCHINESE} "FileVersion" "${PRODUCT_VERSION}"
  VIAddVersionKey /LANG=${LANG_TRADCHINESE} "FileDescription" "${PRODUCT_NAME}"
  VIAddVersionKey /LANG=${LANG_TRADCHINESE} "CompanyName" "${PRODUCT_PUBLISHER}"
  VIAddVersionKey /LANG=${LANG_TRADCHINESE} "LegalTrademarks" ""
  VIAddVersionKey /LANG=${LANG_TRADCHINESE} "LegalCopyright" ""

;--------------------------------
;Interface Settings

  ;Icon for the installer
  !define MUI_ICON skin/cj-icon.ico

  ;Show a message box when the user cancels the installation
  !define MUI_ABORTWARNING

  ;Show all languages, despite user's codepage
  !define MUI_LANGDLL_ALLLANGUAGES

;--------------------------------
;Language Selection Dialog Settings

  ;The registry key to store the selected language
  !define MUI_LANGDLL_REGISTRY_ROOT ${PRODUCT_UNINST_ROOT_KEY}
  !define MUI_LANGDLL_REGISTRY_KEY ${PRODUCT_UNINST_KEY}
  !define MUI_LANGDLL_REGISTRY_VALUENAME "InstallLanguage"

;--------------------------------
;Installer Pages

  ;Welcome page settings
  LangString WelcomePageTitle ${LANG_TRADCHINESE} "歡迎使用 $(^Name) 安裝嚮導"
  LangString WelcomePageTitle ${LANG_SIMPCHINESE} "欢迎使用 $(^Name) 安装向导"
  !define MUI_WELCOMEPAGE_TITLE $(WelcomePageTitle)

  LangString WelcomePageText ${LANG_TRADCHINESE} \
"如果已經安裝 ${PRODUCT_NAME} 舊版本，$\r$\n$\r$\n\
1）點擊「$(^CancelBtn)」退出安裝程式；$\r$\n$\r$\n\
2）解除安裝 ${PRODUCT_NAME}，並重新啓動計算機；$\r$\n$\r$\n\
3）然後再次啓動安裝程式。$\r$\n$\r$\n$\r$\n\
否則，點擊「$(^NextBtn)」繼續安裝。"
  
  LangString WelcomePageText ${LANG_SIMPCHINESE} \
"如果已经安装 ${PRODUCT_NAME} 旧版本，$\r$\n$\r$\n\
1）单击 [$(^CancelBtn)] 退出安装程序；$\r$\n$\r$\n\
2）卸载 ${PRODUCT_NAME}，并重新启动计算机；$\r$\n$\r$\n\
3）然后再次启动安装程序。$\r$\n$\r$\n$\r$\n\
否则，单击 [$(^NextBtn)] 继续安装。"
  
  !define MUI_WELCOMEPAGE_TEXT  $(WelcomePageText)
  
  !insertmacro MUI_PAGE_WELCOME
  
  ;Directory page settings
  !insertmacro MUI_PAGE_DIRECTORY
  
  ;Start Menu folder page settings
  !define MUI_STARTMENUPAGE_REGISTRY_ROOT ${PRODUCT_UNINST_ROOT_KEY}
  !define MUI_STARTMENUPAGE_REGISTRY_KEY ${PRODUCT_UNINST_KEY}
  !define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "StartMenuFolder"
  
  !define MUI_STARTMENUPAGE_DEFAULTFOLDER "${PRODUCT_NAME} ${PRODUCT_VER_MAJOR}-Y${PRODUCT_VER_MINOR}"
  
  !define MUI_STARTMENUPAGE_NODISABLE
  
  !insertmacro MUI_PAGE_STARTMENU Application $StartMenuFolder
  
  ;Installation page settings
  ShowInstDetails hide
  
  !insertmacro MUI_PAGE_INSTFILES
  
  ;Finish page settings
  LangString FinishPageTitle ${LANG_TRADCHINESE} "完成 $(^Name) 安裝"
  LangString FinishPageTitle ${LANG_SIMPCHINESE} "完成 $(^Name) 安装"
  !define MUI_FINISHPAGE_TITLE $(FinishPageTitle)
  
  LangString FinishPageLinkText ${LANG_TRADCHINESE} "進階功能幫助"
  LangString FinishPageLinkText ${LANG_SIMPCHINESE} "高级功能帮助"
  !define MUI_FINISHPAGE_LINK $(FinishPageLinkText)
  !define MUI_FINISHPAGE_LINK_LOCATION "$INSTDIR\yong.chm"
  
  LangString FinishPageRunText ${LANG_TRADCHINESE} "捐助${PRODUCT_PUBLISHER}"
  LangString FinishPageRunText ${LANG_SIMPCHINESE} "捐助${PRODUCT_PUBLISHER}"
  !define MUI_FINISHPAGE_RUN_TEXT $(FinishPageRunText)
  !define MUI_FINISHPAGE_RUN_FUNCTION OpenDonationPage
  !define MUI_FINISHPAGE_RUN_NOTCHECKED
  !define MUI_FINISHPAGE_RUN
  
  LangString ShowHelpText ${LANG_TRADCHINESE} "打开${PRODUCT_NAME}幫助頁"
  LangString ShowHelpText ${LANG_SIMPCHINESE} "打开${PRODUCT_NAME}帮助页"
  !define MUI_FINISHPAGE_SHOWREADME_TEXT $(ShowHelpText)
  !define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED
  !define MUI_FINISHPAGE_SHOWREADME ${PRODUCT_PUBLISH_URL}

  ;!define MUI_FINISHPAGE_NOAUTOCLOSE
  
  !insertmacro MUI_PAGE_FINISH

;--------------------------------
;Uninstaller Pages

  !insertmacro MUI_UNPAGE_WELCOME
  
  !insertmacro MUI_UNPAGE_CONFIRM
  
  !insertmacro MUI_UNPAGE_INSTFILES
  
  ;Uninstall finish page settings
  LangString UnFinishPageTitle ${LANG_TRADCHINESE} "完成 $(^Name) 解除安裝"
  LangString UnFinishPageTitle ${LANG_SIMPCHINESE} "完成 $(^Name) 解除安装"
  !define MUI_FINISHPAGE_TITLE $(UnFinishPageTitle)
  
  !define MUI_FINISHPAGE_REBOOTLATER_DEFAULT
  
  ;!define MUI_UNFINISHPAGE_NOAUTOCLOSE
  
  !insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages (first is the default)

  !insertmacro MUI_LANGUAGE "TradChinese"
  !insertmacro MUI_LANGUAGE "SimpChinese"

;--------------------------------
;Reserve Files
  
  ;If you are using solid compression, files that are required before
  ;the actual installation should be stored first in the data block,
  ;because this will make your installer start faster.
  
  !insertmacro MUI_RESERVEFILE_LANGDLL

;--------------------------------
;Installer Sections

  LangString UninstFileName ${LANG_TRADCHINESE} "解除安裝"
  LangString UninstFileName ${LANG_SIMPCHINESE} "卸载"
  
  LangString Readme ${LANG_TRADCHINESE} "説明檔案"
  LangString Readme ${LANG_SIMPCHINESE} "说明文档"
  
  Section

    ;Copy program files
    SetOutPath $INSTDIR
    File yong.exe
    File yong-config.exe
    File yong-vim.exe
    File libmb.so
    File libgbk.so
    File libcloud.so
    File libl.dll
    File yong.ini
    File bihua.bin
    File class.txt
    File README_Big5.txt
    File README_GBK.txt
    File Yong_README.txt
    File yong.chm
    File keyboard.ini
    File normal.txt
    File config.xml
    
    StrCmp $LANGUAGE ${LANG_SIMPCHINESE} 0 tran_done        ;Change translaton file if simp-zh language is selected
    ${ConfigWrite} "$INSTDIR\yong.ini" "translate=" "mb/tran_jt.txt" $R0
  tran_done:

    SetOutPath $INSTDIR\mb
    File mb\*
    
    SetOutPath $INSTDIR\mb\assist
    File mb\assist\*

    SetOutPath $INSTDIR\skin
    File skin\*

    SetOutPath $INSTDIR\skin_trad
    File skin_trad\*

    SetOutPath $INSTDIR\entry
    File entry\*
    
    SetOutPath $INSTDIR\entry\others
    File entry\others\*

    ;Auto startup yong.exe
    SetOutPath $INSTDIR
    CreateShortCut "$SMSTARTUP\${PRODUCT_NAME}.lnk" "$INSTDIR\yong.exe" "" "$INSTDIR\yong.exe" 0
    WriteUninstaller $INSTDIR\uninstall.exe

    ;Store uninstall reg key
    WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
    WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
    WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\skin\cj-icon.ico"
    WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" '"$INSTDIR\uninstall.exe"'
    WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
    WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "InstallLocation" "$INSTDIR"
    WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "InstallProgram" "$INSTDIR\yong.exe"
    WriteRegDWORD ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "NoModify" 1
    WriteRegDWORD ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "NoRepair" 1

    ;Select readme file according to language selection
    StrCmp $LANGUAGE ${LANG_SIMPCHINESE} +3
    StrCpy $R0 "README_Big5.txt"
    Goto +2
    StrCpy $R0 "README_GBK.txt"

    ;Start menu folder & links
    !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
       CreateDirectory "$SMPROGRAMS\$StartMenuFolder"
       CreateShortCut "$SMPROGRAMS\$StartMenuFolder\${PRODUCT_NAME}.lnk" "$INSTDIR\yong.exe" "" "$INSTDIR\skin\cj-icon.ico"
       CreateShortCut "$SMPROGRAMS\$StartMenuFolder\${PRODUCT_NAME}-$(Readme).lnk" "$INSTDIR\$R0" "" "$WINDIR\notepad.exe" 0
       CreateShortCut "$SMPROGRAMS\$StartMenuFolder\$(ShowHelpText).lnk" "${PRODUCT_PUBLISH_URL}" "" "$PROGRAMFILES\Internet Explorer\iexplore.exe" 0
       CreateShortCut "$SMPROGRAMS\$StartMenuFolder\$(FinishPageLinkText).lnk" "$INSTDIR\yong.chm"
	   CreateShortCut "$SMPROGRAMS\$StartMenuFolder\$(FinishPageRunText).lnk" "${PRODUCT_DONATION_URL}" "" "$PROGRAMFILES\Internet Explorer\iexplore.exe" 0
       CreateShortCut "$SMPROGRAMS\$StartMenuFolder\${PLATFORM_NAME}-$(Readme).lnk" "$INSTDIR\Yong_README.txt" "" "$WINDIR\notepad.exe" 0
       CreateShortCut "$SMPROGRAMS\$StartMenuFolder\$(UninstFileName).lnk" "$INSTDIR\uninstall.exe"
    !insertmacro MUI_STARTMENU_WRITE_END

    ;Copy TSF files
    SetOutPath $INSTDIR\tsf
    File tsf\yong.dll
    File tsf\yong64.dll
    File tsf\tsf-reg.exe
    File tsf\tsf-reg64.exe
    File tsf\install.bat
    File tsf\uninstall.bat

    ;Register TSF
    ExecWait '"$INSTDIR\tsf\tsf-reg.exe" -i'
    ExecWait '"$INSTDIR\tsf\tsf-reg64.exe" -i'
    ExecWait 'reg delete HKLM\SOFTWARE\Microsoft\CTF\TIP\{6565D455-5030-4C0F-8871-83F6AFDE514F}\LanguageProfile /f'
    StrCmp $LANGUAGE ${LANG_SIMPCHINESE} zh_simp
    ExecWait 'reg add HKLM\SOFTWARE\Microsoft\CTF\TIP\{6565D455-5030-4C0F-8871-83F6AFDE514F}\LanguageProfile\0x00000404\{4D5459DB-7543-42C0-9204-9195B91F6FB8} /v Description /t REG_SZ /d 倉頡輪入法 /f'
    ExecWait 'reg add HKLM\SOFTWARE\Microsoft\CTF\TIP\{6565D455-5030-4C0F-8871-83F6AFDE514F}\LanguageProfile\0x00000404\{4D5459DB-7543-42C0-9204-9195B91F6FB8} /v IconFile /t REG_SZ /d "$INSTDIR\skin\cj-icon.ico" /f'
    ExecWait 'reg add HKLM\SOFTWARE\Microsoft\CTF\TIP\{6565D455-5030-4C0F-8871-83F6AFDE514F}\LanguageProfile\0x00000404\{4D5459DB-7543-42C0-9204-9195B91F6FB8} /v IconIndex /t REG_DWORD /d 0 /f'
    Goto tsf_done
  zh_simp:
    ExecWait 'reg add HKLM\SOFTWARE\Microsoft\CTF\TIP\{6565D455-5030-4C0F-8871-83F6AFDE514F}\LanguageProfile\0x00000804\{4D5459DB-7543-42C0-9204-9195B91F6FB8} /v Description /t REG_SZ /d 仓颉输入法 /f'
    ExecWait 'reg add HKLM\SOFTWARE\Microsoft\CTF\TIP\{6565D455-5030-4C0F-8871-83F6AFDE514F}\LanguageProfile\0x00000804\{4D5459DB-7543-42C0-9204-9195B91F6FB8} /v IconFile /t REG_SZ /d "$INSTDIR\skin\cj-icon.ico" /f'
    ExecWait 'reg add HKLM\SOFTWARE\Microsoft\CTF\TIP\{6565D455-5030-4C0F-8871-83F6AFDE514F}\LanguageProfile\0x00000804\{4D5459DB-7543-42C0-9204-9195B91F6FB8} /v IconIndex /t REG_DWORD /d 0 /f'
  tsf_done:

    ;Disable trigger key
    ${ConfigWrite} "$INSTDIR\yong.ini" "trigger=" "NONE" $R0

    ;Startup main program
    StrCpy $OUTDIR "$INSTDIR"		;Set working directory
    Exec '"$INSTDIR\yong.exe"'
  SectionEnd

;--------------------------------
;Installer Functions

  LangString AlreadyInstalledErrMsg ${LANG_TRADCHINESE} "$(^Name) 已安裝，請解除安裝並重啓計算機后再次安裝。"
  LangString AlreadyInstalledErrMsg ${LANG_SIMPCHINESE} "$(^Name) 已安装，请卸载并重启计算机后再次安装。"
  
  LangString LangDialogTitle ${LANG_TRADCHINESE} "選擇顯示語言"
  LangString LangDialogTitle ${LANG_SIMPCHINESE} "选择显示语言"
  !define MUI_LANGDLL_WINDOWTITLE $(LangDialogTitle)
  
  LangString LangDialogText ${LANG_TRADCHINESE} "選擇在安裝過程中使用的語言：$\r$\n(也將作爲 ${PRODUCT_NAME} 的顯示語言)"
  LangString LangDialogText ${LANG_SIMPCHINESE} "选择在安装过程中使用的语言：$\r$\n(也将作为 ${PRODUCT_NAME} 的显示语言)"
  !define MUI_LANGDLL_INFO $(LangDialogText)

  Function .onInit

    ;Detect existent installation
    ClearErrors
    ReadRegStr $R0 ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName"
    IfErrors absent
    MessageBox MB_OK|MB_ICONSTOP $(AlreadyInstalledErrMsg)
    Abort        ;Show error msg & abort if already installed
  absent:

    ;Select language
    !insertmacro MUI_LANGDLL_DISPLAY

  FunctionEnd  ;.onInit
  
  ; Open donation page of Chinesecj in default web browser
  Function OpenDonationPage
    ExecShell "open" "${PRODUCT_DONATION_URL}"
  FunctionEnd  ; OpenDonationPage

;--------------------------------
;Uninstaller Sections

  LangString KeepSettingsMsg ${LANG_TRADCHINESE} "是否保留設定檔案？"
  LangString KeepSettingsMsg ${LANG_SIMPCHINESE} "是否保留设置文件？"

  Section "Uninstall"

  find_yong:
    FindWindow $R0 "yong_main"
    IntCmp $R0 0 find_done
    SendMessage $R0 2 0 0
    Sleep 30
    Goto find_yong
  find_done:

    !insertmacro MUI_STARTMENU_GETFOLDER Application $StartMenuFolder
    RMDir /r "$SMPROGRAMS\$StartMenuFolder"
    Delete "$SMSTARTUP\${PRODUCT_NAME}.lnk"

    IfFileExists "$INSTDIR\tsf\tsf-reg.exe" 0 +2
    ExecWait '"$INSTDIR\tsf\tsf-reg.exe" -u -d'
    
    IfFileExists "$INSTDIR\tsf\tsf-reg64.exe" 0 +2
    ExecWait '"$INSTDIR\tsf\tsf-reg64.exe" -u -d'

    RMDir /r "$INSTDIR\mb"
    RMDir /r /REBOOTOK "$INSTDIR\tsf"
    RMDir /r "$INSTDIR\skin"
    RMDir /r "$INSTDIR\skin_trad"
    RMDir /r "$INSTDIR\w64"
    RMDir /r "$INSTDIR\entry"

    Delete "$INSTDIR\yong.exe"
    Delete "$INSTDIR\yong-config.exe"
    Delete "$INSTDIR\yong-vim.exe"
    Delete "$INSTDIR\libmb.so"
    Delete "$INSTDIR\libgbk.so"
    Delete "$INSTDIR\libcloud.so"
    Delete "$INSTDIR\libl.dll"
    Delete "$INSTDIR\README_Big5.txt"
    Delete "$INSTDIR\README_GBK.txt"
    Delete "$INSTDIR\Yong_README.txt"
    Delete "$INSTDIR\yong.ini"
    Delete "$INSTDIR\class.txt"
    Delete "$INSTDIR\bihua.bin"
    Delete "$INSTDIR\keyboard.ini"
    Delete "$INSTDIR\normal.txt"
    Delete "$INSTDIR\learn.dat"
    Delete "$INSTDIR\yong.chm"
    Delete "$INSTDIR\config.xml"

    Delete "$INSTDIR\uninstall.exe"

    MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 $(KeepSettingsMsg) IDYES +3
    RMDir /r "$INSTDIR\.yong"
    RMDir /r "$APPDATA\yong"
    RMDir /REBOOTOK "$INSTDIR"

    DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"

SectionEnd

;--------------------------------
;Uninstaller Functions

  Function un.onInit

    ;Get the stored language selection
    !insertmacro MUI_UNGETLANGUAGE

  FunctionEnd
