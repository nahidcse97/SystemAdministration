#!/bin/bash
backup_path="/var/www/html/"
DATE=$(date +"%m-%d-%Y-%H-%M-%S")
password="DivRApL@#4325IT%&"

for DB in $(mysql -uroot -p'DivRApL@#4325IT%&' -e 'show databases' -s --skip-column-names); do
    mysqldump -uroot -p'DivRApL@#4325IT%&' $DB > "$backup_path/$DB-$DATE.sql"
for DB in $(mysql -uroot --password=$password -e 'show databases' -s --skip-column-names); do
    mysqldump -uroot --password=$password $DB > "$backup_path/$DB-$DATE.sql"
    cd $backup_path/&&zip -r $DB-$DATE.sql.zip $DB-$DATE.sql&&rm -rf $DB-$DATE.sql;

done
