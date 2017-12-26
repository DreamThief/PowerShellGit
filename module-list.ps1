#$moduleList = @('AzureRM.Profile' , 'AzureRM.Resources' , 'Azure.Storage' , 'AzureRM.Storage' , 'AzureRmStorageTable')

$moduleList = @(
                'AzureRM', 
                'posh-git' ,
                'vmxtoolkit'
                'EnhancedHTML2' ,
                'pester' ,
                'universaldashboard'

                ) 

foreach ($mod in $modulelist)
            {Find-Module $mod | Install-Module } # -AllowClobber