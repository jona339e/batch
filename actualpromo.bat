@echo off

REM Batch file commands

REM Open PowerShell and execute commands
powershell.exe -ExecutionPolicy Bypass -Command "$credential = Get-Credential; Import-Module ADDSDeployment; Install-ADDSDomainController -Credential $credential -DomainName 'child2.corp117.com' -InstallDNS -SafeModeAdministratorPassword (Read-Host -AsSecureString 'Enter Safe Mode Administrator Password') -Force"

REM More batch file commands

pause
