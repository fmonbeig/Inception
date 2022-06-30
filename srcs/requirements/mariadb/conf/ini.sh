#!/bin/sh

#set -e #exit if a command have an exit status 1

mysql -u root -e "CREATE DATABASE ${MYSQL_DB};"
mysql -u root -e "CREATE USER '${MYSQL_ADMIN}'@'%' IDENTIFIED BY '${MYSQL_ADMIN_PASSWORD}';"
mysql -u root -e "GRANT ALL ON *.* TO '${MYSQL_ADMIN}'@'%';"
mysql -u root -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USERPASSWORD}';"
mysql -u root -e "GRANT ALL ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
mysql -u root -e "DELETE FROM mysql.user WHERE user='root';"
mysql -u root -e "FLUSH PRIVILEGES;"
killall mysqld


# mkdir -p /var/run/mysqld && mkdir -p /run/mysqld
# chown -R mysql:root /run/mysqld && chown -R mysql:root /var/run/mysqld
