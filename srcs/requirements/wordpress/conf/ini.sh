#!/bin/sh

set -x #for more information in terminal

#We use the wp cli to create the wp-config.php and config our wordpress
wp core install \
--allow-root \ # you can do command even if you are root
--path=/var/www/html \
--url=${WORDPRESS_URL}\
--title="${WORDPRESS_TITLE}" \
--admin_user=${WORDPRESS_ADMIN} \
--admin_password=${WORDPRESS_ADMIN_PASSWORD} \
--admin_email=${WORDPRESS_ADMIN_MAIL}

wp config create \
--allow-root \
--dbname=${MYSQL_DATABASE}
--dbuser=${MYSQL_USER} \
--dbpass=${MYSQL_USERPASSWORD} \
--dbhost=mariadb:3306 \
--dbcollate="utf8_unicode_520_ci"  # The ultimate Unicode set of rules

wp user create ${WORDPRESS_USER} ${WORDPRESS_USER_MAIL} \
--allow-root \
--path=/var/www/html \
--first_name=florian \
--last_name=MONBEIG \
--descriton=this user is very cool \
--role=author \
--user_pass=${WORDPRESS_USER_PASSWORD}


mysqld #launch mysql server

# --allow-root

