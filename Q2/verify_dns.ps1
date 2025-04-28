# Output file path
$outputFile = "../outputs/dns_resolution.txt"

# Ensure the outputs directory exists
if (-not (Test-Path "../outputs")) {
    New-Item -ItemType Directory -Path "../outputs" | Out-Null
}

# Start DNS verification
"Verifying DNS resolution..." | Out-File -FilePath $outputFile

# Check the current DNS resolver
"System DNS Resolver (Get-DnsClientServerAddress):" | Out-File -FilePath $outputFile -Append
try {
    Get-DnsClientServerAddress | Out-File -FilePath $outputFile -Append
} catch {
    "Error: Unable to retrieve DNS resolver information." | Out-File -FilePath $outputFile -Append
}

# Test DNS resolution using the system's DNS
"`nTesting DNS resolution using system DNS:" | Out-File -FilePath $outputFile -Append
try {
    Resolve-DnsName internal.example.com | Out-File -FilePath $outputFile -Append
} catch {
    "Error: Unable to resolve internal.example.com using system DNS. DNS name does not exist." | Out-File -FilePath $outputFile -Append
}

# Test DNS resolution using Google's public DNS
"`nTesting DNS resolution using Google's public DNS (8.8.8.8):" | Out-File -FilePath $outputFile -Append
try {
    Resolve-DnsName internal.example.com -Server 8.8.8.8 | Out-File -FilePath $outputFile -Append
} catch {
    "Error: Unable to resolve internal.example.com using Google's public DNS. DNS name does not exist." | Out-File -FilePath $outputFile -Append
}

# Completion message
"DNS resolution verification completed. Results saved to outputs/dns_resolution.txt." | Out-Host
