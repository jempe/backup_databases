### MySQL Database Backup Script

This script is designed to backup MySQL databases using cron. It creates backups of all MySQL databases (excluding system databases) and stores them in a specified directory. The script requires to be run as root and will use an unprivileged user specified as a parameter.

---

#### Script Details
- **Script Name:** mysql_backup.sh
- **Usage:** `./mysql_backup.sh <unprivileged_user>`
- **Requirements:** 
  - Must be run as root
  - Unprivileged user must be provided as a parameter

---

#### Configuration
- **BACKUPS_DIR:** Main directory where backups will be stored (`/srv/backups`)
- **TEMP_BACKUP_DIR:** Temporary directory within `BACKUPS_DIR` to store temporary backup files
- **MYSQL_BACKUP_DIR:** Directory within `BACKUPS_DIR` to store MySQL backups
- **CURRENT_USER:** User executing the script
- **UNPRIVILEGED_USER:** Unprivileged user needed to perform the backup

---

#### Prerequisites
- Ensure that the specified backup directories exist before running the script. If they do not exist, the script will exit.
- The script requires the `mysql` command-line tool to be installed and accessible.

---

#### Backup Process
1. **Checking User Privileges:**
   - Verifies if the script is being run as `root`. If not, the script will exit.

2. **Checking Backup Directories:**
   - Verifies if the main backup directory and temporary backup directory exist. If not, the script will exit.

3. **Obtaining MySQL Databases:**
   - Retrieves a list of MySQL databases excluding system databases.

4. **Backup Execution:**
   - Performs backup for each database found.
   - For each database, a backup is created using `mysqldump` and stored in the temporary backup directory.
   - The backup file ownership is changed to the specified unprivileged user.

---

#### Usage Instructions
1. Provide execution permissions to the script: `chmod +x mysql_backup.sh`
   
2. **Cron Setup:**
   To schedule automatic backups using cron:
   - Edit the cron job configuration by running `crontab -e`
   - Add a line like the following to run the script daily at midnight:
     ```
     0 0 * * * /path/to/mysql_backup.sh <unprivileged_user>
     ```
   - Save and exit the editor to activate the cron job.

---

By following the above instructions, you can schedule regular MySQL database backups using the provided script.
