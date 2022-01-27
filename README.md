# xlr-backup-restore-script

If Live(repository) and Archive databases are H2 DB, backup each of them seperately using backup script and restore them both individually using the restore script. If only live DB is H2 DB, its sufficient to backup and restore only the live db.

## To backup H2 Database
Copy the file `backup.sh` or `backup.cmd` to bin directory of old server directory.

Run the backup shell/batch script from the bin directory of the older installation to backup the live database.
If the archive database is also H2 and needs backup. Run the backup script with argument `-db archive`.

>Eg. To backup live H2 db, run `backup.sh` and to backup archive H2 db, run `backup.sh -db archive` 

The backup sql scripts will be generated in server home directory after running the backup script/cmd for live and archive databases. They will be packaged as `backup-repository.zip` and `backup-archive.zip` respectively.

Note: The backup script internally runs the SCRIPT command with default user(sa) and no password.
If password is configured, pass the argument `-password <password>` in the backup script.
## To restore H2 Database
Copy the file `restore.sh` or `restore.cmd` to bin directory of new server directory.

Copy the generated backup zip files viz.`backup-repository.zip` and optionally, `backup-archive.zip` from older server home to the new server home directory. 

Run the restore shell/batch script from the bin directory of the new installation to restore the repository and archive databases to respective directories in server home directory.

> Eg. To restore live H2 db, run `restore.sh` and to restore archive H2 db, run `restore.sh -db archive`

Note: The restore script internally runs the RUNSCRIPT command with default user(sa) and no password. 
If password is configured, pass the argument `-password <password>` in the restore script.

Reference: https://h2database.com/html/tutorial.html#upgrade_backup_restore