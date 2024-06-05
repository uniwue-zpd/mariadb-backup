# mariadb-backup
Simple Docker container for periodically creating MariaDB backups.

## Example Usage
```
version: '3'
services:
  database:
    image: mariadb:11.1.4
    environment:
      MYSQL_DATABASE: "${DB_NAME}"
      MYSQL_USER: "${DB_USER}"
      MYSQL_PASSWORD: "${DB_PASSWORD}"
      MYSQL_RANDOM_ROOT_PASSWORD: 'yes'
    volumes:
      - ./db_data:/var/lib/mysql
  backup:
    environment:
      MYSQL_HOST: "${DB_HOST}"
      MYSQL_DATABASE: "${DB_NAME}"
      MYSQL_USER: "${DB_USER}"
      MYSQL_PASSWORD: "${DB_PASSWORD}"
      MYSQL_RANDOM_ROOT_PASSWORD: 'yes'
      CRON_INTERVAL: "0 23 * * *"
    entrypoint: [ "sh", "/scripts/run.sh" ]
    volumes:
      - ./backup:/backup
    image: uniwuezpd/mariadb-backup:11.1.4
    depends_on:
      - database
    links:
      - database
```

## Restoring backups
To restore a backup simply mount the backup as volume of the main database container to `/docker-entrypoint-initdb.d/datadump.sql`.
