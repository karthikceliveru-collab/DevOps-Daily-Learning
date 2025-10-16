param(
    [Parameter(Mandatory=$true)]
    [string]$Topic
)

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$repo = Split-Path -Parent $root
$daily = Join-Path $repo "daily_logs"

if (!(Test-Path $daily)) {
    New-Item -ItemType Directory -Path $daily | Out-Null
}

$today = Get-Date -Format "yyyy-MM-dd"
$dayFile = Join-Path $daily "day-$today.md"

if (Test-Path $dayFile) {
    Write-Host "Today's file already exists: $dayFile"
} else {
    @"
# Day $(Get-Date -Format "d") — $today

## 🧠 Topic
$Topic

## 🤖 AI Support Used
- ChatGPT: (What did you ask? What answer helped?)

## ✅ What I Did
- 

## 📝 Notes
- 

## 🔗 Resources
- 
"@ | Out-File -FilePath $dayFile -Encoding UTF8
    Write-Host "Created $dayFile"
}

# Append to README table
$readme = Join-Path $repo "README.md"
if (Test-Path $readme) {
    $line = "|  | $today | $Topic | ChatGPT assistance | |"
    Add-Content -Path $readme -Value $line
    Write-Host "Updated README.md with today's entry placeholder."
} else {
    Write-Host "README.md not found."
}
