@echo off
set "folderPath=C:\ShareFolder\Administration"
set "groupName=Administration_dl"

echo Setting folder permissions for %folderPath%...

icacls "%folderPath%" /grant "%groupName%:(OI)(CI)M" /T
icacls "%folderPath%" /setowner "%groupName%" /T

echo Folder permissions set successfully.


set "folderPath=C:\ShareFolder\Kantine"
set "groupName=Kantine_dl"

echo Setting folder permissions for %folderPath%...

icacls "%folderPath%" /grant "%groupName%:(OI)(CI)M" /T
icacls "%folderPath%" /setowner "%groupName%" /T

echo Folder permissions set successfully.



set "folderPath=C:\ShareFolder\Logistik"
set "groupName=Logistik_dl"

echo Setting folder permissions for %folderPath%...

icacls "%folderPath%" /grant "%groupName%:(OI)(CI)M" /T
icacls "%folderPath%" /setowner "%groupName%" /T

echo Folder permissions set successfully.



setlocal

set "folderPath=C:\ShareFolder\IT
set "groupName=CORP135.com\IT_dl"

echo Setting folder permissions for %folderPath%...

icacls "%folderPath%" /grant "%groupName%:(OI)(CI)M" /T
icacls "%folderPath%" /setowner "%groupName%" /T

echo Folder permissions set successfully.

endlocal


setlocal

set "folderPath=C:\ShareFolder\Ledelse
set "groupName=CORP135.com\Ledelse_dl"

echo Setting folder permissions for %folderPath%...

icacls "%folderPath%" /grant "%groupName%:(OI)(CI)M" /T
icacls "%folderPath%" /setowner "%groupName%" /T

echo Folder permissions set successfully.

endlocal

setlocal

set "folderPath=C:\ShareFolder\Salg
set "groupName=CORP135.com\Salg_dl"

echo Setting folder permissions for %folderPath%...

icacls "%folderPath%" /grant "%groupName%:(OI)(CI)M" /T
icacls "%folderPath%" /setowner "%groupName%" /T

echo Folder permissions set successfully.

endlocal


pause