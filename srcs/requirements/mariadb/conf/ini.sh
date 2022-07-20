# set -e pour exit if we have non-zero exit code
# set -x pour debugger

#------------WAITING FOR SERVER------------#
service mysql start
while ! mysqladmin ping; do
	sleep 2
done

#we will enter the mysql to configurate user and create the Wordpress database
#------------CREATE DATABASE------------#
mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE};"

#------------CREATE USER------------#
#1 - ADMIN
mysql -u root -e "CREATE USER IF NOT EXISTS '${MARIADB_ADMIN}'@'%' IDENTIFIED BY '${MARIADB_ADMIN_PASSWORD}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '${MARIADB_ADMIN}'@'%';"
#2 - USER (login42)
mysql -u root -e "CREATE USER '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_USERPASSWORD}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'%';"

#------------DELETE USER------------#
#We don't need root anymore because we have ADMIN with all right
mysql -u root -e "DELETE FROM mysql.user WHERE user='';"   #delete anonymous user
mysql -u root -e "DELETE FROM mysql.user WHERE user='root';"

#------------RELOAD ALL USERS RULES------------#
mysql -u root -e "FLUSH PRIVILEGES;" #reload all user rules

#------------RELOAD MYSQL------------#
killall mysqld

exec "$@"


#------------INDEX------------#
#mysql -u root -e
#stand for mysql --user root --execute

#------------INTERACTION------------#
# 1- connection
# Since we have delete root we have to connect with admin
# mysql -u flad -p  (then the pw) flad_pwd
# 2- The database
# show databases;
# use wordpress;
# show tables;
# from wp_users;
