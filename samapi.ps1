# Setup

# Get Windows culture data to process country codes
$AllCultures = [System.Globalization.CultureInfo]::GetCultures([System.Globalization.CultureTypes]::SpecificCultures) # !AllCultures

foreach ($Culture in $AllCultures) {
    $RegionInfo = new-object System.Globalization.RegionInfo $Culture.Name
    $CountryObj = [PSCustomObject]@{
        Name = $RegionInfo.EnglishName
        TwoLetterISORegionName = $RegionInfo.TwoLetterISORegionName
    }
    [array]$countryCodes += $CountryObj
}

$countryCodes | Select-Object -Unique -Property TwoLetterISORegionName, Name | ForEach-Object {
    $countryISO += @{$_.Name = $_.TwoLetterISORegionName }
}

#construct request object
[pscustomobject]$request = @{
    "TenantId" = "global-azure-2024"
    "Events" = @()
}

#$samJson = '{"Name": "","EventDate": "","EventLocation": "","Coordinates": {"Latitude": 0,"Longitude": 0},"AdditionalHosts": [""],"Description": "","SessionizeApiKey": "z","SessionizeEventName": "","InfoPageContentMarkdown": "","SponsorPageContentMarkdown": ""}'


# Get our folders
$folders = Get-ChildItem -Directory -Path ".\2024"

foreach ($folder in $folders) {

    Write-Host "Processing $($folder.Name)"
    # Construct event object
    #$samEvent = $samJson | ConvertFrom-Json
    $samEvent = @{
        "Name" = ""
        "EventDate" = ""
        "EventLocation" = ""
        "Coordinates" = @{
            "Latitude" = 0
            "Longitude" = 0
        }
        "AdditionalHosts" = @("9ba9dec5-3e4b-469c-ab17-1af4d86e4fcd","bda556d2-8d3c-4bd4-8c82-86461e5c8ae4")
        "Description" = ""
        "SessionizeApiKey" = ""
        "SessionizeEventName" = ""
        "InfoPageContentMarkdown" = ""
        "SponsorPageContentMarkdown" = ""
    }

    $dataFile = Join-Path -Path $folder.FullName -ChildPath "data.json"
    if (test-path $dataFile) {
        $globalAzureEvent = Get-Content -Path $dataFile -Raw | ConvertFrom-Json
    }

    $infoFile = Join-Path -Path $folder.FullName -ChildPath "index.md"
    if (test-path $infoFile) {
        $infoMarkdown = Get-Content -Path $infoFile -raw
    }

    $sponsorFile = Join-Path -Path $folder.FullName -ChildPath "sponsor.md"
    if (test-path $sponsorFile) {
        $sponsorMarkdown = Get-Content -Path $sponsorFile -raw
    }

    if ($globalAzureEvent.CommunityInfo.SessionizeApiId) {
        $samEvent.Name = $globalAzureEvent.CommunityInfo.Name
        # set date as no date info yet
        $samEvent.EventDate = "2024-04-18"
        $samEvent.EventLocation = $countryISO[$globalAzureEvent.CommunityInfo.Country]
        $samEvent.Coordinates.Latitude = $globalAzureEvent.CommunityInfo.Locations[0].Latitude
        $samEvent.Coordinates.Longitude = $globalAzureEvent.CommunityInfo.Locations[0].Longitude
        if ($infoMarkdown) {
            $samEvent.InfoPageContentMarkdown = $infoMarkdown
        }
        if ($sponsorMarkdown) {
            $samEvent.SponsorPageContentMarkdown = $sponsorMarkdown
        }
        $samEvent.SessionizeApiKey = $globalAzureEvent.CommunityInfo.SessionizeApiId
        $samEvent.SessionizeEventName = $globalAzureEvent.CommunityInfo.SessionizeEventName

        $request.Events += $samEvent
    }
}

Write-Host "Processed folders"

$authheader = "ApiKey RIK.HEPWORTH@GMAIL.COM:MT2RW5H5QERVRVEIGCYDUNJ3EJ5TN6EP"
$samApiUrl = "https://e-staging-api.samsaidyes.com/api/automation/events?api-version=1.0"

$requestBody = $request | ConvertTo-Json -Depth 3

$requestBody | clip.exe

$response = Invoke-RestMethod -Uri $samApiUrl -Method Post -Headers @{'Authorization' = $authheader} -Body $requestBody -ContentType "application/json"

$response