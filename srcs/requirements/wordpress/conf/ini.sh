#!/bin/sh

#set -e #Exit if we have a non-zero after a CMD
set -x #for more information in terminal(debugg)

#We use the wp cli to create the wp-config.php and config our wordpress
# https://wp-cli.org/fr/
# https://developer.wordpress.org/cli/commands/

sleep 6
#------------DL & EXTRACT WORDPRESS------------#
 wp core download --allow-root --path=/var/www/html  # you can do command even if you are root

#------------CONFIG FILE------------#
#creation of the wp-config.php
wp config create \
--path=/var/www/html \
--allow-root \
--dbname=${MYSQL_DATABASE} \
--dbuser=${MYSQL_USER} \
--dbpass=${MYSQL_USERPASSWORD} \
--dbhost=mariadb:3306 #Use we docker compose and when mariadb is up

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



    # wp core download --allow-root
    # wp config create --dbname=$WP_DATABASE_NAME --dbuser=$WP_DATABASE_USR --dbpass=$WP_DATABASE_PWD --dbhost=$MYSQL_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
    # wp core install --url=$DOMAIN_NAME/wordpress --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
    # wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root
    # wp theme install inspiro --activate --allow-root


/usr/sbin/php-fpm7.3 --nodaemonize --allow-to-run-as-root  # c'est peut etre ca que l o doit mettre dans le dockerfile

# -F, --nodaemonize
#       force to stay in foreground, and ignore daemonize option from config file
# -R, --allow-to-run-as-root
#         Allow pool to run as root (disabled by default)
# php-fpm #launch mysql server

# --allow-root
