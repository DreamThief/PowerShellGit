Add-Type -AssemblyName System.Windows.Forms

#$bootime = (Get-WmiObject -Class win32_operatingsystem).ConverttoDateTime((Get-WmiObject -Class win32_Operatingsystem).LastBootUpTime)

	$buttonGetUptime_Click={
#		$Getdata = Get-ADUser -server $glserver -Credential $creds -identity "sandy.stoner" -properties * 
        $getdata = get-testuser $textBox3.Text                   
		$label2.Text = "name:" + $getdata.name + "`r`n", ` 
                    "passwordexpired:" + $getdata.passwordexpired + "`r`n", ` 
                    "description:" + $getdata.description + "`r`n", ` 
                    "office:" + $getdata.office + "`r`n", ` 
                    "proxyaddresses:" + $getdata.proxyaddresses + "`r`n", ` 
                    "employeeType:" + $getdata.employeeType + "`r`n", `
                    "UserPrincipalName:" + $getdata.UserPrincipalName + "`r`n", ` 
                    "homedirectory:" + $getdata.homedirectory + "`r`n", ` `
                    "passwordlastset:" + $getdata.passwordlastset + "`r`n", ` 
                    "telephoneNumber:" + $getdata.telephoneNumber + "`r`n", ` 
                    "mobile:" + $getdata.mobile + "`r`n", ` 
                    "passwordneverexpires:" + $getdata.passwordneverexpires + "`r`n", ` 
                    "whenCreated:" + $getdata.whenCreated + "`r`n", `
                    "AccountExpirationDate:" + $getdata.AccountExpirationDate + "`r`n", `
                    "employeeID:" + $getdata.employeeID + "`r`n", ` 
                    "manager:" + $getdata.manager + "`r`n", ` 
                    "title:" + $getdata.title + "`r`n", ` 
                    "mail:" + $getdata.mail + "`r`n", ` 
                    "adminCount:" + $getdata.adminCount + "`r`n", ` 
                    "lockedout:" + $getdata.lockedout + "`r`n", ` 
                    "department:" + $getdata.department + "`r`n", `
                    "accountexpires:" + $getdata.accountexpires + "`r`n", `
                    "lastLogon:" + $getdata.lastLogon + "`r`n", ` 
                    "CanonicalName:" + $getdata.CanonicalName + "`r`n" `
                     

              

	}

$Form = New-Object system.Windows.Forms.Form
$Form.Text = 'Get-Uptime'
$Form.Width = 500
$Form.Height = 600

$textBox3 = New-Object system.windows.Forms.TextBox
$textBox3.Width = 100
$textBox3.Height = 20
$textBox3.Text = "username"
$textBox3.location = new-object system.drawing.point(10,50)
$textBox3.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox3)


$label2 = New-Object system.windows.Forms.Label
$label2.AutoSize = $true
$label2.Width = 25
$label2.Height = 10
$label2.location = new-object system.drawing.size(71,89)
$label2.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($label2)

$button4 = New-Object system.windows.Forms.Button
$button4.add_Click($buttonGetUptime_Click)
$button4.Text = 'Get UserInfo'
$button4.Width = 100
$button4.Height = 30
$button4.location = new-object system.drawing.size(15,15)
$button4.Font = "Microsoft Sans Serif,10"
$button4.AutoEllipsis
$Form.controls.Add($button4)

$Form.ShowDialog()