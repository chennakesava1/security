@ECHO OFF

	
REM ***************************************************************************************************************************************************************

SET SECURITY_DBASE_DIR=%SystemDrive%\WINDOWS\Security\Database
SET SECURITY_TEMPLATE_DIR=%SystemDrive%\WINDOWS\Security\Templates
REM SET INSTALL_DIR=%SystemDrive%\Deployment\Phase2
REM SET TOOLS_DIR=%SystemDrive%\Deployment\Tools
REM SET NETCONFIG_VBS="cscript %SystemDrive%\Deployment\Tools\NetworkConfig.vbs"
REM SET RUNKEY="HKLM\SOFTWARE\PMS Ultrasound\Mercury\Run"
SET SYS32DIR=C:\Windows\System32

IF EXIST "C:\Windows\Sysnative\cmd.exe" (
    SET SYS32DIR=C:\Windows\Sysnative
)

ECHO *********************   Enter: OsSecurityPolicy_Win10.cmd   *********************

REM ***************************************************************************************************************************************************************
REM Copy our custom security template to Windows.
REM In Win10, we could use the same template for all platforms, but VM is taking second-level hardening and Xperius 
REM is not so for a time they will diverge. 
REM ***************************************************************************************************************************************************************

IF EXIST "%SystemDrive%\Deployment\PremiumPlatform.info" (
    ECHO "%SystemDrive%\Deployment\PremiumPlatform.info" exists

    ECHO COPY /Y Win10SecurityTemplate_premium.inf %SECURITY_TEMPLATE_DIR%
    COPY /Y Win10SecurityTemplate_premium.inf %SECURITY_TEMPLATE_DIR%
    ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%
) ELSE (
    ECHO "%SystemDrive%\Deployment\PremiumPlatform.info" does NOT exist

    ECHO COPY /Y Win10SecurityTemplate.inf %SECURITY_TEMPLATE_DIR%
    COPY /Y Win10SecurityTemplate.inf %SECURITY_TEMPLATE_DIR%
    ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%
)

ECHO.

REM ***************************************************************************************************************************************************************
REM Create our security database and configure the database with our custom security template
REM ***************************************************************************************************************************************************************

IF EXIST "%SystemDrive%\Deployment\PremiumPlatform.info" (
    ECHO "%SystemDrive%\Deployment\PremiumPlatform.info" exists

    ECHO %SYS32DIR%\secedit.exe /configure /db "%SECURITY_DBASE_DIR%\Win10Security.sdb" /cfg "%SECURITY_TEMPLATE_DIR%\Win10SecurityTemplate_premium.inf"
    %SYS32DIR%\secedit.exe /configure /db "%SECURITY_DBASE_DIR%\Win10Security.sdb" /cfg "%SECURITY_TEMPLATE_DIR%\Win10SecurityTemplate_premium.inf"
    ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

    ECHO %SYS32DIR%\secedit.exe /configure /db "%SECURITY_DBASE_DIR%\Win10Security.sdb" /cfg "%SECURITY_TEMPLATE_DIR%\Win10SecurityTemplate_premium.inf" /areas USER_RIGHTS
    %SYS32DIR%\secedit.exe /configure /db "%SECURITY_DBASE_DIR%\Win10Security.sdb" /cfg "%SECURITY_TEMPLATE_DIR%\Win10SecurityTemplate_premium.inf" /areas USER_RIGHTS
    ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%
) ELSE (
    ECHO "%SystemDrive%\Deployment\PremiumPlatform.info" does NOT exist

    ECHO %SYS32DIR%\secedit.exe /configure /db "%SECURITY_DBASE_DIR%\Win10Security.sdb" /cfg "%SECURITY_TEMPLATE_DIR%\Win10SecurityTemplate.inf"
    %SYS32DIR%\secedit.exe /configure /db "%SECURITY_DBASE_DIR%\Win10Security.sdb" /cfg "%SECURITY_TEMPLATE_DIR%\Win10SecurityTemplate.inf"
    ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

    ECHO %SYS32DIR%\secedit.exe /configure /db "%SECURITY_DBASE_DIR%\Win10Security.sdb" /cfg "%SECURITY_TEMPLATE_DIR%\Win10SecurityTemplate.inf" /areas USER_RIGHTS
    %SYS32DIR%\secedit.exe /configure /db "%SECURITY_DBASE_DIR%\Win10Security.sdb" /cfg "%SECURITY_TEMPLATE_DIR%\Win10SecurityTemplate.inf" /areas USER_RIGHTS
    ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%
)

ECHO.

REM ***************************************************************************************************************************************************************
REM Apply our security template settings to the Local Policy
REM ***************************************************************************************************************************************************************

REM Calling %SYS32DIR%\gpupdate.exe /force to apply our security template settings to the Local Security Settings
ECHO %SYS32DIR%\gpupdate.exe /force
%SYS32DIR%\gpupdate.exe /force
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO.

REM ***************************************************************************************************************************************************************
REM We apply the template twice, we get few errors the first time and few settings are not applied
REM ***************************************************************************************************************************************************************

IF EXIST "%SystemDrive%\Deployment\PremiumPlatform.info" (
    ECHO "%SystemDrive%\Deployment\PremiumPlatform.info" exists

    ECHO %SYS32DIR%\secedit.exe /configure /db "%SECURITY_DBASE_DIR%\Win10Security.sdb" /cfg "%SECURITY_TEMPLATE_DIR%\Win10SecurityTemplate_premium.inf" /areas SECURITYPOLICY
    %SYS32DIR%\secedit.exe /configure /db "%SECURITY_DBASE_DIR%\Win10Security.sdb" /cfg "%SECURITY_TEMPLATE_DIR%\Win10SecurityTemplate_premium.inf" /areas SECURITYPOLICY
    ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

    ECHO %SYS32DIR%\secedit.exe /configure /db "%SECURITY_DBASE_DIR%\Win10Security.sdb" /cfg "%SECURITY_TEMPLATE_DIR%\Win10SecurityTemplate_premium.inf" /areas USER_RIGHTS
    %SYS32DIR%\secedit.exe /configure /db "%SECURITY_DBASE_DIR%\Win10Security.sdb" /cfg "%SECURITY_TEMPLATE_DIR%\Win10SecurityTemplate_premium.inf" /areas USER_RIGHTS
    ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%
) ELSE (
    ECHO "%SystemDrive%\Deployment\PremiumPlatform.info" does NOT exist

    ECHO %SYS32DIR%\secedit.exe /configure /db "%SECURITY_DBASE_DIR%\Win10Security.sdb" /cfg "%SECURITY_TEMPLATE_DIR%\Win10SecurityTemplate.inf" /areas SECURITYPOLICY
    %SYS32DIR%\secedit.exe /configure /db "%SECURITY_DBASE_DIR%\Win10Security.sdb" /cfg "%SECURITY_TEMPLATE_DIR%\Win10SecurityTemplate.inf" /areas SECURITYPOLICY
    ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

    ECHO %SYS32DIR%\secedit.exe /configure /db "%SECURITY_DBASE_DIR%\Win10Security.sdb" /cfg "%SECURITY_TEMPLATE_DIR%\Win10SecurityTemplate.inf" /areas USER_RIGHTS
    %SYS32DIR%\secedit.exe /configure /db "%SECURITY_DBASE_DIR%\Win10Security.sdb" /cfg "%SECURITY_TEMPLATE_DIR%\Win10SecurityTemplate.inf" /areas USER_RIGHTS
    ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%
)

ECHO.

REM ***************************************************************************************************************************************************************
REM Apply our security template settings to the Local Policy
REM ***************************************************************************************************************************************************************

REM Calling %SYS32DIR%\gpupdate.exe /force to apply our security template settings to the Local Security Settings
ECHO %SYS32DIR%\gpupdate.exe /force
%SYS32DIR%\gpupdate.exe /force
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO.

REM ***************************************************************************************************************************************************************
REM Disabling the built-in administrator account
REM ***************************************************************************************************************************************************************

REM REM Neuro need admin perpesion to run the application Cliet cad do this 
REM ECHO %SYS32DIR%\net.exe user administrator /active:no
REM %SYS32DIR%\net.exe user administrator /active:no
REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM ECHO.

REM ***************************************************************************************************************************************************************
REM Set the alternate administrator account to never expire
REM ***************************************************************************************************************************************************************

REM ECHO %SYS32DIR%\wbem\wmic.exe useraccount where "name='NEURO'" set passwordexpires=false
REM %SYS32DIR%\wbem\wmic.exe useraccount where "name='NEURO'" set passwordexpires=false
REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM ECHO.

REM ***************************************************************************************************************************************************************
REM Configure the Firewall
REM ***************************************************************************************************************************************************************

ECHO %SYS32DIR%\netsh.exe advfirewall firewall set rule group="File and Printer Sharing" new enable=No
%SYS32DIR%\netsh.exe advfirewall firewall set rule group="File and Printer Sharing" new enable=No
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM REM ECHO %SYS32DIR%\netsh.exe advfirewall firewall set rule group="Client for NFS" new enable=No
REM REM %SYS32DIR%\netsh.exe advfirewall firewall set rule group="Client for NFS" new enable=No
REM REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%


REM REM ******* This have to be validate 

ECHO %SYS32DIR%\netsh.exe advfirewall firewall set rule group="Core Networking" new enable=No
%SYS32DIR%\netsh.exe advfirewall firewall set rule group="Core Networking" new enable=No
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

netsh advfirewall firewall add rule name="Neuro HTTPS" protocol=TCP dir=in localport=443 action=allow

REM REM ************need to about this 

REM ECHO %SYS32DIR%\netsh.exe advfirewall firewall set rule group="Distributed scan client components" new enable=No
REM %SYS32DIR%\netsh.exe advfirewall firewall set rule group="Distributed scan client components" new enable=No
REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM ***********Line Printer Daemon (LPD) Service
ECHO %SYS32DIR%\netsh.exe advfirewall firewall set rule group="LPD Service" new enable=No
%SYS32DIR%\netsh.exe advfirewall firewall set rule group="LPD Service" new enable=No
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM ******** RabbitMQ messages may effort but we need to test 
REM REM ECHO %SYS32DIR%\netsh.exe advfirewall firewall set rule group="Message Queuing" new enable=No
REM REM %SYS32DIR%\netsh.exe advfirewall firewall set rule group="Message Queuing" new enable=No
REM REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%


REM ********* this will stop the RDP connection This not requir in PIC

REM ECHO %SYS32DIR%\netsh.exe advfirewall firewall set rule group="Remote Assistance" new enable=No
REM %SYS32DIR%\netsh.exe advfirewall firewall set rule group="Remote Assistance" new enable=No
REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM ********* This will stop NAS drive access 
REM REM ECHO %SYS32DIR%\netsh.exe advfirewall firewall set rule group="SNMP Service" new enable=No
REM REM %SYS32DIR%\netsh.exe advfirewall firewall set rule group="SNMP Service" new enable=No
REM REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%


REM ******* this may stop the rabbitMQ messages -- "you can send data as asynchronous messages from one service endpoint to another"

REM ECHO %SYS32DIR%\netsh.exe advfirewall firewall set rule group="Windows Communication Foundation" new enable=No
REM %SYS32DIR%\netsh.exe advfirewall firewall set rule group="Windows Communication Foundation" new enable=No
REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM ***** Thsi can be test on both server and client 

REM REM ECHO %SYS32DIR%\netsh.exe advfirewall firewall set rule group="Network Discovery" new enable=No
REM REM %SYS32DIR%\netsh.exe advfirewall firewall set rule group="Network Discovery" new enable=No
REM REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM ****** SMB port bydefault 
REM ECHO START /WAIT %SYS32DIR%\netsh.exe firewall delete portopening protocol = ALL port = 139
REM START /WAIT %SYS32DIR%\netsh.exe firewall delete portopening protocol = ALL port = 139
REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM REM **** 445 & 137 138 ports related to SAMBA service 
REM ECHO START /WAIT %SYS32DIR%\netsh.exe firewall delete portopening protocol = ALL port = 445
REM START /WAIT %SYS32DIR%\netsh.exe firewall delete portopening protocol = ALL port = 445
REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM ECHO START /WAIT %SYS32DIR%\netsh.exe firewall delete portopening protocol = ALL port = 137
REM START /WAIT %SYS32DIR%\netsh.exe firewall delete portopening protocol = ALL port = 137
REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM ECHO START /WAIT %SYS32DIR%\netsh.exe firewall delete portopening protocol = ALL port = 138
REM START /WAIT %SYS32DIR%\netsh.exe firewall delete portopening protocol = ALL port = 138
REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM ECHO START /WAIT %SYS32DIR%\netsh.exe advfirewall firewall add rule name="Block Inbound Port 135" dir=in localport=135 protocol=TCP action=block
REM start /wait %SYS32DIR%\netsh.exe advfirewall firewall add rule name="Block Inbound Port 135" dir=in localport=135 protocol=TCP action=block
REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM ECHO START /WAIT %SYS32DIR%\netsh.exe advfirewall firewall add rule name="Block Inbound Port 445" dir=in localport=445 protocol=TCP action=block
REM start /wait %SYS32DIR%\netsh.exe advfirewall firewall add rule name="Block Inbound Port 445" dir=in localport=445 protocol=TCP action=block
REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM ECHO START /WAIT %SYS32DIR%\netsh.exe advfirewall firewall add rule name="Block Inbound Port 515" dir=in localport=515 protocol=TCP action=block
REM start /wait %SYS32DIR%\netsh.exe advfirewall firewall add rule name="Block Inbound Port 515" dir=in localport=515 protocol=TCP action=block
REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM ECHO START /WAIT %SYS32DIR%\netsh.exe advfirewall firewall add rule name="Block Inbound Port 5357" dir=in localport=5357 protocol=TCP action=block
REM start /wait %SYS32DIR%\netsh.exe advfirewall firewall add rule name="Block Inbound Port 5357" dir=in localport=5357 protocol=TCP action=block
REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO.

REM ***************************************************************************************************************************************************************
REM Allow ICMPv4 echo request
REM ***************************************************************************************************************************************************************

ECHO %SYS32DIR%\netsh.exe advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol=icmpv4:8,any dir=in action=allow
%SYS32DIR%\netsh.exe advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol=icmpv4:8,any dir=in action=allow
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO.

REM ***************************************************************************************************************************************************************
REM Configure IPv6 Firewall Rules
REM ***************************************************************************************************************************************************************

ECHO regedit.exe /s IPv6FirewallRules.reg
regedit.exe /s IPv6FirewallRules.reg
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO.

REM ***************************************************************************************************************************************************************
REM Allow ICMPv6 echo request
REM ***************************************************************************************************************************************************************

ECHO %SYS32DIR%\netsh.exe advfirewall firewall add rule name="ICMP Allow incoming V6 echo request" protocol="icmpv6:128,any" dir=in action=allow
%SYS32DIR%\netsh.exe advfirewall firewall add rule name="ICMP Allow incoming V6 echo request" protocol="icmpv6:128,any" dir=in action=allow
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO.

REM ***************************************************************************************************************************************************************
REM Configure the Component Services
REM ***************************************************************************************************************************************************************

REM ECHO regedit.exe /s DCOM_config1.reg
REM regedit.exe /s DCOM_config1.reg
REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM ECHO regedit.exe /s DCOM_config2.reg
REM regedit.exe /s DCOM_config2.reg
REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM ECHO.

REM ***************************************************************************************************************************************************************
REM Disable Local Policies - Security Options - Disable Named Pipes
REM ***************************************************************************************************************************************************************

ECHO regedit.exe /s DisableAnonymousNamedPipesAndShares.reg
regedit.exe /s DisableAnonymousNamedPipesAndShares.reg
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO.


REM ***************************************************************************************************************************************************************
REM Disable Local Policies - Security Options - Remote Accessible Registry
REM ***************************************************************************************************************************************************************

ECHO regedit.exe /s DisableRemoteAccessibleRegistry.reg
regedit.exe /s DisableRemoteAccessibleRegistry.reg
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO.

REM ***************************************************************************************************************************************************************
REM Set Internet Explorer Restrictions and Zones + fully implement patches
REM ***************************************************************************************************************************************************************

REM ECHO regedit.exe /s IE_Restrictions.reg
REM regedit.exe /s IE_Restrictions.reg
REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM ECHO %SYS32DIR%\cscript.exe //nologo //h:cscript IE_ZoneSettings.vbs
REM %SYS32DIR%\cscript.exe //nologo //h:cscript IE_ZoneSettings.vbs
REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM ECHO regedit.exe /s IE_EnablePrintFix.reg
REM regedit.exe /s IE_EnablePrintFix.reg
REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM ECHO regedit.exe /s IE_EnablePrintFixWOW.reg
REM regedit.exe /s IE_EnablePrintFixWOW.reg
REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO.

REM ***************************************************************************************************************************************************************
REM Windows Explorer Settings
REM ***************************************************************************************************************************************************************

REM ECHO %SYS32DIR%\cscript.exe //nologo //h:cscript WindowsExplorerSettings.vbs
REM %SYS32DIR%\cscript.exe //nologo //h:cscript WindowsExplorerSettings.vbs
REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO.

REM ***************************************************************************************************************************************************************
REM Disable Services
REM ***************************************************************************************************************************************************************

REM ECHO %SYS32DIR%\cscript.exe disablesvcs.vbs
REM %SYS32DIR%\cscript.exe disablesvcs.vbs
REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM ECHO.

REM ***************************************************************************************************************************************************************
REM Configure Services
REM ***************************************************************************************************************************************************************

REM TCP/IP Print Server service
ECHO %SYS32DIR%\sc.exe config lpdsvc start= disabled
%SYS32DIR%\sc.exe config lpdsvc start= disabled
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM REM Message Queuing
REM ECHO %SYS32DIR%\sc.exe config msmq start= disabled
REM %SYS32DIR%\sc.exe config msmq start= disabled
REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM Simple Network Management Protocol
REM ECHO %SYS32DIR%\sc.exe config snmp start= disabled
REM %SYS32DIR%\sc.exe config snmp start= disabled
REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM Secondary Logon

REM ******* This can test calient and server
REM ECHO %SYS32DIR%\sc.exe config seclogon start= disabled
REM %SYS32DIR%\sc.exe config seclogon start= disabled
REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO.

REM ***************************************************************************************************************************************************************
REM Apply additional patches not yet included in the WIM file. When these are eventually added to the WIM, they can be removed
REM ***************************************************************************************************************************************************************

REM ****** Need to check 
ECHO rvkroots.exe
rvkroots.exe
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO.

REM ***************************************************************************************************************************************************************
REM Disable AutoRun
REM ***************************************************************************************************************************************************************

ECHO regedit.exe /s DisableAutoRun.reg
regedit.exe /s DisableAutoRun.reg
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO.

REM ***************************************************************************************************************************************************************
REM Disable Netbios
REM ***************************************************************************************************************************************************************

ECHO COPY /Y disableNetBios.vbs %TOOLS_DIR%
COPY /Y disableNetBios.vbs %TOOLS_DIR%
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO %SYS32DIR%\reg.exe add %RUNKEY% /v NETBIOS_RUN /d "cscript %SystemDrive%\Deployment\Tools\disableNetBios.vbs" /f /reg:64
%SYS32DIR%\reg.exe add %RUNKEY% /v NETBIOS_RUN /d "cscript %SystemDrive%\Deployment\Tools\disableNetBios.vbs" /f /reg:64
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO.

REM ***************************************************************************************************************************************************************
REM Copy Network Configuration package and add the batch script to the RunOnce key in order to run after the next reboot
REM ***************************************************************************************************************************************************************

REM ECHO COPY /Y NetworkConfig.exe %TOOLS_DIR%
REM COPY /Y NetworkConfig.exe %TOOLS_DIR%
REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM ECHO COPY /Y NetworkConfig.vbs %TOOLS_DIR%
REM COPY /Y NetworkConfig.vbs %TOOLS_DIR%
REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM ECHO %SYS32DIR%\reg.exe add %RUNKEY% /v NETCONFIG_RUN /d %NETCONFIG_VBS% /f /reg:64
REM %SYS32DIR%\reg.exe add %RUNKEY% /v NETCONFIG_RUN /d %NETCONFIG_VBS% /f /reg:64
REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM ECHO.

REM ***************************************************************************************************************************************************************
REM Disable Internet explorer application and Windows Help and Support windows network Diagnostic
REM ***************************************************************************************************************************************************************

ECHO regedit.exe /s EnforcePolicy.reg
regedit.exe /s EnforcePolicy.reg
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO %SYS32DIR%\gpupdate.exe /force
%SYS32DIR%\gpupdate.exe /force
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO.

REM ***************************************************************************************************************************************************************
REM Apply security registry fixes
REM ***************************************************************************************************************************************************************

ECHO %SYS32DIR%\reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Subsystems" /v Posix /f
%SYS32DIR%\reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Subsystems" /v Posix /f
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO %SYS32DIR%\reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Subsystems" /v PosixSingleInstance /f
%SYS32DIR%\reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Subsystems" /v PosixSingleInstance /f
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO regedit.exe /s VADoDSecurityHarden.reg
regedit.exe /s VADoDSecurityHarden.reg
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO.

REM IF NOT EXIST "%SystemDrive%\Deployment\PremiumPlatform.info" (
    REM ECHO "%SystemDrive%\Deployment\PremiumPlatform.info" does NOT exist

    REM REM ***************************************************************************************************************************************************************
    REM REM Hide all Control Panel icons (Common Platform only)
    REM REM ***************************************************************************************************************************************************************

    REM ECHO regedit.exe /s HideControlPanel.reg
    REM regedit.exe /s HideControlPanel.reg
    REM ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

    REM GOTO :END
REM )

ECHO "%SystemDrive%\Deployment\PremiumPlatform.info" exists

ECHO Fix for Nessus Scan "MS KB2960358: Update for Disabling RC4 in .NET TLS"
REM Eventually add this for Common Platform, too. After Xperius 2.0

ECHO %SYS32DIR%\reg.exe add "HKLM\SOFTWARE\Microsoft\.NETFramework\v2.0.50727" /v SchUseStrongCrypto /t REG_DWORD /d 1 /f /reg:64
%SYS32DIR%\reg.exe add "HKLM\SOFTWARE\Microsoft\.NETFramework\v2.0.50727" /v SchUseStrongCrypto /t REG_DWORD /d 1 /f /reg:64
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO %SYS32DIR%\reg.exe add "HKLM\SOFTWARE\Microsoft\.NETFramework\v2.0.50727" /v SchUseStrongCrypto /t REG_DWORD /d 1 /f /reg:32
%SYS32DIR%\reg.exe add "HKLM\SOFTWARE\Microsoft\.NETFramework\v2.0.50727" /v SchUseStrongCrypto /t REG_DWORD /d 1 /f /reg:32
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM ***************************************************************************************************************************************************************
REM Delete all scheduled tasks for Premium Platform
REM ***************************************************************************************************************************************************************

ECHO %SYS32DIR%\schtasks.exe /delete /TN * /F
%SYS32DIR%\schtasks.exe /delete /TN * /F
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO.

REM ***************************************************************************************************************************************************************
REM PD28194: Configure Windows Firewall to allow DHCP traffic
REM ***************************************************************************************************************************************************************

ECHO %SYS32DIR%\netsh.exe advfirewall firewall set rule name="Core Networking - Dynamic Host Configuration Protocol (DHCP-In)" new enable=yes
%SYS32DIR%\netsh.exe advfirewall firewall set rule name="Core Networking - Dynamic Host Configuration Protocol (DHCP-In)" new enable=yes
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO %SYS32DIR%\netsh.exe advfirewall firewall set rule name="Core Networking - Dynamic Host Configuration Protocol for IPv6(DHCPV6-In)" new enable=yes
%SYS32DIR%\netsh.exe advfirewall firewall set rule name="Core Networking - Dynamic Host Configuration Protocol for IPv6(DHCPV6-In)" new enable=yes
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO %SYS32DIR%\netsh.exe advfirewall firewall set rule name="Core Networking - Dynamic Host Configuration Protocol (DHCP-Out)" new enable=yes
%SYS32DIR%\netsh.exe advfirewall firewall set rule name="Core Networking - Dynamic Host Configuration Protocol (DHCP-Out)" new enable=yes
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO %SYS32DIR%\netsh.exe advfirewall firewall set rule name="Core Networking - Dynamic Host Configuration Protocol for IPv6(DHCPV6-Out)" new enable=yes
%SYS32DIR%\netsh.exe advfirewall firewall set rule name="Core Networking - Dynamic Host Configuration Protocol for IPv6(DHCPV6-Out)" new enable=yes
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

REM ***************************************************************************************************************************************************************
REM Make additional firewall settings as required by DoD Firewall STIG test
REM ***************************************************************************************************************************************************************

ECHO %SYS32DIR%\netsh.exe advfirewall set domainprofile logging maxfilesize 16384
%SYS32DIR%\netsh.exe advfirewall set domainprofile logging maxfilesize 16384
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO %SYS32DIR%\netsh.exe advfirewall set privateprofile logging maxfilesize 16384
%SYS32DIR%\netsh.exe advfirewall set privateprofile logging maxfilesize 16384
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO %SYS32DIR%\netsh.exe advfirewall set publicprofile firewallpolicy blockinbound,allowoutbound
%SYS32DIR%\netsh.exe advfirewall set publicprofile firewallpolicy blockinbound,allowoutbound
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO %SYS32DIR%\netsh.exe advfirewall set publicprofile logging maxfilesize 16384
%SYS32DIR%\netsh.exe advfirewall set publicprofile logging maxfilesize 16384
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO %SYS32DIR%\netsh.exe advfirewall set allprofiles logging droppedconnections enable
%SYS32DIR%\netsh.exe advfirewall set allprofiles logging droppedconnections enable
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO %SYS32DIR%\netsh.exe advfirewall set allprofiles logging allowedconnections enable
%SYS32DIR%\netsh.exe advfirewall set allprofiles logging allowedconnections enable
ECHO DEBUG: %%ERRORLEVEL%%=%ERRORLEVEL%

ECHO.

:END

ECHO *********************   Exit: OsSecurityPolicy.cmd   *********************