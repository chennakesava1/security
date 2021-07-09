'COPYRIGHT KONINKLIJKE PHILIPS ELECTRONICS N.V. 2012
'All rights are reserved. Reproduction in whole or in part is
'prohibited without the written consent of the copyright owner.
'
'Filename:	IE_ZoneSettings.vbs
'
'Author: Karishma Kotak
'
'Description:
'   The script adds the Windows explorer settings
'
'Revisions:
' 3/9/2012 CR0053361:  Apply Security Hardening to MI3 Win7 OS -Karishma Kotak

Option Explicit

On Error Resume Next

wscript.echo "Begin - WindowsExplorerSettings.vbs"

Dim objFSO,oWshNetwork,oUserAccount,strComputer,oReg, advanced

'Get User SID
Const HKEY_USERS = &H80000003 
 Set oReg=GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\default:StdRegProv") 
strComputer = "."
Set objFSO = CreateObject("Scripting.FileSystemObject") 
Set oWshNetwork = CreateObject("WScript.Network") 

Set oUserAccount = GetObject("winmgmts://./root/cimv2") _ 
.Get("Win32_UserAccount.Domain='" & oWshNetwork.UserDomain & "'" _ 
& ",Name='" & oWshNetwork.UserName & "'") 

advanced="\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
oReg.SetDWORDValue HKEY_USERS,oUserAccount.SID & advanced,"Hidden",1
oReg.SetDWORDValue HKEY_USERS,oUserAccount.SID & advanced,"HideFileExt",0
oReg.SetDWORDValue HKEY_USERS,oUserAccount.SID & advanced,"ShowSuperHidden",1
oReg.SetDWORDValue HKEY_USERS,oUserAccount.SID & advanced,"SuperHidden",1
oReg.SetDWORDValue HKEY_USERS,oUserAccount.SID & advanced,"AlwaysShowMenus",1
wscript.echo "Successfully configured Windows Explorer"
wscript.echo "End - WindowsExplorer.vbs"
WScript.Quit


