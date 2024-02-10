#/bin/bash
source db_setup.sh
CURRENT_USER=$(whoami)

UNPRIVILEGED_USER=$1

if [ -z "$UNPRIVILEGED_USER" ]; then
  echo "You must provide an unprivileged user to run this script"
  echo "Usage: $0 <unprivileged_user>"
  exit 1
fi

if [ "$CURRENT_USER" != "root" ]; then
  echo "You must be root to run this script"
  exit 1
fi


if [ ! -d $BACKUPS_DIR ]; then
  echo "Backup directory $BACKUPS_DIR does not exist"
  exit 1
fi


if [ ! -d $TEMP_BACKUP_DIR ]; then
  echo "Temp backup directory $TEMP_BACKUP_DIR does not exist"
  exit 1
fi

MYSQL_DBS=`mysql -u root -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema|mysql|sys)"`

CURRENT_DATETIME=$(date +"%Y-%m-%d-%H-%M-%S")

echo "RUNNING BACKUP FOR MYSQL DATABASES AT $CURRENT_DATETIME"

for db in $MYSQL_DBS
do
	echo "Backing up $db"
	mysqldump -u root $db > $TEMP_BACKUP_DIR/$db.mysql
	chown $UNPRIVILEGED_USER:$UNPRIVILEGED_USER $TEMP_BACKUP_DIR/$db.mysql
done



