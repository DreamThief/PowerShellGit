function new-DTuser {
    $server = "dreamthief.co"
    $firstName  = read-host -Prompt "Input First name" # -promptcolor green
    $surName  = read-host -Prompt "Input Last name"
    $description = read-host "Enter a description"
    $city = read-host "Enter a city"
    $userName = $firstName + "." + $surName
    $displayName = $surname + ", " + $firstName
    Write-host "I will try and create a new account with this username: $username"
    Write-host "The display name will be: $displayName"
    
    $creds = Get-Credential

new-ADUser -Server $server `
    -Credential $creds `
        -name $userName `
        -givenName $firstName `
        -surname $surName `
        -displayName $displayName `
        -description $description `
        -city $city
    }

<#
all the listed properties for an AD User object
[-Name] <string> 
[-WhatIf] 
[-Confirm] 
[-AccountExpirationDate <datetime>] 
[-AccountNotDelegated <bool>] 
[-AccountPassword <securestring>]
[-AllowReversiblePasswordEncryption <bool>] 
[-AuthenticationPolicy <ADAuthenticationPolicy>]
[-AuthenticationPolicySilo <ADAuthenticationPolicySilo>]
[-AuthType {Negotiate | Basic}] 
[-CannotChangePassword <bool>] 
[-Certificates <X509Certificate[]>]
[-ChangePasswordAtLogon <bool>] 
[-City <string>]
[-Company <string>]
[-CompoundIdentitySupported <bool>] 
[-Country <string>][-Credential <pscredential>]
[-Department <string>] 
[-Description <string>]
[-DisplayName <string>] 
[-Division <string>] 
[-EmailAddress <string>] 
[-EmployeeID <string>] 
[-EmployeeNumber <string>] 
[-Enabled <bool>] 
[-Fax    <string>] 
[-GivenName <string>]
[-HomeDirectory <string>] 
[-HomeDrive <string>] 
[-HomePage <string>] 
[-HomePhone <string>] 
[-Initials <string>]
[-Instance <ADUser>] 
[-KerberosEncryptionType {None | DES | RC4 | AES128 | AES256}] 
[-LogonWorkstations <string>] 
[-Manager <ADUser>] 
[-MobilePhone    <string>] 
[-Office <string>] 
[-OfficePhone <string>] 
[-Organization <string>]
[-OtherAttributes <hashtable>] 
[-OtherName <string>] 
[-PassThru]
[-PasswordNeverExpires <bool>]
[-PasswordNotRequired <bool>] 
[-Path <string>] 
[-POBox <string>]
[-PostalCode <string>]
[-PrincipalsAllowedToDelegateToAccount <ADPrincipal[]>] 
[-ProfilePath <string>] 
[-SamAccountName <string>] 
[-ScriptPath <string>] 
[-Server <string>]
[-ServicePrincipalNames <string[]>] 
[-SmartcardLogonRequired <bool>] 
[-State <string>] 
[-StreetAddress <string>] 
[-Surname <string>]
[-Title <string>]
[-TrustedForDelegation <bool>] 
[-Type <string>]
[-UserPrincipalName <string>]  
[<CommonParameters>]


     #>