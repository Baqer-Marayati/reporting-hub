param(
    [string]$CompanyCode = "GLOBAL",
    [string]$RepoRoot = "C:\Work\reporting-hub",
    [switch]$KeepModelCache
)

$ErrorActionPreference = "Stop"

$source = Join-Path $RepoRoot "Reports\Finance\Financial Report"
$runner = Join-Path $RepoRoot "scripts\package-report.ps1"

if (!(Test-Path $runner)) {
    throw "Portfolio packager script not found: $runner"
}

$args = @(
    "-ExecutionPolicy", "Bypass", "-File", $runner,
    "-Domain", "Finance",
    "-ReportName", "Financial Report",
    "-SourceDir", $source,
    "-CompanyCode", $CompanyCode,
    "-RepoRoot", $RepoRoot
)
if ($KeepModelCache) {
    $args += "-KeepModelCache"
}
powershell @args

$latestZip = Join-Path $RepoRoot "Reports\Finance\Exports\Server Packages\latest\Financial Report - ready.zip"
$legacyZip = Join-Path $RepoRoot "Reports\Finance\Exports\Server Packages\Financial Report - ready.zip"
if (Test-Path -LiteralPath $latestZip) {
    Copy-Item -LiteralPath $latestZip -Destination $legacyZip -Force
    Write-Host "Mirrored latest zip to legacy path: $legacyZip"
}
