#!/bin/bash

# Check for files containing sensitive information
grep -r -i -E "(password|secret|key|token|credentials)" /etc/ >> /var/log/credential_access_sensitive_files.log

# Check for recently modified files in /etc/
find /etc/ -type f -mtime -3 >> /var/log/credential_access_recently_modified_files.log

# Check for active SSH connections
netstat -tulnp | grep ssh >> /var/log/credential_access_active_ssh_connections.log

# Check for failed SSH login attempts
grep -i "Failed password" /var/log/auth.log >> /var/log/credential_access_failed_ssh_logins.log

# Check for successful SSH login attempts
grep -i "Accepted password" /var/log/auth.log >> /var/log/credential_access_successful_ssh_logins.log

# Check for users with UID 0 (root)
awk -F: '($3 == 0) {print}' /etc/passwd >> /var/log/credential_access_users_with_uid_0.log

# Check for users with empty password
awk -F: '($2 == "") {print}' /etc/shadow >> /var/log/credential_access_users_with_empty_password.log

