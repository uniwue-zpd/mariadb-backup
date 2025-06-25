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
