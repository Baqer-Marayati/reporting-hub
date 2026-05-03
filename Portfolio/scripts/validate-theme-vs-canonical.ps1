param(
    [switch]$All,
    [ValidateSet("Finance", "Sales", "Service", "Inventory", "DataExchange")]
    [string]$Domain,
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
)

$ErrorActionPreference = "Stop"
$RepoRoot = (Resolve-Path -LiteralPath $RepoRoot).Path
$canonical = Join-Path $RepoRoot "Portfolio\Shared\Themes\Custom_Theme49412231581938193.json"
if (!(Test-Path -LiteralPath $canonical)) {
    throw "Canonical theme missing: $canonical"
}

function Get-Sha256([string]$Path) {
    (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash
}

$canonicalHash = Get-Sha256 $canonical
Write-Host "Canonical SHA256: $canonicalHash" -ForegroundColor Cyan
Write-Host "  $canonical"
Write-Host ""

$themeName = "Custom_Theme49412231581938193.json"
$paths = @()

# Only active PBIP report roots (excludes Archive/, Exports/, Design Benchmarks/, etc.)
$activeRelative = @{
    Finance      = @(
        "Reports\Finance\Companies\CANON\Canon Financial Report\Canon Financial Report.Report\StaticResources\RegisteredResources\$themeName",
        "Reports\Finance\Companies\PAPERENTITY\Paper Financial Report\Paper Financial Report.Report\StaticResources\RegisteredResources\$themeName"
    )
    Sales        = @(
        "Reports\Sales\Companies\CANON\Canon Sales Report\Canon Sales Report.Report\StaticResources\RegisteredResources\$themeName",
        "Reports\Sales\Companies\PAPERENTITY\Paper Sales Report\Paper Sales Report.Report\StaticResources\RegisteredResources\$themeName"
    )
    Service      = @(
        "Reports\Service\Companies\CANON\Canon Service Report\Canon Service Report.Report\StaticResources\RegisteredResources\$themeName",
        "Reports\Service\Companies\PAPERENTITY\Paper Service Report\Paper Service Report.Report\StaticResources\RegisteredResources\$themeName"
    )
    Inventory    = @(
        "Reports\Inventory\Companies\CANON\Canon Inventory Report\Canon Inventory Report.Report\StaticResources\RegisteredResources\$themeName",
        "Reports\Inventory\Companies\PAPERENTITY\Paper Inventory Report\Paper Inventory Report.Report\StaticResources\RegisteredResources\$themeName"
    )
    DataExchange = @(
        "Reports\DataExchange\Companies\CANON\Canon Data Exchange Report\Canon Data Exchange Report.Report\StaticResources\RegisteredResources\$themeName",
        "Reports\DataExchange\Companies\PAPERENTITY\Paper Data Exchange Report\Paper Data Exchange Report.Report\StaticResources\RegisteredResources\$themeName"
    )
}

if ($All) {
    $paths = foreach ($rel in @($activeRelative.Values | ForEach-Object { $_ })) {
        $p = Join-Path $RepoRoot $rel
        if (Test-Path -LiteralPath $p) { $p }
    }
} elseif ($Domain) {
    $paths = foreach ($rel in @($activeRelative[$Domain])) {
        $p = Join-Path $RepoRoot $rel
        if (Test-Path -LiteralPath $p) { $p }
    }
} else {
    throw "Specify -All or -Domain (Finance|Sales|Service|Inventory|DataExchange)."
}

$exit = 0
foreach ($p in $paths) {
    if (!(Test-Path -LiteralPath $p)) {
        Write-Host "[MISS] $p" -ForegroundColor Yellow
        $exit = 1
        continue
    }
    $h = Get-Sha256 $p
    if ($h -eq $canonicalHash) {
        Write-Host "[OK]   $p" -ForegroundColor Green
    } else {
        Write-Host "[DIFF] $p" -ForegroundColor Yellow
        Write-Host "       module SHA256: $h"
        $exit = 2
    }
}

if ($paths.Count -eq 0) {
    Write-Host "No registered theme files found for the requested scope."
}

exit $exit
