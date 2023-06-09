@echo off

setlocal enabledelayedexpansion

rem Retrieve IPv4 address
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4 Address"') do (
    set "ipAddress=%%a"
    set "ipAddress=!ipAddress:~1!"
)

rem Retrieve subnet mask
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"Subnet Mask"') do (
    set "subnetMask=%%a"
    set "subnetMask=!subnetMask:~1!"
)

rem Retrieve default gateway
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"Default Gateway"') do (
    set "defaultGateway=%%a"
    set "defaultGateway=!defaultGateway:~1!"
)


REM Specify the network interface name
set interface="Ethernet"

REM Specify the desired IPv4 address, subnet mask, and default gateway
set ip_address=%ipAddress%
set subnet_mask=%subnetMask%
set default_gateway=%defaultGateway%

rem Set primary DNS server
netsh interface ip set dns "Ethernet" static 10.233.143.135

REM Set the IPv4 address to static
netsh interface ipv4 set address name=%interface% static %ip_address% %subnet_mask% %default_gateway%

REM Verify the changes
echo IPv4 address set to static:
netsh interface ipv4 show config name=%interface%

pause