#!/bin/bash

# Check for hidden files and directories
find / -name ".*" -ls >> /var/log/defense_evasion_hidden_files_directories.log

# Check for processes running under a different name
ps -ef | awk '{print $8}' | sort -u >> /var/log/defense_evasion_process_name_changes.log

# Check for processes running under a different user
ps -ef | awk '{print $1}' | sort -u >> /var/log/defense_evasion_process_user_changes.log

# Check for running processes with a suspicious process name
ps -ef | grep -i -E "(nc|wget|curl|tftp|ftp|bash|sh|ssh|telnet|netcat|python|perl|ruby|lua|irb|nmap)" >> /var/log/defense_evasion_suspicious_process_names.log

# Check for running processes with a suspicious arguments
ps -ef | grep -v grep | grep -i -E "(-e|-c|-i|-t|-r|-n|-s|-p|-h|-l|-L|-u|-U|-x|-X|-y|-Y|-z|-Z|-a|-A|-b|-B|-d|-D|-f|-F|-g|-G|-j|-J|-k|-K|-m|-M|-o|-O|-q|-Q|-v|-V|-w|-W|-x|-X|-y|-Y|-z|-Z)" >> /var/log/defense_evasion_suspicious_process_arguments.log

# Check for running processes with a suspicious parent process
ps -ef | awk '{print $3}' | sort -u >> /var/log/defense_evasion_suspicious_parent_process.log

# Check for running processes with a suspicious binary path
find / -type f -name "*.bin" -o -name "*.run" -o -name "*.sh" -o -name "*.csh" -o -name "*.pl" -o -name "*.py" -o -name "*.rb" -o -name "*.lua" -o -name "*.irb" -o -name "*.nmap" -exec ls -la {} \; >> /var/log/defense_evasion_suspicious_binary_path.log

