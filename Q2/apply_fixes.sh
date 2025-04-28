#!/bin/bash
# filepath: dns-network-troubleshooting/scripts/apply_fixes.sh

echo "Applying fixes..." > ../outputs/fixes_applied.txt

# Update /etc/resolv.conf with a valid DNS server
echo -e "\nUpdating DNS settings to use Google's public DNS (8.8.8.8):" >> ../outputs/fixes_applied.txt
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf >> ../outputs/fixes_applied.txt

# Allow traffic on ports 80 and 443
echo -e "\nAllowing traffic on ports 80 and 443:" >> ../outputs/fixes_applied.txt
sudo ufw allow 80 >> ../outputs/fixes_applied.txt
sudo ufw allow 443 >> ../outputs/fixes_applied.txt
sudo ufw reload >> ../outputs/fixes_applied.txt

# Restart the web service
echo -e "\nRestarting the web service (Apache or Nginx):" >> ../outputs/fixes_applied.txt
sudo systemctl restart apache2 >> ../outputs/fixes_applied.txt 2>&1 || sudo systemctl restart nginx >> ../outputs/fixes_applied.txt 2>&1

echo "Fixes applied. Results saved to outputs/fixes_applied.txt."
