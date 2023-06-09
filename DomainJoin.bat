@echo off
set /p domainname="Enter the name of the domain you wish to join: "
set /p username="Enter the username with administrative privileges: "
set /p password="Enter the password: "

echo Joining the domain...

powershell -Command "$password = ConvertTo-SecureString '%password%' -AsPlainText -Force; Add-Computer -DomainName '%domainname%' -Credential (New-Object System.Management.Automation.PSCredential('%username%', $password)) -Restart"

if %errorlevel% equ 0 (
    echo Domain join was successful.
) else (
    echo There was an error joining the domain.
)

pause
