#/bin/bash
ALLBACKUPS_DIR="/srv/backups"
POSTGRES_BACKUP_DIR="$ALLBACKUPS_DIR/postgres"
CURRENT_USER=$(whoami)


BACKUPS_DIR=$POSTGRES_BACKUP_DIR/$CURRENT_USER


if [ ! -d $BACKUPS_DIR ]; then
  echo "Backup directory $BACKUPS_DIR does not exist. Please create folder $BACKUPS_DIR"
  exit 1
fi

CURRENT_DATE=$(date +"%Y-%m-%d")
CURRENT_DATETIME=$(date +"%Y-%m-%d %H:%M:%S")

echo "RUNNING BACKUP FOR POSTGRES DATABASE $CURRENT_USER AT $CURRENT_DATETIME"

LATEST_BACKUP_LINK=$BACKUPS_DIR/latest.pg_dump.gz

BACKUP_FILE=$BACKUPS_DIR/$CURRENT_USER-$CURRENT_DATE.pg_dump

pg_dump -Fc --username="$CURRENT_USER" --dbname="$CURRENT_USER" > $BACKUP_FILE

gzip $BACKUP_FILE

if [ -f $LATEST_BACKUP_LINK ]; then
  unlink $LATEST_BACKUP_LINK
fi

ln -s $BACKUP_FILE.gz $LATEST_BACKUP_LINK
