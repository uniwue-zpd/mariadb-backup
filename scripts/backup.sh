#!/bin/bash
if [ -f /etc/cron.env ]; then
    . /etc/cron.env
fi

DATE=$(date +"%F")
NOW=$(date +"%H%M%S")
MARIADB_DUMP=$(which mariadb-dump)
GZIP=$(which gzip)
BACKUP_FOLDER=/backup/${DATE}

[ ! -d "${BACKUP_FOLDER}" ] && mkdir --parents ${BACKUP_FOLDER}
FILE=${BACKUP_FOLDER}/backup-${NOW}.sql

echo "[$(date +%T)] Dumping database ${MYSQL_DATABASE} into ${FILE}..." >> /mysql_backup.log
${MARIADB_DUMP} -h ${MYSQL_HOST} -u ${MYSQL_USER} -p"${MYSQL_PASSWORD}" --lock-tables --databases ${MYSQL_DATABASE} > $FILE
