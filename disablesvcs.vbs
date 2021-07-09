'****************************************************************************************
'    Copyright (c) 2011 Philips Medical Systems, All rights reserved
'
'            Philips Medical Systems
'            3000 Minuteman Rd
'            Andover, MA. 01810
'
'  Module: disablesvcs.vbs   (scaled down Win7 version for clinicals)
'
'  Revision History:
'	27 Aug 2002	As Issued. - Stephen Dallas
'	04 Oct 2007	CR0019119 OS Image Hardening. - Patrick Lee
'	08 Jun 2009 CR0034901 Remove spurious log events OS9 SP3 - Allen Thurman
'	24 Aug 2009 CR0032509 OS Security options - Allen Thurman
'	31 Oct 2011 Dave Hendrickson - Win7 version
'	 
'
' Comments: 	This script configures the Start Type for all the listed services.
'               For this new state to take effect, the computer has to be re-booted.
'
'*****************************************************************************************

Dim ServiceName
dim displayname

strComputer = "."   ' This indicates the current/local machine

Set wbemServices = GetObject("winmgmts:\\" & strComputer)
Set wbemObjectSet = wbemServices.InstancesOf("Win32_Service")



  For Each wbemObject In wbemObjectSet
  '  WScript.Echo  "Display Name:  " & wbemObject.DisplayName & vbCrLf & _
  '                "State:         " & wbemObject.State       & vbCrLf & _
  '                "Start Mode:    " & wbemObject.StartMode

  	
	' Remote Registry
    If Ucase(wbemObject.Name) = Ucase("RemoteRegistry") then
      wbemObject.ChangeStartMode("Disabled")
      WScript.Echo  wbemObject.DisplayName & " Disabled" & vbCrLf
      	
     	'ned to check
	' Routing and Remote Access
    Elseif Ucase(wbemObject.Name) = Ucase("RemoteAccess") then
      wbemObject.ChangeStartMode("Disabled")
      WScript.Echo  wbemObject.DisplayName & " Disabled" & vbCrLf
      	
     	
	' Server
    ' Elseif Ucase(wbemObject.Name) = Ucase("lanmanserver") then
      ' wbemObject.ChangeStartMode("Disabled")
      ' WScript.Echo  wbemObject.DisplayName & " Disabled" & vbCrLf
      	
      	'ned to check 
	' Universal Plug and Play Device Host
    ' Elseif Ucase(wbemObject.Name) = Ucase("upnphost") then
      ' wbemObject.ChangeStartMode("Disabled")
      ' WScript.Echo  wbemObject.DisplayName & " Disabled" & vbCrLf

      
    End if
  Next



