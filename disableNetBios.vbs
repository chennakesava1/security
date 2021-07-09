'disableNetBios.vbs
'
'COPYRIGHT KONINKLIJKE PHILIPS ELECTRONICS N.V. 2013
'All rights are reserved. Reproduction in whole or in part 
'is prohibited without the written consent of the copyright owner.
'
'Author: Karishma Kotak
'
'Description:
'	Disable NetBIOS over TCP/IP
'	
'

const HKEY_LOCAL_MACHINE = &H80000002
strComputer = "."
set objShell = WScript.CreateObject("WScript.Shell")
Set oReg=GetObject("winmgmts:{impersonationLevel=impersonate}!\\"&_ 
    strComputer & "\root\default:StdRegProv")
strKeyPath = "System\CurrentControlSet\Services\NetBT\Parameters\Interfaces\"
strValueName="NetBIOSOptions"
dwValue=2
oReg.EnumKey HKEY_LOCAL_MACHINE, strKeyPath, arrSubKeys
For Each subkey In arrSubKeys
    
	oReg.SetDWORDValue HKEY_LOCAL_MACHINE,strKeyPath & subkey,strValueName,dwValue
	objShell.RegDelete("HKLM\SOFTWARE\PMS Ultrasound\Mercury\Run\NETBIOS_RUN")  

Next
