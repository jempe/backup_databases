# PostgreSQL Backup Script

This bash script `postgres_backup.sh` is designed to be used as a cron job to automate the backup process for a PostgreSQL database.

## Installation

1. Download the `postgres_backup.sh` script to your desired directory.
2. Make the script executable by running:
   ```sh
   chmod +x postgres_backup.sh
   ```
3. Create the necessary folder structure for backups. By default:
   - Backup directory: `/srv/backups/postgres/<CURRENT_USER>`
   - The backup will be stored in the format `<CURRENT_USER>-<DATE>.pg_dump`

## Before Running the Script

Ensure the following steps are completed before running the script:
1. Set the appropriate permissions for the backup directory:
   ```sh
   chown <user>:<group> /srv/backups/postgres/<CURRENT_USER>
   ```
   
2. Update the `crontab` to schedule the backup as needed:
   ```sh
   0 3 * * * /path/to/postgres_backup.sh
   ```

## Usage

The script performs the following actions:
1. Checks if the backup directory exists, if not, it prompts to create the directory and xits.
2. Generates a unique timestamp for naming the backup file.
3. Initiates the backup process for the PostgreSQL database using `pg_dump`.
4. Creates a symbolic link `latest.pg_dump` to the latest backup file in the directory.

## Cron Job Example

To run this script daily at 3:00 AM, you can add the following entry to your crontab configuration:
```sh
0 3 * * * /path/to/postgres_backup.sh
```

Make sure to customize the CRON schedule according to your backup requirements.

**Note**: Ensure that the necessary PostgreSQL permissions are set for the user running this script to perform database backups.

Feel free to modify the script as needed to adapt it to your specific PostgreSQL backup requirements.e
