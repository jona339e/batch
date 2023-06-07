@echo off
setlocal enabledelayedexpansion

REM Get the IPv4 address
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4 Address"') do (
    set "ipv4=%%a"
)

REM Extract the last part of the IPv4 address
for /f "tokens=1-4 delims=." %%a in ("%ipv4%") do (
    set "last_part=%%d"
)

REM Set the hostname
set "hostname=DC-%last_part%"

REM Set the hostname
wmic computersystem where name="%computername%" call rename name="%hostname%"

echo Hostname has been set to %hostname%


timeout /t 5 >nul


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