#!/bin/bash

# Check for common exfiltration ports
netstat -tulnp | grep -E "(22|23|53|80|443|445|8080|8443|3389)" >> /var/log/exfiltration_common_ports.log

# Check for outbound connections to known exfiltration domains or IPs
netstat -an | grep -E "(1.1.1.1|2.2.2.2|example.com|example2.com)" >> /var/log/exfiltration_outbound_connections.log

# Check for common exfiltration tools
ps -ef | grep -E "(curl|wget|nc|netcat|telnet|tftp|ftp|ssh|sftp|scp|rsync|ncat|python|perl|ruby|java|powershell|bash|sh|ash|zsh|ksh|tcsh|csh)" >> /var/log/exfiltration_common_tools.log

# Check for known exfiltration file paths
find / -name "*exfil*" -type f >> /var/log/exfiltration_file_paths.log

# Check for known exfiltration user-agents in web server logs
grep -E "(exfil|data|sensitive|secret|confidential)" /var/log/nginx/*access.log >> /var/log/exfiltration_user_agents.log

# Check for known exfiltration command strings
strings /var/log/auth.log | grep -E "(exfil|data|sensitive|secret|confidential)" >> /var/log/exfiltration_command_strings.log

# Check for large files or unusual transfer patterns
lsof +L1 >> /var/log/exfiltration_large_files.log

# Check for files with high entropy
find / -exec sh -c 'file "{}" | grep -q "data"' \; -print | xargs -r -I{} sh -c 'echo -n "{} ";(cat "{}" | tr -dc "[:print:]" | tr -s " \n" " " | tr -s " " | awk "{print length, $0}")' | awk '$1>128' >> /var/log/exfiltration_high_entropy_files.log
