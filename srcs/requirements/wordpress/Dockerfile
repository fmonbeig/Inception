FROM debian:buster

RUN apt-get update -yq \
&& apt-get install curl -yq \
&& curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
&& apt-get install wordpress -yq \
&& apt-get install -y \
	php7.3 \
	php-common \
	php7.3-cli \
	php7.3-fpm \
	php7.3-json \
	php7.3-mysql \
	php7.3-common \
	php7.3-opcache \
	php7.3-readline \
	php7.3-curl \
	php7.3-gd \
	php7.3-mbstring \
	php7.3-intl \
	php7.3-gmp \
	php7.3-xml \
	php7.3-zip

ENV WORDPRESS_ADMIN=admin \
	WORDPRESS_ADMIN_PASSWORD=admin_password \
	WORDPRESS_ADMIN_MAIL=fake_admin@student.42.fr \
	WORDPRESS_USER=fmonbeig \
	WORDPRESS_USER_PASSWORD=password \
	WORDPRESS_USER_MAIL=fmonbeig@student.42.fr \
	WORDPRESS_URL=fmonbeig.42.fr \
	WORDPRESS_TITLE=Spinning_Top\
	MYSQL_DATABASE=wordpress \
	MYSQL_ROOT_PASSWORD=password \
	MYSQL_USER=fmonbeig \
	MYSQL_USERPASSWORD=password \
	MYSQL_ADMIN=admin \
	MYSQL_ADMIN_PASSWORD=admin_password \
	MYSQL_PASSWORD=password

RUN chmod +x wp-cli.phar \
&&	mv wp-cli.phar /usr/local/bin/wp \
&&	wp cli update


COPY conf/ini.sh .
COPY conf/www.conf /etc/php/7.3/fpm/pool.d
#FIXME WP CONFIG ??
RUN chmod +x ini.sh \
&&	mkdir -p /var/www/html \
&&  mkdir -p /var/run/ \
&&  mkdir -p /run/php/

EXPOSE 9000

ENTRYPOINT ["bash", "ini.sh"]
CMD ["/usr/sbin/php-fpm7.3", "--nodaemonize", "--allow-to-run-as-root"]


# -F, --nodaemonize
#       force to stay in foreground, and ignore daemonize option from config file
# -R, --allow-to-run-as-root
#         Allow pool to run as root (disabled by default)
# php-fpm #launch mysql server
