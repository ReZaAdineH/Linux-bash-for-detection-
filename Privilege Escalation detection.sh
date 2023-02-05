#!/bin/bash

# Check for setuid and setgid files
find / -type f \( -perm -4000 -o -perm -2000 \) -exec ls -la {} \; >> /var/log/privilege_escalation_setuid_setgid.log

# Check for world-writable files
find / -type f -perm -0002 -exec ls -la {} \; >> /var/log/privilege_escalation_world_writable.log

# Check for world-writable directories
find / -type d -perm -0002 -exec ls -ld {} \; >> /var/log/privilege_escalation_world_writable_directories.log

# Check for SUID files with known vulnerabilities
find / -type f -perm -4000 -exec grep -l "exploit" {} \; >> /var/log/privilege_escalation_known_vulnerabilities.log

# Check for the presence of the 'sudo' command
which sudo >> /var/log/privilege_escalation_sudo.log

# Check for the presence of the 'su' command
which su >> /var/log/privilege_escalation_su.log

# Check for the presence of the 'pkexec' command
which pkexec >> /var/log/privilege_escalation_pkexec.log

# Check for the presence of the 'runuser' command
which runuser >> /var/log/privilege_escalation_runuser.log

# Check for the presence of the 'doas' command
which doas >> /var/log/privilege_escalation_doas.log

# Check for the presence of the 'sudoedit' command
which sudoedit >> /var/log/privilege_escalation_sudoedit.log

# Check for the presence of the 'sudoreplay' command
which sudoreplay >> /var/log/privilege_escalation_sudoreplay.log

# Check for the presence of the 'sudosu' command
which sudosu >> /var/log/privilege_escalation_sudosu.log

# Check for the presence of the 'sudo-i' command
which sudo-i >> /var/log/privilege_escalation_sudo-i.log

# Check for the presence of the 'sudo-s' command
which sudo-s >> /var/log/privilege_escalation_sudo-s.log

