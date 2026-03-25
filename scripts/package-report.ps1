param(
    [Parameter(Mandatory = $true)]
    [string]$Domain,
    [Parameter(Mandatory = $true)]
    [string]$ReportName,
    [Parameter(Mandatory = $true)]
    [string]$SourceDir,
    [string]$CompanyCode = "GLOBAL",
    [string]$RepoRoot = "C:\Work\reporting-hub",
    [switch]$KeepModelCache
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

function New-CanonicalZipFromFolder {
    param(
        [Parameter(Mandatory = $true)]
        [string]$FolderPath,
        [Parameter(Mandatory = $true)]
        [string]$ZipPath
    )

    Add-Type -AssemblyName System.IO.Compression
    Add-Type -AssemblyName System.IO.Compression.FileSystem

    $sourceRoot = (Resolve-Path -LiteralPath $FolderPath).Path
    $parentRoot = Split-Path -Path $sourceRoot -Parent

    if (Test-Path -LiteralPath $ZipPath) {
        Remove-Item -LiteralPath $ZipPath -Force
    }

    $zip = [System.IO.Compression.ZipFile]::Open($ZipPath, [System.IO.Compression.ZipArchiveMode]::Create)
    try {
        Get-ChildItem -LiteralPath $sourceRoot -Recurse -File | ForEach-Object {
            $fullPath = $_.FullName
            $relative = $fullPath.Substring($parentRoot.Length).TrimStart('\', '/')
            $entryName = $relative -replace '\\', '/'
            [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
                $zip,
                $fullPath,
                $entryName,
                [System.IO.Compression.CompressionLevel]::Optimal
            ) | Out-Null
        }
    } finally {
        $zip.Dispose()
    }
}

# Import models persist loaded data in SemanticModel/.pbi/cache.abf. Shipping it shows numbers
# before Refresh; recipients should open empty and load from source after Refresh.
if (-not $KeepModelCache) {
    Get-ChildItem -LiteralPath $SourceDir -Filter "cache.abf" -Recurse -File -ErrorAction SilentlyContinue |
        Where-Object { $_.Directory.Name -eq ".pbi" } |
        ForEach-Object {
            Remove-Item -LiteralPath $_.FullName -Force
            Write-Host "Removed model import cache: $($_.FullName)"
        }
}

New-CanonicalZipFromFolder -FolderPath $SourceDir -ZipPath $latestZip

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
