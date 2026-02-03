#!/bin/ash

set -e

# Create SSH config if needed
mkdir -p /root/.ssh
chmod 700 /root/.ssh

# If using secret mounted at /run/secrets/ssh_key → symlink or copy with right perms
# Option A: symlink (cleaner, no copy)
if [ -f /run/secrets/rsync_ssh_key ]; then
    ln -sf /run/secrets/rsync_ssh_key /root/.ssh/id_rsa
    chmod 600 /root/.ssh/id_rsa
fi

# Generate crontab from env
echo "${RSYNC_CRONTAB} rsync ${RSYNC_OPTIONS} > /dev/stdout 2>/dev/stderr" > /etc/crontabs/root

# Start cron (dcron example)
crond -f -L /dev/stdout