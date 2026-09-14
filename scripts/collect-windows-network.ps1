# Read-only Windows network snapshot for HomeLab troubleshooting.
#
# The report includes private addressing, gateways, DNS, routes, and cached
# neighbor addresses. It omits SSIDs, public-IP lookups, MAC addresses, and
# credential material. Keep its output under inventory-output/; do not commit.

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('homelab', 'upstream', 'upstream-2.4ghz', 'upstream-5ghz')]
    [string]$Network
)

$ErrorActionPreference = 'Continue'

function Write-Section {
    param([Parameter(Mandatory = $true)][string]$Name)
    Write-Output ''
    Write-Output "## $Name"
}

function Convert-PrefixToMask {
    param([Parameter(Mandatory = $true)][ValidateRange(0, 32)][int]$PrefixLength)
    $bits = ('1' * $PrefixLength).PadRight(32, '0')
    return (@(0, 8, 16, 24) | ForEach-Object {
        [Convert]::ToInt32($bits.Substring($_, 8), 2)
    }) -join '.'
}

Write-Output '# HomeLab private Windows network snapshot'
Write-Output "Network label: $Network"
Write-Output "Collected (UTC): $([datetime]::UtcNow.ToString('yyyy-MM-ddTHH:mm:ssZ'))"
Write-Output 'Sensitivity: PRIVATE OPERATIONAL DATA - DO NOT COMMIT'
Write-Output 'Collection behavior: local read-only queries; no active network scan'

Write-Section 'Active IPv4 interfaces'
$activeConfigs = @(
    Get-NetIPConfiguration -ErrorAction SilentlyContinue |
        Where-Object { $_.NetAdapter.Status -eq 'Up' -and $_.IPv4Address }
)

if ($activeConfigs.Count -eq 0) {
    Write-Output 'No active IPv4 interface was found.'
}

foreach ($config in $activeConfigs) {
    Write-Output "Interface: $($config.InterfaceAlias)"
    Write-Output "  Adapter: $($config.InterfaceDescription)"
    foreach ($address in @($config.IPv4Address)) {
        Write-Output "  IPv4: $($address.IPAddress)/$($address.PrefixLength)"
        Write-Output "  Netmask: $(Convert-PrefixToMask -PrefixLength $address.PrefixLength)"
    }
    $gateways = @($config.IPv4DefaultGateway | ForEach-Object NextHop)
    Write-Output "  Default gateway: $(if ($gateways) { $gateways -join ', ' } else { 'NONE' })"
    $dnsServers = @($config.DNSServer.ServerAddresses | Where-Object { $_ -match '^\d{1,3}(\.\d{1,3}){3}$' })
    Write-Output "  IPv4 DNS: $(if ($dnsServers) { $dnsServers -join ', ' } else { 'UNKNOWN' })"

    $ipInterface = Get-NetIPInterface -InterfaceIndex $config.InterfaceIndex -AddressFamily IPv4 -ErrorAction SilentlyContinue
    if ($ipInterface) {
        Write-Output "  DHCP: $($ipInterface.Dhcp)"
        Write-Output "  Interface metric: $($ipInterface.InterfaceMetric)"
    }
}

Write-Section 'IPv4 routes'
Get-NetRoute -AddressFamily IPv4 -ErrorAction SilentlyContinue |
    Where-Object {
        $_.State -eq 'Alive' -and
        ($_.DestinationPrefix -eq '0.0.0.0/0' -or $_.DestinationPrefix -match '^(10\.|172\.(1[6-9]|2[0-9]|3[01])\.|192\.168\.)')
    } |
    Sort-Object DestinationPrefix, RouteMetric |
    Select-Object DestinationPrefix, NextHop, InterfaceAlias, RouteMetric, Protocol |
    Format-Table -AutoSize |
    Out-String -Width 240 |
    Write-Output

Write-Section 'Cached IPv4 neighbors (MAC addresses omitted)'
Get-NetNeighbor -AddressFamily IPv4 -ErrorAction SilentlyContinue |
    Where-Object {
        $_.State -notin @('Unreachable', 'Permanent') -and
        $_.IPAddress -notmatch '^(224\.|239\.|255\.)'
    } |
    Sort-Object InterfaceAlias, IPAddress |
    Select-Object IPAddress, InterfaceAlias, State |
    Format-Table -AutoSize |
    Out-String -Width 240 |
    Write-Output

Write-Section 'Privacy reminder'
Write-Output 'Keep this report in inventory-output/. Do not commit it or paste it into public issues.'
Write-Output 'Before sharing, remove private addressing, hostnames, SSIDs, and any identifiers added outside this script.'
