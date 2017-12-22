#$moduleList = @('AzureRM.Profile' , 'AzureRM.Resources' , 'Azure.Storage' , 'AzureRM.Storage' , 'AzureRmStorageTable')

$moduleList = @('AzureRM') # -AllowClobber

foreach ($mod in $modulelist)
            {Find-Module $mod | Install-Module }