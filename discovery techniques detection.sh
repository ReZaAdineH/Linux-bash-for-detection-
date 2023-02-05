#!/bin/bash

# Check for system and network information gathering commands
ps -ef | grep -E "(ifconfig|ip|arp|netstat|route|nslookup|dig|host|ss|lsof|lspci|lsusb|lscpu|df|free|top|uname|cat /proc/cpuinfo|cat /proc/meminfo|cat /etc/issue|cat /etc/passwd|cat /etc/shadow|cat /etc/group|cat /etc/services)" >> /var/log/discovery_system_and_network_info_gathering.log

# Check for system and network reconnaissance tools
ps -ef | grep -E "(nmap|zenmap|nessus|nikto|wireshark|tcpdump|dsniff|ngrep|hping|fping|ping|traceroute|tcptraceroute|whois|nslookup|dig|host|ss|lsof|lspci|lsusb|lscpu|df|free|top|uname|cat /proc/cpuinfo|cat /proc/meminfo|cat /etc/issue|cat /etc/passwd|cat /etc/shadow|cat /etc/group|cat /etc/services)" >> /var/log/discovery_system_and_network_recon_tools.log

# Check for processes listening on network ports
netstat -tulnp >> /var/log/discovery_listening_network_ports.log

# Check for open network ports
nmap -sS -O localhost >> /var/log/discovery_open_network_ports.log

# Check for recently modified files in /etc/
find /etc/ -type f -mtime -3 >> /var/log/discovery_recently_modified_files.log

# Check for users with UID 0 (root)
awk -F: '($3 == 0) {print}' /etc/passwd >> /var/log/discovery_users_with_uid_0.log

# Check for users with empty password
awk -F: '($2 == "") {print}' /etc/shadow >> /var/log/discovery_users_with_empty_password.log

