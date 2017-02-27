function get-dellTagInfo {  
    param  ($svcTag) 
    $url = "https://api.dell.com/support/v2/assetinfo/warranty/tags.xml?svctags=" + $svcTag + "&apikey=849e027f476027a394edd656eaef4842" 
   # $dellContent = try {
   try {
           [xml]$xml = Invoke-WebRequest -Uri $url | Select-Object -ExpandProperty content # | Out-File .\"$svctag".dell.xml 
        }
    Catch {
    Write-host "Could not find the service tag $svctag inside the Dell API"
    Write-host "XML Message:" $xml.GetAssetWarrantyResponse.GetAssetWarrantyResult.Faults.FaultException.Message
            }
    if ($xml.GetAssetWarrantyResponse.GetAssetWarrantyResult.Faults.FaultException.Message -eq $null) {
        write-host "Service tag:" $xml.GetAssetWarrantyResponse.GetAssetWarrantyResult.Response.DellAsset.ServiceTag 
        write-host "ShipDate:" $xml.GetAssetWarrantyResponse.GetAssetWarrantyResult.Response.DellAsset.ShipDate 
        write-host "ModelInfo:" $xml.GetAssetWarrantyResponse.GetAssetWarrantyResult.Response.DellAsset.MachineDescription 
        write-host "Warranty End Date:" $xml.GetAssetWarrantyResponse.GetAssetWarrantyResult.Response.DellAsset.Warranties.Warranty[1].EndDate 
        write-host "Warranty Service Levels:"  
        write-host "-----" $xml.GetAssetWarrantyResponse.GetAssetWarrantyResult.Response.DellAsset.Warranties.Warranty[0].ServiceLevelDescription 
        write-host "-----" $xml.GetAssetWarrantyResponse.GetAssetWarrantyResult.Response.DellAsset.Warranties.Warranty[1].ServiceLevelDescription 
        write-host "-----" $xml.GetAssetWarrantyResponse.GetAssetWarrantyResult.Response.DellAsset.Warranties.Warranty[2].ServiceLevelDescription 
        write-host "-----" $xml.GetAssetWarrantyResponse.GetAssetWarrantyResult.Response.DellAsset.Warranties.Warranty[3].ServiceLevelDescription 
        write-host "-----" $xml.GetAssetWarrantyResponse.GetAssetWarrantyResult.Response.DellAsset.Warranties.Warranty[4].ServiceLevelDescription 
        write-host "-----" $xml.GetAssetWarrantyResponse.GetAssetWarrantyResult.Response.DellAsset.Warranties.Warranty[5].ServiceLevelDescription 
        } 
        else { 
                write-host ""
                write-host -fore red "XML Message: " -nonewline; write-host  $xml.GetAssetWarrantyResponse.GetAssetWarrantyResult.Faults.FaultException.Message  }
    } 