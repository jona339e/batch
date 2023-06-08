# Import the Active Directory moduleImport-Module ActiveDirectory# Specify the name of the parent container$parentContainer = "Afdelinger"# Specify the distinguished name (DN) of the root of the domain#$rootDN = "DC=asd,DC=corp117,DC=com"$rootDN = "DC=corp117,DC=com"# Specify the search base DN$searchBaseDN = "OU=$parentContainer,$rootDN"# Create the AFDELING OUNew-ADOrganizationalUnit -Name $parentContainer -ProtectedFromAccidentalDeletion $falseWrite-Host "OU '$parentContainer' created successfully."#Create Ledelse in Afdeling$ouLedelse = "Ledelse"# Specify the distinguished name (DN) of the parent container$parentContainerDN = "OU=$parentContainer,$rootDN"    # Create the OU within the parent container#$ouPath = "$parentContainerDN"New-ADOrganizationalUnit -Name $ouLedelse -Path $parentContainerDN -ProtectedFromAccidentalDeletion $falseWrite-Host "OU '$ouLedelse' created successfully."#Create Salg in Afdeling$ouSalg = "Salg"# Specify the distinguished name (DN) of the parent container$parentContainerDN = "OU=$parentContainer,$rootDN"    # Create the OU within the parent container#$ouPath = "$parentContainerDN"New-ADOrganizationalUnit -Name $ouSalg -Path $parentContainerDN -ProtectedFromAccidentalDeletion $falseWrite-Host "OU '$ouSalg' created successfully."#Create IT in Afdeling$ouIT = "IT"# Specify the distinguished name (DN) of the parent container$parentContainerDN = "OU=$parentContainer,$rootDN"    # Create the OU within the parent container#$ouPath = "$parentContainerDN"New-ADOrganizationalUnit -Name $ouIT -Path $parentContainerDN -ProtectedFromAccidentalDeletion $falseWrite-Host "OU '$ouIT' created successfully."#Create gruppe in Root$parentGroupContainer = "afdGrupper"New-ADOrganizationalUnit -Name $parentGroupContainer -ProtectedFromAccidentalDeletion $falseWrite-Host "OU '$parentGroupContainer' created successfully."#Create GlobalGrupper in afdGrupper$ouGloablGruppe = "GlobalGrupper"# Specify the distinguished name (DN) of the parent container$parentContainerDNG = "OU=$parentGroupContainer,$rootDN"    # Create the OU within the parent container#$ouPath = "$parentContainerDN"New-ADOrganizationalUnit -Name $ouGloablGruppe -Path $parentContainerDNG -ProtectedFromAccidentalDeletion $falseWrite-Host "OU '$ouGloablGruppe' created successfully."#Create DomainLocalGruppe in afdGrupper$ouDomainLocalGruppe = "DomainLocalGrupper"# Specify the distinguished name (DN) of the parent container$parentContainerDNDL = "OU=$parentGroupContainer,$rootDN"    # Create the OU within the parent container#$ouPath = "$parentContainerDN"New-ADOrganizationalUnit -Name $ouDomainLocalGruppe -Path $parentContainerDNDL -ProtectedFromAccidentalDeletion $falseWrite-Host "OU '$ouDomainLocalGruppe' created successfully."#########Grupper# Specify the group details
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

