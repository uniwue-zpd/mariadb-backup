#!/bin/bash
touch /mysql_backup.log
echo "${CRON_INTERVAL} sh /scripts/backup.sh" > /etc/cron.d/smw-cron
chmod 0644 /etc/cron.d/smw-cron
crontab /etc/cron.d/smw-cron

printenv | grep -v "no_proxy" >> /etc/environment

cron && tail -f /mysql_backup.log
