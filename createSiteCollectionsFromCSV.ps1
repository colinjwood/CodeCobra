 <#
        This script prompt loops through an imported csv file and creates a site collection for every entry 
#>

try {    
    Set-ExecutionPolicy Bypass -Scope Process

     #Prompt for Tenant url
    $TenantUrl = Read-Host -Prompt 'Enter your SharePoint online tenant url'
    Connect-pnpOnline -url $TenantUrl

    $siteCollectionList = Import-Csv -Path "C:\temp\SiteCollections.csv"

    #Loop through csv and provision site collection from each csv entry
    foreach ($siteCollection in $siteCollectionList)
    {
        $SharePointUrl = $siteCollection.Url
        $SiteOwner = $siteCollection.Owner
        $Title = $siteCollection.Title
        $Template = $siteCollection.SiteTemplate
        $TimeZone = $siteCollection.TimeZone       

        #Create site collection based on values above        
        New-PnPTenantSite -Owner $SiteOwner -Title $Title -Url $SharePointUrl -Template $Template -TimeZone $TimeZone  
    }    
}
catch {
    Write-Host $error[0].Message
}
