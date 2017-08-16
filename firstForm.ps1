#ERASE ALL THIS AND PUT XAML BELOW between the @" "@
$inputXML = @"
<Window x:Class="WpfApplication2.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApplication2"
        mc:Ignorable="d"
        Title="FoxDeploy Awesome Tool" Height="670.572" Width="598.474" Topmost="True">
    <Grid Margin="0,0,45,0">
        <Image x:Name="image" HorizontalAlignment="Left" Height="100" Margin="24,28,0,0" VerticalAlignment="Top" Width="100" Source="C:\Users\Casteel\Pictures\Saved Pictures\Old_rebpulic_.jpg"/>
        <TextBlock x:Name="textBlock" HorizontalAlignment="Left" Height="100" Margin="174,28,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="282" FontSize="16"><Run Text="Use this tool to find out all sorts of useful disk information, and also to get rich input from your scripts and tools"/><InlineUIContainer>
                <TextBlock x:Name="textBlock1" TextWrapping="Wrap" Text="TextBlock"/>
            </InlineUIContainer></TextBlock>
        <Button x:Name="button" Content="get-DiskInfo" HorizontalAlignment="Left" Height="35" Margin="393,144,0,0" VerticalAlignment="Top" Width="121" FontSize="18.667"/>
        <Button x:Name="close" Content="Close" HorizontalAlignment="Left" Margin="460,610,0,0" VerticalAlignment="Top" Width="75"/>
        <Button x:Name="getUser" Content="GetLocalUser" HorizontalAlignment="Left" Margin="460,447,0,0" VerticalAlignment="Top" Width="75"/>
        <TextBox x:Name="textBox" HorizontalAlignment="Left" Height="35" Margin="186,144,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="168" FontSize="16"/>
        <Label x:Name="label" HorizontalAlignment="Left" Height="46" Margin="24,144,0,0" VerticalAlignment="Top" Width="138" FontSize="16">
            <Label Content="Label"/>
        </Label>
        <ListView x:Name="listView" HorizontalAlignment="Left" Height="201" Margin="24,195,0,0" VerticalAlignment="Top" Width="511" FontSize="16">
            <ListView.View>
                <GridView>
                    <GridViewColumn Header="Drive Letter" DisplayMemberBinding ="{Binding 'Drive Letter'}" Width="120"/>
                    <GridViewColumn Header="Drive Label" DisplayMemberBinding ="{Binding 'Drive Label'}" Width="120"/>
                    <GridViewColumn Header="Size(MB)" DisplayMemberBinding ="{Binding Size(MB)}" Width="120"/>
                    <GridViewColumn Header="FreeSpace%" DisplayMemberBinding ="{Binding FreeSpace%}" Width="120"/>
                </GridView>
            </ListView.View>
        </ListView>

        <TextBox x:Name="userbox" HorizontalAlignment="Left" Height="23" Margin="335,444,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="120"/>
        <Label x:Name="USer" Content="Enter a username" HorizontalAlignment="Left" Height="23" Margin="215,444,0,0" VerticalAlignment="Top" Width="115"/>
        
        <ListView x:Name="UserName" HorizontalAlignment="Left" Height="93" Margin="24,512,0,0" VerticalAlignment="Top" Width="511">
            <ListView.View>
                <GridView>
                    <GridViewColumn Header="FullName" DisplayMemberBinding ="{Binding 'Name'}" Width="120"/>
                    <GridViewColumn Header="Description" DisplayMemberBinding ="{Binding 'Description'}" Width="120"/>
                    <GridViewColumn Header="Enabled" DisplayMemberBinding ="{Binding 'Enabled'}" Width="120"/>
                    <GridViewColumn Header="LastPWChange" DisplayMemberBinding ="{Binding 'LastPWChange'}" Width="120"/>
                </GridView>
            </ListView.View>
        </ListView>



    </Grid>
</Window>
 
"@       
 
$inputXML = $inputXML -replace 'mc:Ignorable="d"','' -replace "x:N",'N'  -replace '^<Win.*', '<Window'
 
[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
[xml]$XAML = $inputXML
#Read XAML
 
    $reader=(New-Object System.Xml.XmlNodeReader $xaml)
  try{$Form=[Windows.Markup.XamlReader]::Load( $reader )}
catch{Write-Host "Unable to load Windows.Markup.XamlReader. Double-check syntax and ensure .net is installed."}
 
#===========================================================================
# Store Form Objects In PowerShell
#===========================================================================
 
$xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name "WPF$($_.Name)" -Value $Form.FindName($_.Name)}
 
Function Get-FormVariables{
if ($global:ReadmeDisplay -ne $true){Write-host "If you need to reference this display again, run Get-FormVariables" -ForegroundColor Yellow;$global:ReadmeDisplay=$true}
write-host "Found the following interactable elements from our form" -ForegroundColor Cyan
get-variable WPF*
}
 
Get-FormVariables
 
#===========================================================================
# Actually make the objects work
#===========================================================================
 
Function Get-DiskInfo {
param($computername =$env:COMPUTERNAME)
 
Get-WMIObject Win32_logicaldisk -ComputerName $computername | Select-Object @{Name='ComputerName';Ex={$computername}},`
                                                                    @{Name=‘Drive Letter‘;Expression={$_.DeviceID}},`
                                                                    @{Name=‘Drive Label’;Expression={$_.VolumeName}},`
                                                                    @{Name=‘Size(MB)’;Expression={[int]($_.Size / 1MB)}},`
                                                                    @{Name=‘FreeSpace%’;Expression={[math]::Round($_.FreeSpace / $_.Size,2)*100}}
                                                                 }
 
function get-LUser {
param($username = $env:USERNAME)

    get-localuser $username | select @{Name='Name';Ex={$_.fullname}},`
                                     @{Name='Description';Ex={$_.description}},`
                                     @{Name='Enabled';Ex={$_.enabled}},`
                                     @{Name='LastPWChange';Ex={$_.passwordlastset}}
}

$WPFuserbox.Text = $env:USERNAME
$WPFtextBox.Text = $env:COMPUTERNAME

$WPFgetUser.Add_Click({
Get-LUser  $WPFuserbox.Text  | % {$WPFusername.AddChild($_)}
})
 
$WPFbutton.Add_Click({
Get-DiskInfo -computername $WPFtextBox.Text | % {$WPFlistView.AddChild($_)}
})

$WPFclose.Add_Click({$form.Close()})

#Sample entry of how to add data to a field
 
#$vmpicklistView.items.Add([pscustomobject]@{'VMName'=($_).Name;Status=$_.Status;Other="Yes"})
 
#===========================================================================
# Shows the form
#===========================================================================
write-host "To show the form, run the following" -ForegroundColor Cyan
'$Form.ShowDialog() | out-null'