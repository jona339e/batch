@echo off

REM Batch file commands

REM Open PowerShell and execute commands
powershell -Command "Install-WindowsFeature -Name DNS -IncludeManagementTools"

REM Add a delay of 5 seconds
timeout /t 5 >nul

REM Open PowerShell and execute commands
powershell -Command "Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools"

REM More batch file commands


echo Promoting to Child Domain Controller...

:: Specify the domain name and the existing domain controller's IP address
set DomainName=child2.corp135.com
set ExistingDCIP=10.233.143.135


:: Promote the server to a domain controller
dcpromo.exe /unattend /replicaOrNewDomain:replica /replicaDomainDNSName:%DomainName% /ConfirmGC:Yes /SafeModeAdminPassword:password /DatabasePath:"%SystemRoot%\NTDS" /LogPath:"%SystemRoot%\NTDS" /SYSVOLPath:"%SystemRoot%\SYSVOL" /InstallDNS:Yes /ConfirmGc:Yes /ReplicationSourceDC:%ExistingDCIP% /UserName:Administrator /UserDomain:%DomainName% /Password:password

echo Child Domain Controller promotion completed.

pause