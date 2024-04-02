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
      MYSQL_DATABASE: "${DB_NAME}"
      MYSQL_USER: "${DB_USER}"
      MYSQL_PASSWORD: "${DB_PASSWORD}"
      MYSQL_RANDOM_ROOT_PASSWORD: 'yes'
      CRON_INTERVAL: "0 23 * * *"
    entrypoint: [ "sh", "/scripts/run.sh" ]
    volumes:
      - ./db_data:/var/lib/mysql
      - ./backup:/backup
    image: uniwuezpd/mariadb-backup:11.1.4

```
