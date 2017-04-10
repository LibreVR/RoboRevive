;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

;--------------------------------
;General

  ;Name and file
  Name "RoboRevive"
  OutFile "RoboRevive.exe"

  ;Default installation folder
  InstallDir "$PROGRAMFILES64\Oculus\Software\Software\epic-games-odin"
  
  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\RoboRevive" ""

  ;Request application privileges for Windows Vista
  RequestExecutionLevel admin
  
  ;Immediately close after installation
  AutoCloseWindow true

;--------------------------------
;Variables

  Var StartMenuFolder

;--------------------------------
; Oculus Library detection
  Function GetVolumePathNames
    !define GetVolumePathNamesForVolumeName "Kernel32::GetVolumePathNamesForVolumeName(t,t,i,*i) i"
    System::Call '${GetVolumePathNamesForVolumeName}("$0",.r0,${NSIS_MAX_STRLEN},)'
  FunctionEnd  ;GetDiskVolumeSerialNumber

  Function .onInit
    ReadRegStr $0 HKCU "Software\Oculus VR, LLC\Oculus\Libraries" "DefaultLibrary"
    StrCmp $0 "" 0 OculusFound
      MessageBox MB_OK "Oculus Software not found. Go to oculus.com/setup to install it."
      Abort ; causes installer to quit.
    OculusFound:
    StrCpy $0 "Software\Oculus VR, LLC\Oculus\Libraries\$0"
    ReadRegStr $0 HKCU $0 "Path"
    StrCmp $0 "" 0 LibraryFound
      MessageBox MB_OK "Oculus Library not found. Unable to get install path."
      Abort ; causes installer to quit.
    LibraryFound:
    StrCpy $1 $0 "" 49
    StrCpy $0 $0 49
    Call GetVolumePathNames
    StrCpy $INSTDIR "$0$1\Software\epic-games-odin"
    IfFileExists $INSTDIR\*.* NoAbort 0
      MessageBox MB_OK "Robo Recall not found. Did you download it from the Oculus Store?"
      Abort ; causes installer to quit.
    NoAbort:
  FunctionEnd

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------
;Pages

  !insertmacro MUI_PAGE_DIRECTORY
  
  ;Start Menu Folder Page Configuration
  !define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU" 
  !define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\RoboRevive" 
  !define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"
  
  !insertmacro MUI_PAGE_STARTMENU Application $StartMenuFolder
  
  !insertmacro MUI_PAGE_INSTFILES
  
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  
;--------------------------------
;Languages
 
  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

Section "RoboRevive Mod" SecRevive

  ; Restart Oculus Service to prevent entitlement errors
  DetailPrint "Restarting Oculus Service..."
  ReadRegStr $0 HKLM "Software\Oculus VR, LLC\Oculus" "Base"
  StrCmp $0 "" 0 NoAbort
    MessageBox MB_OK "Oculus Software not found. Go to oculus.com/setup to install it."
    Abort ; causes installer to quit.
  NoAbort:
  ExecWait '"$0Support\oculus-runtime\OVRServiceLauncher.exe" -stop'
  ExecWait '"$0Support\oculus-runtime\OVRServiceLauncher.exe" -start'

  ; Icon for the Robo Recall shortcuts
  SetOutPath "$INSTDIR"
  File Icon.ico
  File small_landscape_image.jpg
  File app.vrmanifest

  ; Add a Robo Recall shortcut to the desktop
  CreateShortCut "$DESKTOP\Robo Recall.lnk" "$INSTDIR\RoboRecall\Binaries\Win64\RoboRecall-Win64-Shipping.exe" "" "$INSTDIR\Icon.ico"

  ; OpenVR dependency for the Unreal Engine
  SetOutPath "$INSTDIR\Engine\Binaries\ThirdParty"
  File /r Engine\Binaries\ThirdParty\OpenVR

  ;Store installation folder
  WriteRegStr HKCU "Software\RoboRevive" "" $INSTDIR
  
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\UninstallRoboRevive.exe"
  
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    
    ;Create shortcuts
    CreateDirectory "$SMPROGRAMS\$StartMenuFolder"
    CreateShortCut "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk" "$INSTDIR\UninstallRoboRevive.exe"
    CreateShortCut "$SMPROGRAMS\$StartMenuFolder\Robo Recall.lnk" "$INSTDIR\RoboRecall\Binaries\Win64\RoboRecall-Win64-Shipping.exe" "" "$INSTDIR\Icon.ico"
  
  !insertmacro MUI_STARTMENU_WRITE_END

  ; Register the application manifest with OpenVR
  InitPluginsDir
  File /oname=$PLUGINSDIR\openvr_api.dll openvr_api.dll
  File /oname=$PLUGINSDIR\vrappreg.exe vrappreg.exe
  ExecWait '"$PLUGINSDIR\vrappreg.exe" "$INSTDIR\app.vrmanifest"'

  ; Extract the mod package to the temp folder and install it
  File /oname=$TEMP\Revive.robo RoboRecall\Plugins\Revive\Revive.robo
  DetailPrint "Continue installation in Robo Recall Mod Installer dialog"
  ExecWait '"$INSTDIR\RoboRecall\Binaries\Win64\RoboRecallModInstaller.exe" "$TEMP\Revive.robo"'
  Delete $TEMP\Revive.robo

SectionEnd

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  RMDir /r "$INSTDIR\Engine\Binaries\ThirdParty\OpenVR"
  RMDir /r "$INSTDIR\RoboRecall\Plugins\Revive"

  Delete "$INSTDIR\Icon.ico"
  Delete "$DESKTOP\Robo Recall.lnk"
  Delete "$INSTDIR\Uninstall.exe"
  
  !insertmacro MUI_STARTMENU_GETFOLDER Application $StartMenuFolder
    
  Delete "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk"
  RMDir "$SMPROGRAMS\$StartMenuFolder"

  DeleteRegKey /ifempty HKCU "Software\RoboRevive"

SectionEnd
