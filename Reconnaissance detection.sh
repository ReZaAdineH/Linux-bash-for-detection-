#!/bin/bash

# Set variables for log files to check and keywords to look for
log_files="/var/log/auth.log /var/log/secure /var/log/syslog /var/log/messages"
keywords="nmap|nikto|dirb|gobuster|enum4linux|onesixtyone|snmp-check|snmpwalk|snmpenum|snmp-info|snmp-scan|snmp-brute|nc|wget|curl|w3af|sqlmap|metasploit|msfconsole"

# Search for keywords in the specified log files
grep -iE $keywords $log_files >> /var/log/recon.log

# Get the IP addresses of any connections from the log entries found above
grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" /var/log/recon.log >> /var/log/recon_ips.log

# Use awk to count the number of connections from each IP address
awk '{print $1}' /var/log/recon_ips.log | sort | uniq -c >> /var/log/recon_counts.log

# Use netstat to check for any active connections or listening ports on the system
netstat -anp >> /var/log/recon_netstat.log

# Use lsof to check for any open files or network connections on the system
lsof -i >> /var/log/recon_lsof.log

# Use ps to check for any suspicious processes running on the system
ps aux >> /var/log/recon_ps.log

# Use last command to check for recent login activity
last >> /var/log/recon_last.log

# Use the iptables command to check for any suspicious incoming or outgoing traffic
iptables -L -n -v >> /var/log/recon_iptables.log

# Use the dnsmasq log to check for any suspicious dns requests
cat /var/log/dnsmasq.log >> /var/log/recon_dnsmasq.log

# Use the arp command to check for any suspicious arp requests
arp -a >> /var/log/recon_arp.log

# Compare the IPs and the connections count with the normal behavior of the system
# For this you can use some tools like elk or splunk for analyzing the logs
