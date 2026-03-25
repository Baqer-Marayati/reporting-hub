# Removes VertiPaq import cache for the Finance PBIP semantic model.
# After deletion, open the report in Power BI Desktop and use Refresh to load data from sources.
# cache.abf is gitignored; Desktop recreates it on successful refresh.

param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..\..")).Path
)

$ErrorActionPreference = "Stop"

$cache = Join-Path $RepoRoot "Reports\Finance\Financial Report\Financial Report.SemanticModel\.pbi\cache.abf"
if (Test-Path -LiteralPath $cache) {
    Remove-Item -LiteralPath $cache -Force
    Write-Host "Removed: $cache"
} else {
    Write-Host "No cache.abf at $cache (already clean)."
}
