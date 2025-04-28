param (
    [string]$SearchString,
    [string]$FilePath,
    [switch]$ShowLineNumbers,
    [switch]$InvertMatch
)

# Function to display usage information
function Show-Usage {
    Write-Host "Usage: .\mygrep.ps1 -SearchString <string> -FilePath <path> [-ShowLineNumbers] [-InvertMatch]"
    Write-Host "Options:"
    Write-Host "  -ShowLineNumbers    Show line numbers for each match"
    Write-Host "  -InvertMatch        Print lines that do not match"
    exit 1
}

# Validate input arguments
if (-not $SearchString -or -not $FilePath) {
    Write-Host "Error: Missing arguments."
    Show-Usage
}

# Check if file exists
if (-not (Test-Path $FilePath)) {
    Write-Host "Error: File '$FilePath' not found."
    exit 1
}

# Read the file and process each line
$LineNumber = 0
Get-Content $FilePath | ForEach-Object {
    $LineNumber++
    $Line = $_

    # Check for inverted match
    if ($InvertMatch) {
        if (-not ($Line -match $SearchString)) {
            if ($ShowLineNumbers) {
                Write-Host "${LineNumber}: $Line"
            } else {
                Write-Host "$Line"
            }
        }
    } else {
        # Normal match
        if ($Line -match $SearchString) {
            if ($ShowLineNumbers) {
                Write-Host "${LineNumber}: $Line"
            } else {
                Write-Host "$Line"
            }
        }
    }
}
