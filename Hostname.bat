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

pause