@echo off
set "rootDrive=C:\"

rem Create ShareFolder
md "%rootDrive%\ShareFolder"

rem Set security permissions for Authenticated Users
icacls "%rootDrive%\ShareFolder" /grant:r "Authenticated Users:(OI)(CI)F"

rem Share ShareFolder with Full Access for Authenticated Users
net share ShareFolder="%rootDrive%\ShareFolder" /grant:"Authenticated Users",full

rem Create folders inside ShareFolder
md "%rootDrive%\ShareFolder\IT"
md "%rootDrive%\ShareFolder\Salg"
md "%rootDrive%\ShareFolder\Ledelse"
md "%rootDrive%\ShareFolder\Administration"
md "%rootDrive%\ShareFolder\Logistik"
md "%rootDrive%\ShareFolder\Kantine"

echo ShareFolder and subfolders created successfully.

REM Set the folder path
set "folderPath=C:\ShareFolder"

REM Set the share name
set "shareName=SharedFolder"

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
