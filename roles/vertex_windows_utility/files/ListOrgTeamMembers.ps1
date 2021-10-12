<#Note: As of now for Git and AD access it is using my login.
We would need to swap with an SA for the AD and a bot on the GitHub account. 
"g&kf6jsfbnT+NuX_" | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString | Out-File "ADpass.txt"
"$@!l!n9Aw@y2DaY" | ConvertTo-SecureString -AsPlainText -Force | Conver\\10.10.48.22\cdrive\vertex\oseries\datatFrom-SecureString | Out-File "EmailPassword.txt"
#>

Set-ExecutionPolicy Unrestricted
Set-Location -Path C:\scripts
$scriptsDir = "C:\scripts"

sleep 5

$parametersJsonPath = Join-Path $PSScriptRoot 'parameters.json'
if (-not (Test-Path $parametersJsonPath)) {
    throw 'Please create a ''parameters.json'' file.'
}

$parameters = ConvertFrom-Json -InputObject (Get-Content -Raw -Path $parametersJsonPath)
$username = $parameters.UserName
$personalAccessToken = $parameters.PersonalAccessToken
$organizationName = $parameters.OrganizationName
$gitHubApiBaseUrl = $parameters.GitHubApiBaseUrl

$credential = [pscredential]::new($userName, ($personalAccessToken | ConvertTo-SecureString -AsPlainText -Force))

$users = @()
$teams = @()

function Get-GitHubUser {
    param (
        [string]$username
    )

    $uri = "$gitHubApiBaseUrl/users/$username"
        
    try {
        $response = Invoke-WebRequest -Uri $uri `
                                      -Authentication Basic `
                                      -Method Get `
                                      -Credential $credential

        $user = ConvertFrom-Json $response.Content
        return $user
    }
    catch {
        return $null
    }
}

function Get-TeamMembers {
    param (
        [string]$teamSlug
    )

    $teamMembers = @()

    $uri = "$gitHubApiBaseUrl/orgs/$organizationName/teams/$teamSlug/members"
    while ($uri) {
    
        $response = Invoke-WebRequest -Uri $uri `
                                      -Authentication Basic `
                                      -Method Get `
                                      -Credential $credential
    
        try {

            $teamMembersPage = ConvertFrom-Json $response.Content
            $teamMembersPage | ForEach-Object { 
                $teamMembers += $_
            }
        }
        catch {
            
        }
    
        $uri = $response.RelationLink['next']
    }

    return $teamMembers
}

Write-Host 'Getting Organization Members...' -ForegroundColor Green
$uri = "$gitHubApiBaseUrl/orgs/$organizationName/members"
while ($uri) {

    $response = Invoke-WebRequest -Uri $uri `
                                  -Authentication Basic `
                                  -Method Get `
                                  -Credential $credential

    $members = ConvertFrom-Json $response.Content
    $members | ForEach-Object { 

        $username = $_.login 
        $user = Get-GitHubUser $username

        $users += $user
    }

    $uri = $response.RelationLink['next']
}

Write-Host 'Getting Organization Teams...' -ForegroundColor Green
$uri = "$gitHubApiBaseUrl/orgs/$organizationName/teams"
while ($uri) {

    $response = Invoke-WebRequest -Uri $uri `
                                  -Authentication Basic `
                                  -Credential $credential

    $teamsPage = ConvertFrom-Json $response.Content
    $teamsPage | ForEach-Object { 
        $teams += $_
    }

    $uri = $response.RelationLink['next']
}

if (Test-Path -Path 'members-by-team.csv') {
    Remove-Item 'members-by-team.csv'
}

Add-Content -Path 'members-by-team.csv' -Value 'Team,FullName,GitHubUserName,PublicEmail'

Write-Host 'Getting Members By Team...' -ForegroundColor Green
$teams | Sort-Object Name -Unique | ForEach-Object { 
    $teamName = $_.Name

    $teamMembers = Get-TeamMembers $_.Slug 
    $teamMembers | ForEach-Object {

        $login = $_.login
        $user = $users | Where-Object { $_.login -eq $login } | Select-Object -First 1
        $name = if ($user) { $user.name } else { $login }
        $email = if ($user) { $user.email } else { '' }

        Add-Content -Path 'members-by-team.csv' -Value "$teamName,$name,$login,$email"
    }
}

sleep 10


$credsFile = ConvertTo-SecureString "g&kf6jsfbnT+NuX_" -AsPlainText -Force
$securePassword = $CredsFile
$credentials = New-Object System.Management.Automation.PSCredential ("CSTAD.Lookup@vertexinc.com", $securePassword)

Get-ADUser -Filter * -Properties * -Credential $credentials | Where { $_.Enabled -eq $True} |Select-Object DisplayName | export-csv -path EN-ADUsers.csv -NoTypeInformation


sleep 60

#comparing to excel

$aduser = Import-Csv -Path $scriptsDir\members-by-team.csv | sort FullName -Descending

$Actives = Import-Csv -Path $scriptsDir\EN-ADUsers.csv  | sort DisplayName -Descending

$matchUsers = @()
$notmatchUsers = @()

foreach($user in $aduser){

if($Actives.DisplayName -eq $user.FullName){

    $matchUsers += $user
    }
    else{
    $notmatchUsers += $user
    }
    }

$matchUsers | Export-Csv -Path "$scriptsDir\Match.csv" -NoTypeInformation
$notmatchUsers | Export-Csv -Path "$scriptsDir\Users-Not-Matched.csv" -NoTypeInformation

Get-ChildItem -Path Match.csv -File | Sort-Object -Property FullName
Get-ChildItem -Path Users-Not-Matched.csv -File | Sort-Object -Property FullName

sleep 30

$credsFile = ConvertTo-SecureString "$@!l!n9Aw@y2DaY" -AsPlainText -Force
$securePassword = $CredsFile
$User = "cst.build@vertexinc.com"
$cred=New-Object System.Management.Automation.PSCredential ($User, $securePassword)
$EmailTo = "vijendra.adhangle@vertexinc.com,rob.schlank@vertexinc.com,David.Nerozzi@vertexinc.com,rich.dagusto@vertexinc.com"
$EmailFrom = "cst.build@vertexinc.com"
$Subject = "Disabled Git-Hub Users In AD"
$Body = "Attached is the Git-Hub users not in AD or disabled in AD"
$SMTPServer ="smtp.outlook.com"
$filenameAndPath = "$scriptsDir\Users-Not-Matched.csv"
$SMTPMessage = New-Object System.Net.Mail.MailMessage($EmailFrom,$EmailTo,$Subject,$Body)
$attachment = New-Object System.Net.Mail.Attachment($filenameAndPath)
$SMTPMessage.Attachments.Add($attachment)
$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587)
$SMTPClient.EnableSsl = $true
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential($cred.UserName, $cred.Password);
$SMTPClient.Send($SMTPMessage)
