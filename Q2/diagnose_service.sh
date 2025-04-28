#!/bin/bash
# filepath: dns-network-troubleshooting/scripts/diagnose_service.sh

echo "Diagnosing service reachability..." > ../outputs/service_reachability.txt

# Resolve the IP address of the service
resolved_ip=$(nslookup internal.example.com | grep "Address" | tail -n 1 | awk '{print $2}')
echo "Resolved IP Address: $resolved_ip" >> ../outputs/service_reachability.txt

# Check if the service is reachable on port 80
echo -e "\nChecking port 80 (HTTP):" >> ../outputs/service_reachability.txt
curl -I http://internal.example.com >> ../outputs/service_reachability.txt 2>&1

# Check if the service is reachable on port 443
echo -e "\nChecking port 443 (HTTPS):" >> ../outputs/service_reachability.txt
curl -I https://internal.example.com >> ../outputs/service_reachability.txt 2>&1

# Check if the service is listening locally
echo -e "\nChecking if the service is listening locally on ports 80 and 443:" >> ../outputs/service_reachability.txt
netstat -tuln | grep -E '80|443' >> ../outputs/service_reachability.txt 2>&1

echo "Service reachability diagnosis completed. Results saved to outputs/service_reachability.txt."
