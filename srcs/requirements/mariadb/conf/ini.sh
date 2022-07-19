# # until we do not get a functional service from mariadb we sleep and run sql in background
# #Then ping test the host availability

# # set -e pour exit if we have non-zero exit code
# # set -x pour debugger

# service mysql start
# while ! mysqladmin ping; do
# 	sleep 2
# done

# # echo "Creating new Mariadb database"
# mysql --user root --execute "CREATE DATABASE ${MARIADB_DATABASE};"

# # echo "Granting ALL privileges on ${MARIADB_DATABASE} to ${MARIADB_ADMIN}!"
# mysql --user root --execute "CREATE USER '${MARIADB_ADMIN}'@'%' IDENTIFIED BY '${MARIADB_ADMIN_PASSWORD}';" #(1)
# mysql --user root --execute "GRANT ALL PRIVILEGES ON *.* TO '${MARIADB_ADMIN}'@'%';"

# # echo "Granting ALL privileges on ${MARIADB_DATABASE} to ${MARIADB_ADMIN}!"
# mysql --user root --execute "CREATE USER '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_USERPASSWORD}';"
# mysql -u root --execute "GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'%';"


# # echo "DROP/DELETE anonymous users from  ${MARIADB_DATABASE}!" # In default installation we can have anonymous users
# mysql --user root --execute "DELETE FROM mysql.user WHERE user='';"

# # echo "DROP/DELETE root from  ${MARIADB_DATABASE}!" otherwise we can still connect with root without password
# #mysql -u root -e "DELETE FROM mysql.user WHERE user='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
# #mysql -u root -e "DELETE FROM mysql.user WHERE user='root' OR Host NOT IN ('localhost', '127.0.0.1', '::1');"
# mysql --user root --execute "DELETE FROM mysql.user WHERE user='root';"


# # echo "Indicate to the server to reload all tables and apply modifications ${MARIADB_DATABASE}!"
# mysql --user root --execute "FLUSH PRIVILEGES;"

# # Here we kill to restart otherwise because mysql is not executed so need to restart (1)
# killall mysqld

# # To make sure that the final binary receive all informations (3)
# exec "$@"

# # User creation(1): https://www.digitalocean.com/community/tutorials/comment-installer-mysql-sur-ubuntu-18-04-fr
# # *.* is on all database, otherwise druid.* can be possible for a specific tables of a DB
# # Why using delete rather than drop ? : https://bugs.mysql.com/bug.php?id=62255
# # exec :https://stackoverflow.com/questions/39082768/what-does-set-e-and-exec-do-for-docker-entrypoint-scripts &&
# # https://runebook.dev/fr/docs/docker/engine/reference/builder/index


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
# SHOW DATABASES;
