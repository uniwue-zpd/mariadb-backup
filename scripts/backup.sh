#!/bin/sh
DATE=$(date +%F)
mkdir -p /backup/${DATE}
echo "[$(date +%T)] Dumping database ${DB_NAME} into /backup/${DATE}/dump.sql" >> /mysql_backup.log
mariadb-dump --user=$DB_USER --password=$DB_PASSWORD --lock-tables --databases $DB_NAME --log-errors=/mysql_backup.log > /backup/${DATE}/dump.sql
echo "[$(date +%T)] Database dump finished" >> /mysql_backup.log
