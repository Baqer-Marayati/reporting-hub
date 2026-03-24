param(
    [Parameter(Mandatory = $true)]
    [string]$ArchiveDir,
    [int]$Keep = 20
)

$ErrorActionPreference = "Stop"

if (!(Test-Path $ArchiveDir)) {
    Write-Host "Archive directory not found, nothing to prune: $ArchiveDir"
    exit 0
}

$files = Get-ChildItem -Path $ArchiveDir -Filter "*.zip" -File | Sort-Object LastWriteTime -Descending
if ($files.Count -le $Keep) {
    Write-Host "No pruning needed. Found $($files.Count), keep $Keep."
    exit 0
}

$toRemove = $files | Select-Object -Skip $Keep
foreach ($file in $toRemove) {
    Remove-Item -Path $file.FullName -Force
    Write-Host "Removed $($file.Name)"
}

Write-Host "Pruned $($toRemove.Count) archive file(s)."
