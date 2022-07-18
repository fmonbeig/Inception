#set -e #Exit if we have a non-zero after a CMD
set -x #for more information in terminal(debugg)

#We use the wp cli to create the wp-config.php and config our wordpress
# https://wp-cli.org/fr/
# https://developer.wordpress.org/cli/commands/

#------------DL & EXTRACT WORDPRESS------------#
 wp core download --allow-root --path=/var/www/html  # you can do command even if you are root

#------------WAITING FOR MARIADB------------#
while ! mariadb -h mariadb -u${MYSQL_USER} -p${MYSQL_USERPASSWORD} ${MYSQL_DATABASE} &>/dev/null; do
	sleep 2
done
# while ! mysqladmin -h mariadb -u ${MYSQL_USER} -p ${MYSQL_USERPASSWORD} ping; do
# 	sleep 2
# done
# sleep 10

#------------CONFIG FILE------------#
#creation of the wp-config.php
wp config create \
--path=/var/www/html \
--allow-root \
--dbname=${MYSQL_DATABASE} \
--dbuser=${MYSQL_USER} \
--dbpass=${MYSQL_USERPASSWORD} \
--dbhost=mariadb:3306

#------------INSTALL WORDPRESS------------#
# the famous 5 minute install in 0.0001s
wp core install \
--allow-root \
--path=/var/www/html \
--url=${WORDPRESS_URL} \
--title="${WORDPRESS_TITLE}" \
--admin_user=${WORDPRESS_ADMIN} \
--admin_password=${WORDPRESS_ADMIN_PASSWORD} \
--admin_email=${WORDPRESS_ADMIN_MAIL}

#------------USER CREATION------------#
# After Admin we create the user "login42"
wp user create ${WORDPRESS_USER} ${WORDPRESS_USER_MAIL} \
--allow-root \
--path=/var/www/html \
--role=author \
--user_pass=${WORDPRESS_USER_PASSWORD}

# exec "$@" is typically used to make the entrypoint a pass through that then runs the docker command.
# It will replace the current running shell with the command that "$@" is pointing to.
# By default, that variable points to the command line arguments.
# To simplify : First it will exec everything and after do the CMD in the dockerfile
exec "$@"
