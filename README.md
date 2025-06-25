# mariadb-backup

A lightweight Docker container for automated MariaDB database backups. The container runs a cron job to create periodic database dumps.

## Features

- Automated backups using cron
- Configurable backup schedule
- Compatible with MariaDB 11.8.2 (LTS)
- Built-in health monitoring
- Daily backups organized in date-based folders
- Simple integration with existing MariaDB containers

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| MYSQL_HOST | MariaDB host | database |
| MYSQL_DATABASE | Database name to backup | - |
| MYSQL_USER | Database user | - |
| MYSQL_PASSWORD | Database password | - |
| CRON_INTERVAL | Backup schedule in cron format | 00 23 * * * |

## Example Usage
### Install from the command line
`$ docker pull ghcr.io/uniwue-zpd/mariadb-backup:11.8.2`
### Use as base image in Dockerfile:
`FROM ghcr.io/uniwue-zpd/mariadb-backup:11.8.2`
### Use in Docker Compose setup:
```yaml
services:
    database:
      image: mariadb:11.8.2
      environment:
        MYSQL_DATABASE: "${DB_NAME}"
        MYSQL_USER: "${DB_USER}"
        MYSQL_PASSWORD: "${DB_PASSWORD}"
        MYSQL_RANDOM_ROOT_PASSWORD: 'yes'
      volumes:
        - ./db_data:/var/lib/mysql

    backup:
      image: uniwuezpd/mariadb-backup:11.8.2
      environment:
        MYSQL_HOST: "database"
        MYSQL_DATABASE: "${DB_NAME}"
        MYSQL_USER: "${DB_USER}"
        MYSQL_PASSWORD: "${DB_PASSWORD}"
        CRON_INTERVAL: "0 23 * * *"  # Run every day at 23:00
      volumes:
        - ./backup:/backup
      depends_on:
        - database
```
## Backup Structure

Backups are organized in date-based folders under the `/backup` directory:
```

/backup/
└── 2025-06-25/
    └── backup-230000.sql
```
## Restoring Backups

To restore a backup, mount it to the MariaDB container's init directory:
```yaml
  services:
    database:
      image: mariadb:11.8.2
    volumes:
      - ./backup/2025-06-25/backup-230000.sql:/docker-entrypoint-initdb.d/datadump.sql
```
## Health Monitoring

The container includes a health check that monitors the cron service:
- Interval: 1 minute
- Timeout: 10 seconds
- Retries: 3

## Notes

- Backups are created using `mariadb-dump` with table locking enabled
- Each backup is stored in an individual file named with timestamp
- Logs are written to `/mysql_backup.log` inside the container
- Container requires write access to the backup volume
