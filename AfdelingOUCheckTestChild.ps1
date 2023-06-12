# Import the Active Directory module
Import-Module ActiveDirectory

# Specify the name of the parent container
$parentContainer = "Afdelinger"

# Specify the distinguished name (DN) of the root of the domain
$rootDN = "DC=CHILD2,DC=corp135,DC=com"
#$rootDN = "DC=corp117,DC=com"

# Specify the search base DN
$searchBaseDN = "OU=$parentContainer,$rootDN"

# Create the AFDELING OU
New-ADOrganizationalUnit -Name $parentContainer -ProtectedFromAccidentalDeletion $false
Write-Host "OU '$parentContainer' created successfully."



#Create Ledelse in Afdeling
$ouLedelse = "Administration"

# Specify the distinguished name (DN) of the parent container
$parentContainerDN = "OU=$parentContainer,$rootDN"
    
# Create the OU within the parent container
#$ouPath = "$parentContainerDN"
New-ADOrganizationalUnit -Name $ouLedelse -Path $parentContainerDN -ProtectedFromAccidentalDeletion $false
Write-Host "OU '$ouLedelse' created successfully."



#Create Salg in Afdeling
$ouSalg = "Kantine"

# Specify the distinguished name (DN) of the parent container
$parentContainerDN = "OU=$parentContainer,$rootDN"
    
# Create the OU within the parent container
#$ouPath = "$parentContainerDN"
New-ADOrganizationalUnit -Name $ouSalg -Path $parentContainerDN -ProtectedFromAccidentalDeletion $false
Write-Host "OU '$ouSalg' created successfully."



#Create IT in Afdeling
$ouIT = "Logistik"

# Specify the distinguished name (DN) of the parent container
$parentContainerDN = "OU=$parentContainer,$rootDN"
    
# Create the OU within the parent container
#$ouPath = "$parentContainerDN"
New-ADOrganizationalUnit -Name $ouIT -Path $parentContainerDN -ProtectedFromAccidentalDeletion $false
Write-Host "OU '$ouIT' created successfully."





########
#Grupper



#Create gruppe in Root
$parentGroupContainer = "Child2Grupper"
New-ADOrganizationalUnit -Name $parentGroupContainer -ProtectedFromAccidentalDeletion $false
Write-Host "OU '$parentGroupContainer' created successfully."





#Create GlobalGrupper in afdGrupper
$ouGloablGruppe = "ChildGlobalGrupper"

# Specify the distinguished name (DN) of the parent container
$parentContainerDNG = "OU=$parentGroupContainer,$rootDN"
    
# Create the OU within the parent container
#$ouPath = "$parentContainerDN"
New-ADOrganizationalUnit -Name $ouGloablGruppe -Path $parentContainerDNG -ProtectedFromAccidentalDeletion $false
Write-Host "OU '$ouGloablGruppe' created successfully."





#Create DomainLocalGruppe in afdGrupper
$ouDomainLocalGruppe = "ChildDomainLocalGrupper"

# Specify the distinguished name (DN) of the parent container
$parentContainerDNDL = "OU=$parentGroupContainer,$rootDN"
    
# Create the OU within the parent container
#$ouPath = "$parentContainerDN"
New-ADOrganizationalUnit -Name $ouDomainLocalGruppe -Path $parentContainerDNDL -ProtectedFromAccidentalDeletion $false
Write-Host "OU '$ouDomainLocalGruppe' created successfully."





# Specify the group details
$groupName = "Logistik_G"
$groupSamAccountName = "Logistik_G"
$globalgruppepath = "Ou=$ouGloablGruppe,$parentContainerDNG"

# Create the group
New-ADGroup -Name $groupName -SamAccountName $groupSamAccountName -GroupCategory Security -GroupScope Global -Path $globalgruppepath

Write-Host "Group '$groupName' created successfully."


# Specify the group details
$groupName = "Kantine_G"
$groupSamAccountName = "Kantine_G"
$globalgruppepath = "Ou=$ouGloablGruppe,$parentContainerDNG"

# Create the group
New-ADGroup -Name $groupName -SamAccountName $groupSamAccountName -GroupCategory Security -GroupScope Global -Path $globalgruppepath

Write-Host "Group '$groupName' created successfully."

# Specify the group details
$groupName = "Administration_G"
$groupSamAccountName = "Administration_G"
$globalgruppepath = "Ou=$ouGloablGruppe,$parentContainerDNG"

# Create the group
New-ADGroup -Name $groupName -SamAccountName $groupSamAccountName -GroupCategory Security -GroupScope Global -Path $globalgruppepath

Write-Host "Group '$groupName' created successfully."

##

# Specify the group details
$groupName = "Logistik_DL"
$groupSamAccountName = "Logistik_DL"
$globalgruppepath = "Ou=$ouDomainLocalGruppe,$parentContainerDNG"

# Create the group
New-ADGroup -Name $groupName -SamAccountName $groupSamAccountName -GroupCategory Security -GroupScope DomainLocal -Path $globalgruppepath

Write-Host "Group '$groupName' created successfully."

$groupName = "Administration_DL"
$groupSamAccountName = "Administration_DL"
$globalgruppepath = "Ou=$ouDomainLocalGruppe,$parentContainerDNG"

# Create the group
New-ADGroup -Name $groupName -SamAccountName $groupSamAccountName -GroupCategory Security -GroupScope DomainLocal -Path $globalgruppepath

Write-Host "Group '$groupName' created successfully."


$groupName = "Kantine_DL"
$groupSamAccountName = "Kantine_DL"
$globalgruppepath = "Ou=$ouDomainLocalGruppe,$parentContainerDNG"

# Create the group
New-ADGroup -Name $groupName -SamAccountName $groupSamAccountName -GroupCategory Security -GroupScope DomainLocal -Path $globalgruppepath

Write-Host "Group '$groupName' created successfully."




###################
#Users


# Specify the user details to Kantine
$firstName = "Karl"
$lastName = "Karlson"
$username = "Kaka"
$password = ConvertTo-SecureString "Passw0rd" -AsPlainText -Force
$ouPath = "OU=Kantine,OU=Afdelinger,DC=CHILD2,DC=corp135,DC=com"  # Specify the desired OU path for the user

# Create the user
New-ADUser -SamAccountName $username -GivenName $firstName -Surname $lastName -UserPrincipalName "$username@child.corp135.com" -Name "$firstName $lastName" -Enabled $true -PasswordNeverExpires $true -AccountPassword $password -Path $ouPath

Write-Host "User '$username' created successfully."



###Add User to G Gruppe

# Specify the user and group details
$groupGlobalName = "Kantine_G"  # Name of the group

# Add the user to the group
Add-ADGroupMember -Identity $groupGlobalName -Members $username



##Add G to DL ONLY TO BE RUN ONCE !
 
# Specify the user and group details
$groupDomainLocalName = "Kantine_DL"  # Name of the group

# Add the user to the group
Add-ADGroupMember -Identity $groupDomainLocalName -Members $groupGlobalName

### Code ABOVE ONLY TO BE RUN ONCE !



# Add Jane Doe as user and Kantine group
$firstName = "Karla"
$lastName = "Karlsen"
$username = "KarKar"
$password = ConvertTo-SecureString "Passw0rd" -AsPlainText -Force
$ouPath = "OU=Kantine,OU=Afdelinger,DC=CHILD2,DC=corp135,DC=com"

# Create the user
New-ADUser -SamAccountName $username -GivenName $firstName -Surname $lastName -UserPrincipalName "$username@child.corp135.com" -Name "$firstName $lastName" -Enabled $true -PasswordNeverExpires $true -AccountPassword $password -Path $ouPath

Write-Host "User '$username' created successfully."

###Add User to G Gruppe
# Specify the user and group details
$groupGlobalName = "Kantine_G"  # Name of the group

# Add the user to the group
Add-ADGroupMember -Identity $groupGlobalName -Members $username
# END Jane Doe

###

# Add Ib Itsen as user and Administration group
$firstName = "Arne"
$lastName = "Aarup"
$username = "ArAa"
$password = ConvertTo-SecureString "Passw0rd" -AsPlainText -Force
$ouPath = "OU=Administration,OU=Afdelinger,DC=CHILD2,DC=corp135,DC=com"  # Specify the desired OU path for the user

# Create the user
New-ADUser -SamAccountName $username -GivenName $firstName -Surname $lastName -UserPrincipalName "$username@child.corp135.comm" -Name "$firstName $lastName" -Enabled $true -PasswordNeverExpires $true -AccountPassword $password -Path $ouPath

Write-Host "User '$username' created successfully."

###Add User to G Gruppe
# Specify the user and group details
$groupGlobalName = "Administration_G"  # Name of the group

# Add the user to the group
Add-ADGroupMember -Identity $groupGlobalName -Members $username
# END Ib Itsen

##Add G to DL ONLY TO BE RUN ONCE !
 
# Specify the user and group details
$groupDomainLocalName = "Administration_DL"  # Name of the group

# Add the user to the group
Add-ADGroupMember -Identity $groupDomainLocalName -Members $groupGlobalName

### Code ABOVE ONLY TO BE RUN ONCE !


###

# Add Ivar Itson as user and Administration group
$firstName = "Albert"
$lastName = "Einstein"
$username = "AlEi"
$password = ConvertTo-SecureString "Passw0rd" -AsPlainText -Force
$ouPath = "OU=Administration,OU=Afdelinger,DC=CHILD2,DC=corp135,DC=com" # Specify the desired OU path for the user

# Create the user
New-ADUser -SamAccountName $username -GivenName $firstName -Surname $lastName -UserPrincipalName "$username@child.corp135.com" -Name "$firstName $lastName" -Enabled $true -PasswordNeverExpires $true -AccountPassword $password -Path $ouPath

Write-Host "User '$username' created successfully."

###Add User to G Gruppe
# Specify the user and group details
$groupGlobalName = "Administration_G"  # Name of the group

# Add the user to the group
Add-ADGroupMember -Identity $groupGlobalName -Members $username
# END Ivar Itson

###

# Add user in Logistik group
$firstName = "Lars"
$lastName = "Larsen"
$username = "LaLa"
$password = ConvertTo-SecureString "Passw0rd" -AsPlainText -Force
$ouPath = "OU=Logistik,OU=Afdelinger,DC=CHILD2,DC=corp135,DC=com" # Specify the desired OU path for the user

# Create the user
New-ADUser -SamAccountName $username -GivenName $firstName -Surname $lastName -UserPrincipalName "$username@child2.corp135.com" -Name "$firstName $lastName" -Enabled $true -PasswordNeverExpires $true -AccountPassword $password -Path $ouPath

Write-Host "User '$username' created successfully."

###Add User to G Gruppe
# Specify the user and group details
$groupGlobalName = "Logistik_G"  # Name of the group

# Add the user to the group
Add-ADGroupMember -Identity $groupGlobalName -Members $username
# END Søren Sørensen

##Add G to DL ONLY TO BE RUN ONCE !
 
# Specify the user and group details
$groupDomainLocalName = "Logistik_DL"  # Name of the group

# Add the user to the group
Add-ADGroupMember -Identity $groupDomainLocalName -Members $groupGlobalName

### Code ABOVE ONLY TO BE RUN ONCE !


###

# Add Steen Steensen as user and Logistik group
$firstName = "Lone"
$lastName = "Lonesome"
$username = "LoLo"
$password = ConvertTo-SecureString "Passw0rd" -AsPlainText -Force
$ouPath = "OU=Kantine,OU=Afdelinger,DC=CHILD2,DC=corp135,DC=com"  # Specify the desired OU path for the user

# Create the user
New-ADUser -SamAccountName $username -GivenName $firstName -Surname $lastName -UserPrincipalName "$username@child2.corp135.com" -Name "$firstName $lastName" -Enabled $true -PasswordNeverExpires $true -AccountPassword $password -Path $ouPath

Write-Host "User '$username' created successfully."

###Add User to G Gruppe
# Specify the user and group details
$groupGlobalName = "Logistik_G"  # Name of the group

# Add the user to the group
Add-ADGroupMember -Identity $groupGlobalName -Members $username
# END Steen Steensen

### End of users 

