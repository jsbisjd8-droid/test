#!/bin/bash

service mariadb start 

pwd=$(cat /run/secrets/db_pwd)

echo "CREATE DATABASE IF NOT EXISTS $db1_name ;" > db1.sql
echo "CREATE USER IF NOT EXISTS '$db1_user'@'%' IDENTIFIED BY '$pwd' ;" >> db1.sql
echo "GRANT ALL PRIVILEGES ON $db1_name.* TO '$db1_user'@'%' ;" >> db1.sql
echo "FLUSH PRIVILEGES;" >> db1.sql

mariadb < db1.sql

kill -9 "$(cat /run/mysqld/mysqld.pid)"

exec mariadbd --user=mysql