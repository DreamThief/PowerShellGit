<<<<<<< HEAD
﻿function get-dellTagInfo {  #lineBreak
    param  ($svcTag) #lineBreak
    $url = "https://api.dell.com/support/v2/assetinfo/warranty/tags.xml?svctags=" + $svcTag + "&apikey=849e027f476027a394edd656eaef4842" #lineBreak
    Invoke-WebRequest -Uri $url | Select-Object -ExpandProperty content | Out-File .\"$svctag".dell.xml #lineBreak
    [xml]$xml = Get-Content .\"$svctag".dell.xml #lineBreak
    write-host "Service tag:" $xml.GetAssetWarrantyResponse.GetAssetWarrantyResult.Response.DellAsset.ServiceTag #lineBreak
    write-host "ShipDate:" $xml.GetAssetWarrantyResponse.GetAssetWarrantyResult.Response.DellAsset.ShipDate #lineBreak
    write-host "ModelInfo:" $xml.GetAssetWarrantyResponse.GetAssetWarrantyResult.Response.DellAsset.MachineDescription #lineBreak
    write-host "Warranty End Date:" $xml.GetAssetWarrantyResponse.GetAssetWarrantyResult.Response.DellAsset.Warranties.Warranty[1].EndDate #lineBreak
    write-host "Warranty Service Levels:"  #lineBreak
    write-host "-----" $xml.GetAssetWarrantyResponse.GetAssetWarrantyResult.Response.DellAsset.Warranties.Warranty[0].ServiceLevelDescription #lineBreak
    write-host "-----" $xml.GetAssetWarrantyResponse.GetAssetWarrantyResult.Response.DellAsset.Warranties.Warranty[1].ServiceLevelDescription #lineBreak
    write-host "-----" $xml.GetAssetWarrantyResponse.GetAssetWarrantyResult.Response.DellAsset.Warranties.Warranty[2].ServiceLevelDescription #lineBreak
    write-host "-----" $xml.GetAssetWarrantyResponse.GetAssetWarrantyResult.Response.DellAsset.Warranties.Warranty[3].ServiceLevelDescription #lineBreak
    write-host "-----" $xml.GetAssetWarrantyResponse.GetAssetWarrantyResult.Response.DellAsset.Warranties.Warranty[4].ServiceLevelDescription #lineBreak
    write-host "-----" $xml.GetAssetWarrantyResponse.GetAssetWarrantyResult.Response.DellAsset.Warranties.Warranty[5].ServiceLevelDescription #lineBreak
} #lineBreak
=======
function get-dellTagInfo {  
    param  ($svcTag) 
    $url = "https://api.dell.com/support/v2/assetinfo/warranty/tags.xml?svctags=" + $svcTag + "&apikey=849e027f476027a394edd656eaef4842" 
    try {
    Invoke-WebRequest -Uri $url | Select-Object -ExpandProperty content | Out-File .\"$svctag".dell.xml 
    [xml]$xml = Get-Content .\"$svctag".dell.xml 
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
    Catch {
    Write-host "Could not find the service tag $svctag inside the Dell API"
    }     
    }
>>>>>>> 7603aeb002bd894450e0c7b5ff77fb5e42b166c5
