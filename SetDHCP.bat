@echo off

rem Set the network interface name
set "interfaceName=Ethernet"

rem Change the IPv4 configuration to DHCP
netsh interface ipv4 set address name="%interfaceName%" source=dhcp
netsh interface ipv4 set dnsservers name="%interfaceName%" source=dhcp

echo The IPv4 configuration has been changed to DHCP.

pause
