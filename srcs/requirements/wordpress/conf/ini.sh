# mkdir -p /var/www/html
# cd /var/www/html/
# wp core download --allow-root
# while ! mysqladmin -hmariadb -u${MARIADB_USER} -p${MARIADB_USERPASSWORD} ping; do
# 	sleep 2
# done
# wp config create --dbname=${MARIADB_DATABASE} --dbuser=${MARIADB_USER} --dbpass=${MARIADB_USERPASSWORD} --dbhost=mariadb:3306 --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
# wp core install --url=${WP_URL} --title="${WP_TITLE}" --admin_user=${WP_ADMIN} --admin_password=${WP_ADMIN_PASSWORD} --admin_email="$WP_ADMIN@student.42.fr" --allow-root
# wp user create ${WP_USER} "$WP_USER"@user.com --role=author --user_pass=${WP_USER_PASSWORD} --allow-root
# exec "$@"
# # Used to make the entrypoint a passthrough to make run after a dockercommand, "$@" is pointing points to the command line arguments (it is not creating new process = /bin/sh -c)
# # https://wp-kama.com/handbook/wp-cli/wp/config for commands



#set -e #Exit if we have a non-zero after a CMD
# set -x #for more information in terminal(debugg)

#We use the wp cli to create the wp-config.php and config our wordpress
# https://wp-cli.org/fr/
# https://developer.wordpress.org/cli/commands/

#------------DL & EXTRACT WORDPRESS------------#

mkdir -p /var/www/html
cd /var/www/html/
wp core download --allow-root  # you can do command even if you are root

#------------WAITING FOR MARIADB------------#
#while ! mariadb -h mariadb -u${MYSQL_USER} -p${MYSQL_USERPASSWORD} ${MYSQL_DATABASE} &>/dev/null; do
#	sleep 2
#done
#  while ! mysqladmin -h mariadb -u ${MARIADB_USER} -p ${MARIADB_USERPASSWORD} ping; do
#  	sleep 2
#  done
while ! mysqladmin -hmariadb -u${MARIADB_USER} -p${MARIADB_USERPASSWORD} ping; do
	sleep 2
done

wp config create --dbname=${MARIADB_DATABASE} --dbuser=${MARIADB_USER} --dbpass=${MARIADB_USERPASSWORD} --dbhost=mariadb:3306 --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
wp core install --url=${WP_URL} --title="${WP_TITLE}" --admin_user=${WP_ADMIN} --admin_password=${WP_ADMIN_PASSWORD} --admin_email="$WP_ADMIN@student.42.fr" --allow-root
wp user create ${WP_USER} "$WP_USER"@user.com --role=author --user_pass=${WP_USER_PASSWORD} --allow-root
exec "$@"

#------------CONFIG FILE------------#
#creation of the wp-config.php
# wp config create \
# --allow-root \
# --dbname=${MARIADB_DATABASE} \
# --dbuser=${MARIADB_USER} \
# --dbpass=${MARIADB_USERPASSWORD} \
# --dbhost=mariadb:3306

#------------INSTALL WORDPRESS------------#
# the famous 5 minute install in 0.0001s
# wp core install \
# --allow-root \
# --url=${WP_URL} \
# --title="${WP_TITLE}" \
# --admin_user=${WP_ADMIN} \
# --admin_password=${WP_ADMIN_PASSWORD} \
# --admin_email=${WP_ADMIN_MAIL}

#------------USER CREATION------------#
# After Admin we create the user "login42"
# wp user create ${WP_USER} ${WP_USER_MAIL} \
# --allow-root \
# --role=author \
# --user_pass=${WP_USER_PASSWORD}


# exec "$@" is typically used to make the entrypoint a pass through that then runs the docker command.
# It will replace the current running shell with the command that "$@" is pointing to.
# By default, that variable points to the command line arguments.
# To simplify : First it will exec everything and after do the CMD in the dockerfile


