# Removes VertiPaq import cache for Finance company PBIP semantic models.
# Delegates to Portfolio/scripts/clear-model-cache.ps1

param(
    [ValidateSet("ALL", "CANON", "PAPERENTITY")]
    [string]$CompanyCode = "ALL",
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..\..\..")).Path
)

$ErrorActionPreference = "Stop"
$runner = Join-Path $RepoRoot "Portfolio\scripts\clear-model-cache.ps1"
if (!(Test-Path -LiteralPath $runner)) { throw "Portfolio script not found: $runner" }

powershell -ExecutionPolicy Bypass -File $runner -Domain Finance -CompanyCode $CompanyCode -RepoRoot $RepoRoot
