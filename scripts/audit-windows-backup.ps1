# Read-only Windows backup audit for an operating-system migration.
#
# This script reads file metadata to report approximate counts and sizes. It
# does not open file contents, copy data, change attributes, or delete files.
# Output includes private paths and folder names: keep the report out of Git.

[CmdletBinding()]
param()

$ErrorActionPreference = 'Continue'

function Write-Section {
    param([Parameter(Mandatory = $true)][string]$Name)
    Write-Output ''
    Write-Output "## $Name"
}

function Measure-Path {
    param(
        [Parameter(Mandatory = $true)][string]$Label,
        [AllowNull()][string]$Path
    )

    if ([string]::IsNullOrWhiteSpace($Path) -or -not (Test-Path -LiteralPath $Path)) {
        Write-Output "${Label}: NOT FOUND"
        return
    }

    try {
        $measurement = Get-ChildItem -LiteralPath $Path -File -Recurse -Force -ErrorAction SilentlyContinue |
            Measure-Object -Property Length -Sum
        $bytes = if ($null -eq $measurement.Sum) { 0 } else { [double]$measurement.Sum }
        $gib = [math]::Round($bytes / 1GB, 2)
        Write-Output "${Label}: $Path"
        Write-Output "  Files: $($measurement.Count)"
        Write-Output "  Approximate size (GiB): $gib"
    }
    catch {
        Write-Output "${Label}: ERROR ($($_.Exception.Message))"
    }
}

Write-Output '# Private Windows pre-install backup audit'
Write-Output 'Contains personal paths and folder names. Do not commit this report.'
Write-Output "Collected (UTC): $([datetime]::UtcNow.ToString('yyyy-MM-ddTHH:mm:ssZ'))"

$userProfile = [Environment]::GetFolderPath('UserProfile')
$standardLocations = [ordered]@{
    'Desktop' = [Environment]::GetFolderPath('Desktop')
    'Documents' = [Environment]::GetFolderPath('MyDocuments')
    'Downloads' = Join-Path $userProfile 'Downloads'
    'Pictures' = [Environment]::GetFolderPath('MyPictures')
    'Videos' = [Environment]::GetFolderPath('MyVideos')
    'Music' = [Environment]::GetFolderPath('MyMusic')
    'Saved Games' = Join-Path $userProfile 'Saved Games'
    'SSH directory' = Join-Path $userProfile '.ssh'
}

Write-Section 'Standard personal locations'
foreach ($entry in $standardLocations.GetEnumerator()) {
    Measure-Path -Label $entry.Key -Path $entry.Value
}

Write-Section 'Cloud-sync locations'
$cloudRoots = @(
    @{ Label = 'OneDrive'; Path = $env:OneDrive },
    @{ Label = 'OneDrive Consumer'; Path = $env:OneDriveConsumer },
    @{ Label = 'OneDrive Commercial'; Path = $env:OneDriveCommercial }
)
$seenCloudPaths = @{}
foreach ($cloudRoot in $cloudRoots) {
    if (-not [string]::IsNullOrWhiteSpace($cloudRoot.Path) -and -not $seenCloudPaths.ContainsKey($cloudRoot.Path)) {
        $seenCloudPaths[$cloudRoot.Path] = $true
        Measure-Path -Label $cloudRoot.Label -Path $cloudRoot.Path
    }
}
if ($seenCloudPaths.Count -eq 0) {
    Write-Output 'OneDrive roots: NOT FOUND through environment variables'
}
Write-Output 'Review sync status manually; size enumeration does not prove cloud-only files are downloaded.'

Write-Section 'Common application data'
Measure-Path -Label 'Roaming application data' -Path $env:APPDATA
Measure-Path -Label 'Local application data' -Path $env:LOCALAPPDATA
Measure-Path -Label 'Chrome profiles' -Path (Join-Path $env:LOCALAPPDATA 'Google\Chrome\User Data')
Measure-Path -Label 'Edge profiles' -Path (Join-Path $env:LOCALAPPDATA 'Microsoft\Edge\User Data')
Measure-Path -Label 'Firefox profiles' -Path (Join-Path $env:APPDATA 'Mozilla\Firefox\Profiles')
Measure-Path -Label 'Steam user data' -Path ${env:ProgramFiles(x86)}\Steam\userdata

Write-Section 'Non-standard user-profile folders'
$standardFullPaths = @($standardLocations.Values | Where-Object { $_ } | ForEach-Object {
    try { [System.IO.Path]::GetFullPath($_).TrimEnd('\') } catch { $_ }
})
Get-ChildItem -LiteralPath $userProfile -Directory -Force -ErrorAction SilentlyContinue |
    Where-Object {
        $candidate = $_.FullName.TrimEnd('\')
        $candidate -notin $standardFullPaths -and
        $_.Name -notin @('AppData', 'OneDrive', 'Searches', 'Contacts', 'Links', 'Favorites')
    } |
    ForEach-Object { Measure-Path -Label "User folder '$($_.Name)'" -Path $_.FullName }

Write-Section 'Top-level folders on non-system fixed volumes'
$systemDrive = $env:SystemDrive.TrimEnd(':')
$fixedVolumes = Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=3' -ErrorAction SilentlyContinue
foreach ($volume in $fixedVolumes) {
    $driveLetter = $volume.DeviceID.TrimEnd(':')
    if ($driveLetter -eq $systemDrive) { continue }
    $root = "$($volume.DeviceID)\"
    Write-Output "Volume $($volume.DeviceID)"
    Get-ChildItem -LiteralPath $root -Directory -Force -ErrorAction SilentlyContinue |
        ForEach-Object { Measure-Path -Label "Top-level folder '$($_.Name)'" -Path $_.FullName }
}

Write-Section 'Virtualization and development indicators'
if (Get-Command wsl.exe -ErrorAction SilentlyContinue) {
    $wslNames = @(wsl.exe --list --quiet 2>$null | ForEach-Object { $_.Trim() } | Where-Object { $_ })
    if ($wslNames.Count -gt 0) {
        Write-Output "WSL distributions found: $($wslNames -join ', ')"
        Write-Output 'Export required distributions separately with wsl.exe --export.'
    }
    else {
        Write-Output 'WSL distributions found: none reported'
    }
}

Write-Section 'Required manual checks'
Write-Output '- Open representative files from the backup destination before erasing anything.'
Write-Output '- Confirm OneDrive Files On-Demand items are locally available or safely synchronized.'
Write-Output '- Export browser bookmarks or verify account synchronization.'
Write-Output '- Preserve password-vault exports only in encrypted private storage.'
Write-Output '- Preserve SSH private keys only if required; never place them in this repository.'
Write-Output '- Check email archives, game saves, project repositories, VM disks, databases, and files stored outside the user profile.'
Write-Output '- Record applications that must be reinstalled; application binaries themselves normally do not need copying.'
