@echo off

rem Set the network interface name
set "interfaceName=Ethernet"

rem Change the IPv4 configuration to DHCP
netsh interface ipv4 set address name="%interfaceName%" source=dhcp
netsh interface ipv4 set dnsservers name="%interfaceName%" source=dhcp

echo The IPv4 configuration has been changed to DHCP.


timeout /t 10 >nul

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

timeout /t 3 >nul



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

echo Unjoining from the current domain...
powershell -Command "$password = ConvertTo-SecureString '%password%' -AsPlainText -Force; Remove-Computer -UnjoinDomainCredential (New-Object System.Management.Automation.PSCredential('%username%', $password)) -PassThru -Restart"



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

pause