# Read-only Windows pre-install inventory collector.
#
# This script intentionally omits the computer name, usernames, IP addresses,
# MAC addresses, serial numbers, device identifiers, BitLocker key protectors,
# credential material, and application command lines. Raw output may still
# contain environment-specific hardware or drive details; review it before
# publishing any summary.

[CmdletBinding()]
param()

$ErrorActionPreference = 'Continue'
$script:CollectionNotes = @()

function Write-Section {
    param([Parameter(Mandatory = $true)][string]$Name)
    Write-Output ''
    Write-Output "## $Name"
}

function Write-Field {
    param(
        [Parameter(Mandatory = $true)][string]$Label,
        [AllowNull()]$Value
    )

    if ($null -eq $Value -or [string]::IsNullOrWhiteSpace([string]$Value)) {
        Write-Output "${Label}: UNKNOWN"
    }
    else {
        Write-Output "${Label}: $Value"
    }
}

function ConvertTo-GiB {
    param([AllowNull()]$Bytes)
    if ($null -eq $Bytes) { return $null }
    return [math]::Round(([double]$Bytes / 1GB), 2)
}

function Get-SafeCimInstance {
    param([Parameter(Mandatory = $true)][string]$ClassName)
    try {
        return @(Get-CimInstance -ClassName $ClassName -ErrorAction Stop)
    }
    catch {
        $script:CollectionNotes += "$ClassName unavailable ($($_.Exception.Message))"
        return @()
    }
}

Write-Output '# HomeLab Windows read-only inventory'
Write-Output 'Collection method: command-verified; sanitize before publication'
Write-Field 'Collected (UTC)' ([datetime]::UtcNow.ToString('yyyy-MM-ddTHH:mm:ssZ'))
Write-Field 'PowerShell version' $PSVersionTable.PSVersion.ToString()

Write-Section 'System and operating system'
$systems = @(Get-SafeCimInstance 'Win32_ComputerSystem')
if ($systems.Count -gt 0) {
    $system = $systems[0]
    Write-Field 'Manufacturer' $system.Manufacturer
    Write-Field 'Model' $system.Model
    Write-Field 'System type' $system.SystemType
    Write-Field 'Installed memory (GiB)' (ConvertTo-GiB $system.TotalPhysicalMemory)
    Write-Field 'Hypervisor present' $system.HypervisorPresent
}

$operatingSystems = @(Get-SafeCimInstance 'Win32_OperatingSystem')
if ($operatingSystems.Count -gt 0) {
    $operatingSystem = $operatingSystems[0]
    Write-Field 'Operating system' $operatingSystem.Caption
    Write-Field 'Version' $operatingSystem.Version
    Write-Field 'Build' $operatingSystem.BuildNumber
    Write-Field 'Architecture' $operatingSystem.OSArchitecture
    Write-Field 'Last boot (local time)' $operatingSystem.LastBootUpTime
}

Write-Section 'CPU'
$processors = @(Get-SafeCimInstance 'Win32_Processor')
$processorNumber = 0
foreach ($processor in $processors) {
    $processorNumber++
    Write-Output "CPU $processorNumber"
    Write-Field '  Model' $processor.Name.Trim()
    Write-Field '  Cores' $processor.NumberOfCores
    Write-Field '  Logical processors' $processor.NumberOfLogicalProcessors
    Write-Field '  Maximum clock (MHz)' $processor.MaxClockSpeed
    Write-Field '  Virtualization enabled in firmware' $processor.VirtualizationFirmwareEnabled
    Write-Field '  Second-level address translation' $processor.SecondLevelAddressTranslationExtensions
}

Write-Section 'Memory modules'
$memoryArrays = @(Get-SafeCimInstance 'Win32_PhysicalMemoryArray')
foreach ($memoryArray in $memoryArrays) {
    Write-Field 'Reported memory slots' $memoryArray.MemoryDevices
    $maximumCapacityBytes = if ($memoryArray.MaxCapacityEx) {
        [double]$memoryArray.MaxCapacityEx * 1KB
    }
    elseif ($memoryArray.MaxCapacity) {
        [double]$memoryArray.MaxCapacity * 1KB
    }
    else {
        $null
    }
    Write-Field 'Firmware-reported maximum capacity (GiB)' (ConvertTo-GiB $maximumCapacityBytes)
}

$memoryModules = @(Get-SafeCimInstance 'Win32_PhysicalMemory')
$moduleNumber = 0
foreach ($module in $memoryModules) {
    $moduleNumber++
    Write-Output "Memory module $moduleNumber"
    Write-Field '  Locator' $module.DeviceLocator
    Write-Field '  Bank' $module.BankLabel
    Write-Field '  Capacity (GiB)' (ConvertTo-GiB $module.Capacity)
    Write-Field '  Rated speed (MT/s)' $module.Speed
    Write-Field '  Configured speed (MT/s)' $module.ConfiguredClockSpeed
    Write-Field '  Manufacturer' $module.Manufacturer
    Write-Field '  Part number' $(if ($module.PartNumber) { $module.PartNumber.Trim() } else { $null })
}

Write-Section 'Firmware and platform security'
$biosRecords = @(Get-SafeCimInstance 'Win32_BIOS')
if ($biosRecords.Count -gt 0) {
    $bios = $biosRecords[0]
    Write-Field 'BIOS vendor' $bios.Manufacturer
    Write-Field 'SMBIOS BIOS version' $bios.SMBIOSBIOSVersion
    Write-Field 'BIOS release date' $bios.ReleaseDate
    Write-Field 'SMBIOS version' "$($bios.SMBIOSMajorVersion).$($bios.SMBIOSMinorVersion)"
}

try {
    Write-Field 'Secure Boot enabled' (Confirm-SecureBootUEFI -ErrorAction Stop)
}
catch {
    Write-Field 'Secure Boot enabled' "UNKNOWN ($($_.Exception.Message))"
}

if (Get-Command Get-Tpm -ErrorAction SilentlyContinue) {
    try {
        $tpm = Get-Tpm -ErrorAction Stop
        Write-Field 'TPM present' $tpm.TpmPresent
        Write-Field 'TPM ready' $tpm.TpmReady
        Write-Field 'TPM enabled' $tpm.TpmEnabled
        Write-Field 'TPM auto-provisioning' $tpm.AutoProvisioning
    }
    catch {
        Write-Output "Collection note: TPM status unavailable ($($_.Exception.Message))"
    }
}

Write-Section 'Physical storage'
$diskDrives = @(Get-SafeCimInstance 'Win32_DiskDrive')
foreach ($disk in ($diskDrives | Sort-Object Index)) {
    Write-Output "Physical disk $($disk.Index)"
    Write-Field '  Model' $disk.Model
    Write-Field '  Media type' $disk.MediaType
    Write-Field '  Interface' $disk.InterfaceType
    Write-Field '  Capacity (GiB)' (ConvertTo-GiB $disk.Size)
    Write-Field '  Firmware revision' $disk.FirmwareRevision
}

if (Get-Command Get-Disk -ErrorAction SilentlyContinue) {
    try {
        foreach ($disk in (Get-Disk -ErrorAction Stop | Sort-Object Number)) {
            Write-Output "Disk layout $($disk.Number)"
            Write-Field '  Friendly name' $disk.FriendlyName
            Write-Field '  Partition style' $disk.PartitionStyle
            Write-Field '  Operational status' ($disk.OperationalStatus -join ', ')
            Write-Field '  Health status' $disk.HealthStatus
            Write-Field '  Capacity (GiB)' (ConvertTo-GiB $disk.Size)
        }
    }
    catch {
        Write-Output "Collection note: disk layout unavailable ($($_.Exception.Message))"
    }
}

Write-Output 'Filesystem capacity (volume labels omitted)'
$logicalDisks = @(Get-SafeCimInstance 'Win32_LogicalDisk')
foreach ($volume in ($logicalDisks | Where-Object DriveType -eq 3 | Sort-Object DeviceID)) {
    Write-Output "Volume $($volume.DeviceID)"
    Write-Field '  Filesystem' $volume.FileSystem
    Write-Field '  Capacity (GiB)' (ConvertTo-GiB $volume.Size)
    Write-Field '  Free (GiB)' (ConvertTo-GiB $volume.FreeSpace)
}

if (Get-Command Get-BitLockerVolume -ErrorAction SilentlyContinue) {
    try {
        foreach ($volume in (Get-BitLockerVolume -ErrorAction Stop)) {
            Write-Output "BitLocker volume $($volume.MountPoint)"
            Write-Field '  Volume status' $volume.VolumeStatus
            Write-Field '  Protection status' $volume.ProtectionStatus
            Write-Field '  Encryption percentage' $volume.EncryptionPercentage
        }
    }
    catch {
        Write-Output "Collection note: BitLocker status unavailable ($($_.Exception.Message))"
    }
}

Write-Section 'Graphics and AI compatibility'
$videoControllers = @(Get-SafeCimInstance 'Win32_VideoController')
$controllerNumber = 0
foreach ($controller in $videoControllers) {
    $controllerNumber++
    Write-Output "Graphics controller $controllerNumber"
    Write-Field '  Name' $controller.Name
    Write-Field '  Driver version' $controller.DriverVersion
    Write-Field '  CIM-reported memory (GiB)' (ConvertTo-GiB $controller.AdapterRAM)
    Write-Field '  Current resolution' $(if ($controller.CurrentHorizontalResolution -and $controller.CurrentVerticalResolution) { "$($controller.CurrentHorizontalResolution)x$($controller.CurrentVerticalResolution)" } else { $null })
}

$nvidiaSmi = Get-Command nvidia-smi.exe -ErrorAction SilentlyContinue
if (-not $nvidiaSmi) {
    $standardNvidiaSmi = Join-Path $env:ProgramFiles 'NVIDIA Corporation\NVSMI\nvidia-smi.exe'
    if (Test-Path -LiteralPath $standardNvidiaSmi) {
        $nvidiaSmi = Get-Item -LiteralPath $standardNvidiaSmi
    }
}

if ($nvidiaSmi) {
    Write-Output 'NVIDIA-SMI data (no GPU UUID or serial requested)'
    $nvidiaSmiPath = if ($nvidiaSmi.Source) { $nvidiaSmi.Source } else { $nvidiaSmi.FullName }
    & $nvidiaSmiPath --query-gpu=name,memory.total,driver_version,temperature.gpu,power.limit --format=csv,noheader 2>&1
    $computeCapability = & $nvidiaSmiPath --query-gpu=compute_cap --format=csv,noheader 2>$null
    if ($LASTEXITCODE -eq 0 -and $computeCapability) {
        Write-Field 'NVIDIA compute capability' ($computeCapability -join ', ')
    }
    else {
        Write-Field 'NVIDIA compute capability' 'UNKNOWN (not reported by the installed driver)'
    }
}
else {
    Write-Output 'NVIDIA-SMI: unavailable'
}

if (Get-Command nvcc.exe -ErrorAction SilentlyContinue) {
    Write-Output 'CUDA toolkit compiler'
    & nvcc.exe --version 2>&1 | Select-Object -Last 2
}
else {
    Write-Output 'CUDA toolkit compiler: unavailable'
}

Write-Section 'Physical network capabilities'
if (Get-Command Get-NetAdapter -ErrorAction SilentlyContinue) {
    try {
        $adapters = Get-NetAdapter -Physical -ErrorAction Stop
        $adapterNumber = 0
        foreach ($adapter in $adapters) {
            $adapterNumber++
            Write-Output "Physical adapter $adapterNumber"
            Write-Field '  Description' $adapter.InterfaceDescription
            Write-Field '  Status' $adapter.Status
            Write-Field '  Link speed' $adapter.LinkSpeed
        }
    }
    catch {
        Write-Output "Collection note: network capability query unavailable ($($_.Exception.Message))"
    }
}

Write-Section 'Battery snapshot'
$batteries = @(Get-SafeCimInstance 'Win32_Battery')
if ($batteries.Count -eq 0) {
    Write-Output 'Battery information: unavailable'
}
else {
    foreach ($battery in $batteries) {
        Write-Field 'Battery status code' $battery.BatteryStatus
        Write-Field 'Estimated charge remaining (%)' $battery.EstimatedChargeRemaining
        Write-Field 'Estimated runtime (minutes)' $battery.EstimatedRunTime
    }
}

Write-Section 'Review reminder'
if ($script:CollectionNotes.Count -gt 0) {
    Write-Output 'Unavailable CIM queries:'
    foreach ($note in $script:CollectionNotes) {
        Write-Output "- $note"
    }
}
Write-Output 'Do not commit this raw output. Confirm it came from the Acer Nitro 5, remove any private identifiers, and summarize only verified repository-safe facts.'
