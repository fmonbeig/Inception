#!/bin/sh

#set -e #Exit if we have a non-zero after a CMD
#set -x #for more information in terminal(debugg)

#First we have to launch mysql then we sleep until the server is available
#The command "mysqladmin ping" return 0 when the server is up
#https://dev.mysql.com/doc/refman/8.0/en/mysqladmin.html

#------------WAITING FOR SERVER------------#
service mysql start
while ! mysqladmin ping; do
	sleep 2
done

#we will enter the mysql to configurate user and create the Wordpress database
#------------CREATE DATABASE------------#
mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"

#------------CREATE USER------------#
#1 - ADMIN
mysql -u root -e "CREATE USER IF NOT EXISTS '${MYSQL_ADMIN}'@'%' IDENTIFIED BY '${MYSQL_ADMIN_PASSWORD}';"
mysql -u root -e "GRANT ALL ON *.* TO '${MYSQL_ADMIN}'@'%';"
#2 - USER (login42)
mysql -u root -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USERPASSWORD}';"
mysql -u root -e "GRANT ALL ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"

#------------DELETE USER------------#
#We don't need root anymore because we have ADMIN with all right
mysql -u root -e "DELETE FROM mysql.user WHERE user='';"
mysql -u root -e "DELETE FROM mysql.user WHERE user='root';"

#------------RELOAD ALL USERS RULES------------#
mysql -u root -e "FLUSH PRIVILEGES;" #reload all user rules

#------------RELOAD MYSQL------------#
killall mysqld
mysqld

#mysql -u root -e
#stand for mysql --user root --execute
