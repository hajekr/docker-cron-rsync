# Docker cron rsync

- Dockerized rsync backup to e.g., NAS.
- SSH key is mounted as a secret.

```yaml
version: "3.9"

services:
  rsync:
    image: romanhajek/cron-rsync
    secrets:
      - source: rsync-ssh-key
        target: /run/secrets/rsync-ssh-key
        mode: 0600
    environment:
      RSYNC_CRONTAB: "*/15 * * * *"
      RSYNC_OPTIONS: >-
        --archive --verbose --delete --copy-links
        -e "ssh -i /run/secrets/rsync-ssh-key -o StrictHostKeyChecking=accept-new -o UserKnownHostsFile=/dev/null -o WarnWeakCrypto=no"
        /backup/ user@nas:backup/
    volumes:
      - /dir-to-backup:/backup

secrets:
  rsync-ssh-key:
    external: true
```
