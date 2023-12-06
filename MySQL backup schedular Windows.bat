rem archive password
set encryption_password=WePlan#Ara22)#DiV@

rem path to backup compression utility
set seven_zip_path=C:\Program Files\7-Zip\

rem backup file name generation
set pib_linespay_com=pib_linespay_com-%DATE:~-4%-%DATE:~4,2%-%DATE:~7,2%-%time::=.%
set prism_cas=prism_cas-%DATE:~-4%-%DATE:~4,2%-%DATE:~7,2%-%time::=.%

rem backup creation
mysqldump -uweplan -p"WePlan#Ara22)#DiV@" pib_linespay_com > %pib_linespay_com%.sql
mysqldump -uweplan -p"WePlan#Ara22)#DiV@" prism_cas > %prism_cas%.sql

rem backup compression
"%seven_zip_path%7z" a -p%encryption_password% %pib_linespay_com%.zip %pib_linespay_com%.sql
"%seven_zip_path%7z" a -p%encryption_password% %prism_cas%.zip %prism_cas%.sql


rem delete temporary .sql file
del %pib_linespay_com%.sql
del %prism_cas%.sql

ForFiles /p "C:\we_plan_db_backup" /s /d -7 /c "cmd /c del %pib_linespay_com%"
ForFiles /p "C:\we_plan_db_backup" /s /d -7 /c "cmd /c del %prism_cas%"
