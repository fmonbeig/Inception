#!/bin/sh

#set -e #Exit if we have a non-zero after a CMD
set -x #for more information in terminal(debugg)

#We use the wp cli to create the wp-config.php and config our wordpress
# https://wp-cli.org/fr/
# https://developer.wordpress.org/cli/commands/

#------------INSTALL WORDPRESS------------#
# the famous 5 minute install in 0.0001s
wp core install \
--allow-root \ # you can do command even if you are root
--path=/var/www/html \
--url=${WORDPRESS_URL}\
--title="${WORDPRESS_TITLE}" \
--admin_user=${WORDPRESS_ADMIN} \
--admin_password=${WORDPRESS_ADMIN_PASSWORD} \
--admin_email=${WORDPRESS_ADMIN_MAIL}

#------------CONFIG FILE------------#
#creation of the wp-config.php
wp config create \
--allow-root \
--dbname=${MYSQL_DATABASE}
--dbuser=${MYSQL_USER} \
--dbpass=${MYSQL_USERPASSWORD} \
--dbhost=mariadb:3306 \
--dbcollate="utf8_unicode_520_ci"  # The ultimate Unicode set of rules

#------------USER CREATION------------#
# After Admin we create the user "login42"
wp user create ${WORDPRESS_USER} ${WORDPRESS_USER_MAIL} \
--allow-root \
--path=/var/www/html \
--first_name=florian \
--last_name=MONBEIG \
# --description=this user is very cool \
--role=author \
--user_pass=${WORDPRESS_USER_PASSWORD}n

/usr/sbin/php-fpm7.3 --nodaemonize --allow-to-run-as-root  # c'est peut etre ca que l o doit mettre dans le dockerfile

# -F, --nodaemonize
#       force to stay in foreground, and ignore daemonize option from config file
# -R, --allow-to-run-as-root
#         Allow pool to run as root (disabled by default)
# php-fpm #launch mysql server

# --allow-root
