#/bin/bash
source db_setup.sh
CURRENT_USER=$(whoami)

if [ "$CURRENT_USER" == "root" ]; then
  echo "You must not be root to run this script"
  exit 1
fi

if [ ! -d $MYSQL_BACKUP_DIR ]; then
  echo "Backup directory $MYSQL_BACKUP_DIR does not exist"
  exit 1
fi

TEMP_BACKUP_FILES=`ls -1 $TEMP_BACKUP_DIR/*.mysql`
CURRENT_DATE=$(date +"%Y-%m-%d")

for file in $TEMP_BACKUP_FILES
do
	FOLDER_NAME=`basename $file | sed 's/.mysql$//'`

	if [ ! -d $MYSQL_BACKUP_DIR/$FOLDER_NAME ]; then
		echo "Creating directory $MYSQL_BACKUP_DIR/$FOLDER_NAME"
		mkdir $MYSQL_BACKUP_DIR/$FOLDER_NAME
	fi
	
	mv $file $MYSQL_BACKUP_DIR/$FOLDER_NAME/$FOLDER_NAME-$CURRENT_DATE.sql
	gzip $MYSQL_BACKUP_DIR/$FOLDER_NAME/$FOLDER_NAME-$CURRENT_DATE.sql
done
