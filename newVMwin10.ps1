TRY
		{
			IF (-not (Get-Module -Name vmxtoolkit)) { Import-Module -Name vmxtoolkit -ErrorAction 'Stop' -Verbose:$false }
		}
		CATCH
		{
            write-host ""
			write-host "You do not have the vmxtoolkit loaded or available" -fore red
            write-host "Browse to https://github.com/bottkars/vmxtoolkit to laod it" -fore red
            Write-Verbose -Message "[BEGIN] Something wrong happened"
			Write-Verbose -Message $Error[0].Exception.Message
            write-host ""
		}

#Global variables are defined
#. .\modules\global.ps1
. c:\scripts\global.ps1

Function Get-FileName($initialDirectory)
{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "ISO (*.iso)| *.iso"
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.filename
}


$iso = get-filename $glisodir

new-vmx -vmxname MyWin10 -type server2016 -Firmware BIOS -Path $glVMdir |
    Set-VMXSize -size M|
	New-vmxscsidisk -newdisksize 20GB -newdiskname SCSI0_0 |
	add-vmxscsidisk -lun 0 -controller 0 |
	connect-vmxcdromimage -iso $iso |
	set-vmxnetworkadapter -adapter 0 -ConnectionType bridged -adaptertype e1000e |
	start-vmx -nowait


#>
#Reference 
# remove-vmx -VMXName mywin10 -config U:\Mywin10\Mywin10.vmx