@echo off
setlocal enabledelayedexpansion

set "rootDrive=%SystemDrive%"

REM Create ShareFolder in the root drive
md "%rootDrive%\ShareFolder"
echo ShareFolder created in %rootDrive%

set "addFolder=Y"

:loop
if /i "%addFolder%"=="Y" (
    set /p "folderName=Enter the folder name (or 'N' to exit): "
    if /i "!folderName!"=="N" (
        set "addFolder=N"
    ) else (
        md "%rootDrive%\ShareFolder\!folderName!"
        echo Folder "!folderName!" created in ShareFolder
    )
    goto loop
)


REM Set the folder path
set "folderPath=C:\ShareFolder"

REM Set the share name
set "shareName=SharedFolder2"

REM Set the share description
set "shareDescription=Shared folder for authenticated users"

REM Set the username for removing "Everyone"
set "usernameToRemove=Everyone"

REM Create the share
net share %shareName%=%folderPath% /remark:"%shareDescription%" /grant:"Authenticated Users",FULL

REM Remove "Everyone" from the share permissions
icacls %folderPath% /remove "%usernameToRemove%" /inheritance:r

REM Display completion message
echo Share created and permissions updated successfully!
pause
