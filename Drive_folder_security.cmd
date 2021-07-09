@echo off
REM set DRIVE_LETTER=D

REM md %DRIVE_LETTER%:\NAS-drive-for-Harness 

REM md D:\NAS-drive-for-Harness\Dicom D:\NAS-drive-for-Harness\HeadModels D:\NAS-drive-for-Harness\Recordings D:\NAS-drive-for-Harness\Settings

REM powershell "New-SmbShare -Name "NAS-drive-for-Harness" -Path "%DRIVE_LETTER%:\NAS-drive-for-Harness" -FullAccess "%domain%\appuser""
REM powershell Set-SmbServerConfiguration -EncryptData $true -Force
powershell Set-SmbShare -Name "NAS-drive-for-Harness" -EncryptData $True -Force
powershell Set-SmbServerConfiguration –EnableSMB1Protocol $false -Force



