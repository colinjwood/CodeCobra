 <#
        This script prompt creates a new site collection in your Office 365 tenant
        The user is prompted for the SharePoint Site Collection url, Site Owner and TimeZone of the newly created
        Site Collection and the site template used is the team site.
        These values could be hardcoded as well without prompting. 
#>

try {    
    Set-ExecutionPolicy Bypass -Scope Process

    $siteCollectionList = Import-Csv -Path "C:\temp\SiteCollections.csv"

    #Loop through csv and provision site collection from each csv entry
    foreach ($siteCollection in $siteCollectionList)
    {
        $SharePointUrl = $siteCollection.Url
        $SiteOwner = $siteCollection.Owner
        $Title = $siteCollection.Title
        $Template = $siteCollection.SiteTemplate
        $TimeZone = $siteCollection.TimeZone
        $TenantUrl = $siteCollection.TenantUrl

        #Create site collection based on values above
        Connect-pnpOnline -url $TenantUrl
        New-PnPTenantSite -Owner $SiteOwner -Title $Title -Url $SharePointUrl -Template 'STS#0' -TimeZone $TimeZone  
        

    }
    
}
catch {
    Write-Host $error[0].Message
}
