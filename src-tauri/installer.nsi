!include "MUI2.nsh"
!include "FileFunc.nsh"

; 安装程序信息
Name "${PRODUCTNAME}"
OutFile "${OUTFILE}"
Unicode True
RequestExecutionLevel user
InstallDir "$LOCALAPPDATA\${PRODUCTNAME}"
InstallDirRegKey HKCU "Software\${PRODUCTNAME}" ""

; 界面设置
!define MUI_ABORTWARNING
!define MUI_ICON "${INSTALLERICON}"
!define MUI_UNICON "${INSTALLERICON}"

; 欢迎页面文本
!define MUI_WELCOMEPAGE_TITLE "欢迎使用定边职教安装向导"
!define MUI_WELCOMEPAGE_TEXT "欢迎使用定边职教软件安装程序！$\r$\n$\r$\n这将在您的计算机上安装 ${PRODUCTNAME}。$\r$\n$\r$\n定边职教致力于为您提供优质的教育软件服务。$\r$\n$\r$\n建议您在继续之前关闭所有其他应用程序。$\r$\n$\r$\n点击 下一步 继续安装。"

; 完成页面设置
!define MUI_FINISHPAGE_TITLE "完成定边职教安装向导"
!define MUI_FINISHPAGE_TEXT "感谢您选择定边职教！$\r$\n$\r$\n${PRODUCTNAME} 已成功安装到您的计算机。$\r$\n$\r$\n定边职教将为您提供优质的教育服务体验。$\r$\n$\r$\n点击 完成 关闭此向导。"
!define MUI_FINISHPAGE_RUN "$INSTDIR\${MAINBINARYNAME}.exe"
!define MUI_FINISHPAGE_RUN_TEXT "运行 ${PRODUCTNAME}"

; 安装页面
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "LICENSE.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

; 卸载页面
!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

; 语言
!insertmacro MUI_LANGUAGE "SimpChinese"

; 自定义中文文本
LangString DESC_SecMain ${LANG_SIMPCHINESE} "安装 ${PRODUCTNAME} 主程序文件（必需）"
LangString DESC_SecDesktop ${LANG_SIMPCHINESE} "在桌面创建快捷方式"
LangString DESC_SecStartMenu ${LANG_SIMPCHINESE} "在开始菜单创建快捷方式"

; 安装程序版本信息
VIProductVersion "${VERSION}.0"
VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "ProductName" "${PRODUCTNAME}"
VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "ProductVersion" "${VERSION}"
VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "FileDescription" "${PRODUCTNAME} 安装程序"
VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "FileVersion" "${VERSION}"
VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "CompanyName" "定边职教"
VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "LegalCopyright" "© 2025 定边职教"

; 安装程序部分
Section "主程序" SecMain
  SectionIn RO
  
  SetOutPath "$INSTDIR"
  
  ; 复制文件
  File /r "${RESOURCESDIR}\*"
  
  ; 写入注册表
  WriteRegStr HKCU "Software\${PRODUCTNAME}" "" $INSTDIR
  WriteRegStr HKCU "Software\${PRODUCTNAME}" "Version" "${VERSION}"
  
  ; 创建卸载程序
  WriteUninstaller "$INSTDIR\uninstall.exe"
  
  ; 添加到控制面板的程序列表
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCTNAME}" "DisplayName" "${PRODUCTNAME}"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCTNAME}" "UninstallString" "$INSTDIR\uninstall.exe"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCTNAME}" "DisplayIcon" "$INSTDIR\${MAINBINARYNAME}.exe"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCTNAME}" "DisplayVersion" "${VERSION}"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCTNAME}" "Publisher" "定边职教"
  WriteRegDWORD HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCTNAME}" "NoModify" 1
  WriteRegDWORD HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCTNAME}" "NoRepair" 1
  
  ; 计算安装大小
  ${GetSize} "$INSTDIR" "/S=0K" $0 $1 $2
  IntFmt $0 "0x%08X" $0
  WriteRegDWORD HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCTNAME}" "EstimatedSize" "$0"
SectionEnd

Section "桌面快捷方式" SecDesktop
  CreateShortcut "$DESKTOP\${PRODUCTNAME}.lnk" "$INSTDIR\${MAINBINARYNAME}.exe" "" "$INSTDIR\${MAINBINARYNAME}.exe" 0
SectionEnd

Section "开始菜单快捷方式" SecStartMenu
  CreateDirectory "$SMPROGRAMS\${PRODUCTNAME}"
  CreateShortcut "$SMPROGRAMS\${PRODUCTNAME}\${PRODUCTNAME}.lnk" "$INSTDIR\${MAINBINARYNAME}.exe" "" "$INSTDIR\${MAINBINARYNAME}.exe" 0
  CreateShortcut "$SMPROGRAMS\${PRODUCTNAME}\卸载 ${PRODUCTNAME}.lnk" "$INSTDIR\uninstall.exe"
SectionEnd

; 组件描述
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SecMain} $(DESC_SecMain)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecDesktop} $(DESC_SecDesktop)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecStartMenu} $(DESC_SecStartMenu)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

; 卸载程序
Section "Uninstall"
  ; 删除文件
  RMDir /r "$INSTDIR"
  
  ; 删除快捷方式
  Delete "$DESKTOP\${PRODUCTNAME}.lnk"
  RMDir /r "$SMPROGRAMS\${PRODUCTNAME}"
  
  ; 删除注册表项
  DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCTNAME}"
  DeleteRegKey HKCU "Software\${PRODUCTNAME}"
SectionEnd

; 安装程序初始化
Function .onInit
  ; 检查是否已经安装
  ReadRegStr $R0 HKCU "Software\${PRODUCTNAME}" ""
  StrCmp $R0 "" done
  
  MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION \
  "${PRODUCTNAME} 已经安装在 $R0$\n$\n点击 '确定' 继续安装，或点击 '取消' 退出安装程序。" \
  IDOK done
  Abort
done:
FunctionEnd

; 卸载程序初始化
Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "您确定要完全移除 ${PRODUCTNAME} 及其所有组件吗？" IDYES +2
  Abort
FunctionEnd