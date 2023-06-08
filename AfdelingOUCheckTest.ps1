﻿# Import the Active Directory module
$groupName = "IT_G"
$groupSamAccountName = "IT_G"
$globalgruppepath = "Ou=$ouGloablGruppe,$parentContainerDNG"

# Create the group
New-ADGroup -Name $groupName -SamAccountName $groupSamAccountName -GroupCategory Security -GroupScope Global -Path $globalgruppepath

Write-Host "Group '$groupName' created successfully."


# Specify the group details
$groupName = "Salg_G"
$groupSamAccountName = "Salg_G"
$globalgruppepath = "Ou=$ouGloablGruppe,$parentContainerDNG"

# Create the group
New-ADGroup -Name $groupName -SamAccountName $groupSamAccountName -GroupCategory Security -GroupScope Global -Path $globalgruppepath

Write-Host "Group '$groupName' created successfully."

# Specify the group details
$groupName = "Ledelse_G"
$groupSamAccountName = "Ledelse_G"
$globalgruppepath = "Ou=$ouGloablGruppe,$parentContainerDNG"

# Create the group
New-ADGroup -Name $groupName -SamAccountName $groupSamAccountName -GroupCategory Security -GroupScope Global -Path $globalgruppepath

Write-Host "Group '$groupName' created successfully."

##

# Specify the group details
$groupName = "IT_DL"
$groupSamAccountName = "IT_DL"
$globalgruppepath = "Ou=$ouDomainLocalGruppe,$parentContainerDNG"

# Create the group
New-ADGroup -Name $groupName -SamAccountName $groupSamAccountName -GroupCategory Security -GroupScope DomainLocal -Path $globalgruppepath

Write-Host "Group '$groupName' created successfully."

$groupName = "Salg_DL"
$groupSamAccountName = "Salg_DL"
$globalgruppepath = "Ou=$ouDomainLocalGruppe,$parentContainerDNG"

# Create the group
New-ADGroup -Name $groupName -SamAccountName $groupSamAccountName -GroupCategory Security -GroupScope DomainLocal -Path $globalgruppepath

Write-Host "Group '$groupName' created successfully."


$groupName = "Ledelse_DL"
$groupSamAccountName = "Ledelse_DL"
$globalgruppepath = "Ou=$ouDomainLocalGruppe,$parentContainerDNG"

# Create the group
New-ADGroup -Name $groupName -SamAccountName $groupSamAccountName -GroupCategory Security -GroupScope DomainLocal -Path $globalgruppepath

Write-Host "Group '$groupName' created successfully."




###################
#Users


# Specify the user details
$firstName = "John"
$lastName = "Johnson"
$username = "JoJo"
$password = ConvertTo-SecureString "Passw0rd" -AsPlainText -Force
$ouPath = "OU=Ledelse,OU=Afdelinger,DC=corp117,DC=com"  # Specify the desired OU path for the user

# Create the user
New-ADUser -SamAccountName $username -GivenName $firstName -Surname $lastName -UserPrincipalName "$username@corp117.com" -Name "$firstName $lastName" -Enabled $true -PasswordNeverExpires $true -AccountPassword $password -Path $ouPath

Write-Host "User '$username' created successfully."

###Add User to G Gruppe
# Specify the user and group details
$groupGlobalName = "Ledelse_G"  # Name of the group

# Add the user to the group
Add-ADGroupMember -Identity $groupGlobalName -Members $username

##Add G to DL 
# Specify the user and group details
$groupDomainLocalName = "Ledelse_DL"  # Name of the group

# Add the user to the group
Add-ADGroupMember -Identity $groupDomainLocalName -Members $groupGlobalName
