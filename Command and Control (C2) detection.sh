#!/bin/bash

# Check for common C2 ports
netstat -tulnp | grep -E "(22|23|53|80|443|445|8080|8443|3389)" >> /var/log/c2_common_ports.log

# Check for outbound connections to known C2 domains or IPs
netstat -an | grep -E "(1.1.1.1|2.2.2.2|example.com|example2.com)" >> /var/log/c2_outbound_connections.log

# Check for common C2 tools
ps -ef | grep -E "(curl|wget|nc|netcat|telnet|tftp|ftp|ssh|sftp|scp|rsync|ncat|python|perl|ruby|java|powershell|bash|sh|ash|zsh|ksh|tcsh|csh)" >> /var/log/c2_common_tools.log

# Check for known C2 command strings
strings /var/log/auth.log | grep -E "(c2|command|control|callback|beacon|tunnel|reverse|shell)" >> /var/log/c2_command_strings.log

# Check for known C2 file paths
find / -name "*c2*" -type f >> /var/log/c2_file_paths.log

# Check for known C2 user-agents in web server logs
grep -E "(c2|command|control|callback|beacon|tunnel|reverse|shell)" /var/log/nginx/*access.log >> /var/log/c2_user_agents.log
