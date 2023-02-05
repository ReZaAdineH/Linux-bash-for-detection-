#!/bin/bash

# Set variables for log files to check and keywords to look for
log_files="/var/log/auth.log /var/log/secure /var/log/syslog /var/log/messages"
keywords="bash|zsh|ksh|python|perl|ruby|gcc|make|java|javac|powershell|cmd|netcat|nc|telnet|ftpget|ftpput|tftp|nmap|nikto|dirb|gobuster|enum4linux|onesixtyone|snmp-check|snmpwalk|snmpenum|snmp-info|snmp-scan|snmp-brute|w3af|sqlmap|metasploit|msfconsole|msfvenom|msfconsole|msfconsole|msfconsole|msfconsole|msfconsole|msfconsole|msfconsole|msfconsole"

# Search for keywords in the specified log files
grep -iE $keywords $log_files >> /var/log/execution.log

# Get the IP addresses of any connections from the log entries found above
grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" /var/log/execution.log >> /var/log/execution_ips.log

# Use awk to count the number of connections from each IP address
awk '{print $1}' /var/log/execution_ips.log | sort | uniq -c >> /var/log/execution_counts.log

# check all files that have been executed in the last 24 hours
find / -type f -executable -mtime 0 >> /var/log/execution_files.log

# check all processes running on the system
ps aux >> /var/log/execution_ps.log

# check all open files and network connections
lsof -i >> /var/log/execution_lsof.log

# check for any suspicious listening ports
netstat -anp >> /var/log/execution_netstat.log

# check for any suspicious cron jobs
crontab -l >> /var/log/execution_cron.log

# check for any suspicious scheduled tasks
schtasks /query /fo list >> /var/log/execution_scheduled_tasks.log

# check for any suspicious environment variables
printenv >> /var/log/execution_env.log

# check for any suspicious processes running as root
ps aux | grep root >> /var/log/execution_root_ps.log

# check for any suspicious processes running as system
ps aux | grep system >> /var/log/execution_system_ps.log

# check for any suspicious processes running as administrator
ps aux | grep administrator >> /var/log/execution_admin_ps.log

# check for any suspicious processes running as service
ps aux | grep service >> /var/log/execution_service_ps.log

# check for any suspicious processes running as network service
ps aux | grep network >> /var/log/execution_network_ps.log
