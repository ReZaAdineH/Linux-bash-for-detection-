#!/bin/bash

# Check for cron jobs
crontab -l >> /var/log/persistence_cron.log

# Check for systemd timers
systemctl list-timers >> /var/log/persistence_timers.log

# Check for start-up scripts in /etc/init.d and /etc/rc.d
find /etc/init.d/ /etc/rc.d/ -type f >> /var/log/persistence_init_scripts.log

# Check for start-up scripts in /usr/local/bin and /usr/local/sbin
find /usr/local/bin/ /usr/local/sbin/ -type f >> /var/log/persistence_local_scripts.log

# Check for start-up scripts in user home directories
find ~ -name ".*sh" >> /var/log/persistence_home_scripts.log

# Check for SSH authorized keys
grep -R "ssh-rsa" ~/.ssh/ >> /var/log/persistence_ssh.log

# Check for malicious scheduled tasks
schtasks /query /fo list >> /var/log/persistence_scheduled_tasks.log

# Check for malicious environment variables
printenv >> /var/log/persistence_environment_variables.log

# Check for persistence through kernel modules
lsmod >> /var/log/persistence_kernel_modules.log

# Check for persistence through open network connections
lsof -i >> /var/log/persistence_open_connections.log

# Check for persistence through open files
lsof >> /var/log/persistence_open_files.log

# Check for persistence through listening ports
netstat -anp >> /var/log/persistence_listening_ports.log

# Check for persistence through auto-start applications
find / -name "*autostart*" >> /var/log/persistence_autostart.log

# Check for persistence through persistence Linux malware
find / -name ".bash_history" -exec grep -i "download" {} \; >> /var/log/persistence_malware.log


