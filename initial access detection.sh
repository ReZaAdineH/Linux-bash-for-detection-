#!/bin/bash

# Set variables for log files to check and keywords to look for
log_files="/var/log/auth.log /var/log/secure /var/log/syslog"
keywords="sshd|sudo|su|su -|ssh|scp|rsync|sftp|nc|telnet|ftp"

# Search for keywords in the specified log files
grep -iE $keywords $log_files >> /var/log/initial_access.log

# Get the IP addresses of any connections from the log entries found above
grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" /var/log/initial_access.log >> /var/log/initial_access_ips.log

# Use awk to count the number of connections from each IP address
awk '{print $1}' /var/log/initial_access_ips.log | sort | uniq -c >> /var/log/initial_access_counts.log

# Use netstat to check for any active connections or listening ports on the system
netstat -anp >> /var/log/initial_access_netstat.log

# Use lsof to check for any open files or network connections on the system
lsof -i >> /var/log/initial_access_lsof.log

# Use ps to check for any suspicious processes running on the system
ps aux >> /var/log/initial_access_ps.log

# Compare the IPs and the connections count with the normal behavior of the system
# For this you can use some tools like elk or splunk for analyzing the logs
