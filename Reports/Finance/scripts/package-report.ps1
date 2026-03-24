param(
    [string]$CompanyCode = "GLOBAL",
    [string]$RepoRoot = "C:\Work\reporting-hub"
)

$ErrorActionPreference = "Stop"

$source = Join-Path $RepoRoot "Reports\Finance\Financial Report"
$runner = Join-Path $RepoRoot "scripts\package-report.ps1"

if (!(Test-Path $runner)) {
    throw "Portfolio packager script not found: $runner"
}

powershell -ExecutionPolicy Bypass -File $runner `
    -Domain "Finance" `
    -ReportName "Financial Report" `
    -SourceDir $source `
    -CompanyCode $CompanyCode `
    -RepoRoot $RepoRoot
