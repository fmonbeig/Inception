#!/bin/sh

set -x #for more information in terminal

#Myconf.cnf have already been configured
#we will enter the mysql to configurate user and create the Wordpress database
mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
mysql -u root -e "CREATE USER IF NOT EXISTS '${MYSQL_ADMIN}'@'%' IDENTIFIED BY '${MYSQL_ADMIN_PASSWORD}';"
mysql -u root -e "GRANT ALL ON *.* TO '${MYSQL_ADMIN}'@'%';"
mysql -u root -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USERPASSWORD}';"
mysql -u root -e "GRANT ALL ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
mysql -u root -e "FLUSH PRIVILEGES;" #reload all user rules
killall mysqld						# kill mysqld

mysqld #launch mysql server
