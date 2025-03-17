@echo off
:: Set the date and time for the backup filename
for /f "tokens=1-4 delims=/ " %%a in ('date /t') do (
  set day=%%a
  set month=%%b
  set year=%%c
)
for /f "tokens=1-2 delims=: " %%a in ('time /t') do (
  set hour=%%a
  set minute=%%b
)

:: Format date and time for the filename
set timestamp=%year%-%month%-%day%_%hour%-%minute%

:: Set MySQL user credentials
set MYSQL_USER=user_name
set MYSQL_PASSWORD=pass_word

:: Set database names and backup directory
set DATABASE_NAME_1=db_name_1
set DATABASE_NAME_2=db_name_2
set BACKUP_DIR=C:\directory

:: Create backup for the first database
mysqldump -u %MYSQL_USER% -p%MYSQL_PASSWORD% %DATABASE_NAME_1% > %BACKUP_DIR%\plan_linespay_%timestamp%.sql

:: Create backup for the second database
mysqldump -u %MYSQL_USER% -p%MYSQL_PASSWORD% %DATABASE_NAME_2% > %BACKUP_DIR%\prism_cas_%timestamp%.sql

:: Zip the backup files
powershell Compress-Archive -Path %BACKUP_DIR%\plan_linespay_%timestamp%.sql -DestinationPath %BACKUP_DIR%\plan_linespay_%timestamp%.zip
powershell Compress-Archive -Path %BACKUP_DIR%\prism_cas_%timestamp%.sql -DestinationPath %BACKUP_DIR%\prism_cas_%timestamp%.zip

:: Delete the SQL files after zipping
del %BACKUP_DIR%\plan_linespay_%timestamp%.sql
del %BACKUP_DIR%\prism_cas_%timestamp%.sql

:: Delete backups older than 7 days
forfiles /p %BACKUP_DIR% /m *.zip /d -7 /c "cmd /c del @path"

:: Display a completion message
echo Backup and compression complete!

:: Auto close the terminal window
exit
