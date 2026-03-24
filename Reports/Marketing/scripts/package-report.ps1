param(
    [string]$CompanyCode = "GLOBAL",
    [string]$ReportName = "Marketing Report",
    [string]$SourceDir = "",
    [string]$RepoRoot = "C:\Work\reporting-hub"
)

$ErrorActionPreference = "Stop"
$runner = Join-Path $RepoRoot "scripts\package-report.ps1"
if (!(Test-Path $runner)) { throw "Portfolio packager script not found: $runner" }
if ([string]::IsNullOrWhiteSpace($SourceDir)) { throw "Provide -SourceDir for Marketing PBIP source folder." }

powershell -ExecutionPolicy Bypass -File $runner `
    -Domain "Marketing" `
    -ReportName $ReportName `
    -SourceDir $SourceDir `
    -CompanyCode $CompanyCode `
    -RepoRoot $RepoRoot
