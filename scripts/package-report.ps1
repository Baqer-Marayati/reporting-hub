param(
    [Parameter(Mandatory = $true)]
    [string]$Domain,
    [Parameter(Mandatory = $true)]
    [string]$ReportName,
    [Parameter(Mandatory = $true)]
    [string]$SourceDir,
    [string]$CompanyCode = "GLOBAL",
    [string]$RepoRoot = "C:\Work\reporting-hub"
)

$ErrorActionPreference = "Stop"

$domainRoot = Join-Path $RepoRoot ("Reports\" + $Domain)
$latestDir = Join-Path $domainRoot ("Exports\Server Packages\latest")
$archiveDir = Join-Path $domainRoot ("Exports\Server Packages\archive")

if (!(Test-Path $SourceDir)) {
    throw "SourceDir not found: $SourceDir"
}

New-Item -ItemType Directory -Path $latestDir -Force | Out-Null
New-Item -ItemType Directory -Path $archiveDir -Force | Out-Null

$safeReportName = $ReportName -replace '[\\/:*?"<>|]', "_"
$safeCompany = $CompanyCode -replace '[\\/:*?"<>|]', "_"
$latestZip = Join-Path $latestDir ("{0} - ready.zip" -f $safeReportName)

if (Test-Path $latestZip) {
    Remove-Item $latestZip -Force
}

Compress-Archive -Path $SourceDir -DestinationPath $latestZip -CompressionLevel Optimal

$timestamp = Get-Date -Format "yyyyMMdd_HHmm"
$shortSha = "nosha"
try {
    $shortSha = (git -C $RepoRoot rev-parse --short HEAD).Trim()
} catch {
    # Keep nosha if git is unavailable.
}

$archiveName = "{0}__{1}__{2}__{3}.zip" -f $timestamp, $safeCompany, $safeReportName, $shortSha
$archiveZip = Join-Path $archiveDir $archiveName
Copy-Item -Path $latestZip -Destination $archiveZip -Force

Write-Host "Latest:  $latestZip"
Write-Host "Archive: $archiveZip"
