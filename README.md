# xlr-backup-restore-script

## To backup H2 Database
Copy the file `backup.sh` or `backup.cmd` to bin directory of old server directory.

Run the backup shell/batch script from the bin directory of the older installation to backup the repository and archive database.

The backup sql scripts packaged as `backup-repository.zip` and `backup-archive.zip`  will be generated in server home directory after running the backup script/cmd. 

Note: The backup script internally runs the SCRIPT command with default user(sa) and no password.
If password is configured, pass the argument `-password <password>` while invoking backup script.
## To restore H2 Database
Copy the file `restore.sh` or `restore.cmd` to bin directory of new server directory.

Copy the generated backup zip files viz.`backup-repository.zip` and `backup-archive.zip` from older server home to the new server home directory.

Run the restore shell/batch script from the bin directory of the new installation to restore the repository and archive databases to respective directories in server home directory.

Note: The restore script internally runs the RUNSCRIPT command with default user(sa) and no password. 
If password is configured, pass the argument `-password <password>` while invoking restore script.

Reference: https://h2database.com/html/tutorial.html#upgrade_backup_restore