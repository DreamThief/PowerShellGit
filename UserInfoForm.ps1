Add-Type -AssemblyName System.Windows.Forms

#https://technet.microsoft.com/en-us/library/ff730941.aspx
#https://msdn.microsoft.com/en-us/library/gg580944(v=vs.85).aspx

	$buttonGetUptime_Click={
#		$Getdata = Get-ADUser -server $glserver -Credential $creds -identity "sandy.stoner" -properties * 
        $getdata = get-testuser $textBox3.Text  
                         
		$label2.Text = "name           :" + $getdata.name 
        $label3.Text = "passwordexpired:" + $getdata.passwordexpired 
        $label4.Text = "description    :" + $getdata.description ` 
        $label5.Text = "office:" + $getdata.office  
        $label6.Text = "whenCreated:" + $getdata.whenCreated
        $label7.Text =  "title:" + $getdata.title  
        if ($getdata.admincount -eq 1 ) {
        ($label8.Text =  "This is an admin account!") -and ($label8.ForeColor = "#ff0005")           }

                     

              

	}

$Form = New-Object system.Windows.Forms.Form
$Form.Text = 'Get-Uptime'
$Form.Width = 500
$Form.Height = 600
$Form.StartPosition = "CenterScreen"

$textBox3 = New-Object system.windows.Forms.TextBox
$textBox3.Width = 100
$textBox3.Height = 20
$textBox3.Text = "Sandy.Stoner"
$textBox3.location = new-object system.drawing.point(10,50)
$textBox3.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBox3)


$label2 = New-Object system.windows.Forms.Label
$label2.AutoSize = $true
$label2.Width = 25
$label2.Height = 10
$label2.location = new-object system.drawing.size(10,90)
$Form.controls.Add($label2)

####
$label3 = New-Object system.windows.Forms.Label
$label3.AutoSize = $true
 $label3.Text = "passwordexpired:"
$label3.Width = 25
$label3.Height = 10
$label3.location = new-object system.drawing.size(10,110)
$Form.controls.Add($label3)

$label4 = New-Object system.windows.Forms.Label
$label4.AutoSize = $true
$label4.Text = "description    :"
$label4.Width = 25
$label4.Height = 10
$label4.location = new-object system.drawing.size(10,130)
$Form.controls.Add($label4)

$label5 = New-Object system.windows.Forms.Label
$label5.AutoSize = $true
$label5.Text = "office:"
$label5.Width = 25
$label5.Height = 10
$label5.location = new-object system.drawing.size(10,150)
$Form.controls.Add($label5)

$label6 = New-Object system.windows.Forms.Label
$label6.AutoSize = $true
$label6.Text = "whenCreated:"
$label6.Width = 25
$label6.Height = 10
$label6.location = new-object system.drawing.size(10,170)
$Form.controls.Add($label6)

$label7 = New-Object system.windows.Forms.Label
$label7.AutoSize = $true
$label7.Text =  "title:"
$label7.Width = 25
$label7.Height = 10
$label7.location = new-object system.drawing.size(10,190)
$Form.controls.Add($label7)

$label8 = New-Object system.windows.Forms.Label
$label8.AutoSize = $true
#$label8.Text =  "Admin:"
$label8.Width = 25
$label8.Height = 10
$label8.location = new-object system.drawing.size(10,210)
if ($getdata.admincount -eq 1 )  {$Form.controls.Add($label8)} 

####



$button4 = New-Object system.windows.Forms.Button
$button4.add_Click($buttonGetUptime_Click)
$button4.Text = 'Get UserInfo'
$button4.Width = 100
$button4.Height = 30
$button4.location = new-object system.drawing.size(15,15)
$button4.Font = "Microsoft Sans Serif,10"
$button4.AutoEllipsis
$Form.controls.Add($button4)

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Size(115,15)
$CancelButton.Size = New-Object System.Drawing.Size(100,30)
$CancelButton.Text = "Cancel"
$CancelButton.Font = "Microsoft Sans Serif,10"
$CancelButton.Add_Click({$Form.Close()})
$Form.Controls.Add($CancelButton)

[void] $Form.ShowDialog()

<#
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
                    "CanonicalName:" + $getdata.CanonicalName + "`r`n" 
                    "proxyaddresses:" + $getdata.proxyaddresses
                    "employeeType:" + $getdata.employeeType 
#>