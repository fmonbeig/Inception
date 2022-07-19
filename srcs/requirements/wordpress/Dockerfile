FROM debian:buster

RUN apt-get update -y \
&& apt-get install curl -y \
&& curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
#&& apt-get install wordpress -yq
# && apt-get install -y \
# 	php7.3 \
# 	php-common \
# 	php7.3-cli \
# 	php7.3-fpm \
# 	php7.3-json \
# 	php7.3-mysql \
# 	php7.3-common \
# 	php7.3-opcache \
# 	php7.3-readline \
# 	php7.3-curl \
# 	php7.3-gd \
# 	php7.3-mbstring \
# 	php7.3-intl \
# 	php7.3-gmp \
# 	php7.3-xml \
# 	php7.3-zip
RUN apt-get install -y  php7.3-cli php7.3-common php7.3-curl php7.3-mbstring php7.3-mysql php-fpm curl mariadb-client wget

# ENV MYSQL_DATABASE=wordpress \
# 	MYSQL_ROOT_PASSWORD=password \
# 	MYSQL_USER=fmonbeig \
# 	MYSQL_USERPASSWORD=password \
# 	MYSQL_ADMIN=flad \
# 	MYSQL_ADMIN_PASSWORD=flad_pwd \
# 	MYSQL_PASSWORD=password \
# 	WORDPRESS_ADMIN=flad \
# 	WORDPRESS_ADMIN_PASSWORD=flad_password \
# 	WORDPRESS_ADMIN_MAIL=fake_admin@student.42.fr \
# 	WORDPRESS_USER=fmonbeig \
# 	WORDPRESS_USER_PASSWORD=password \
# 	WORDPRESS_USER_MAIL=fmonbeig@student.42.fr \
# 	WORDPRESS_URL=fmonbeig.42.fr \
# 	WORDPRESS_TITLE=Spinning_Top

RUN chmod +x wp-cli.phar \
&&	mv wp-cli.phar /usr/local/bin/wp \
&&	wp cli update

COPY conf/ini.sh .
COPY conf/www.conf /etc/php/7.3/fpm/pool.d

RUN chmod +x ini.sh \
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



# FROM debian:buster

# LABEL Dockerimage="wordpress"

# RUN apt-get update -y
# RUN apt-get install -y  php7.3-cli php7.3-common php7.3-curl php7.3-mbstring php7.3-mysql php-fpm curl mariadb-client wget
# #sendmail
# RUN 	mkdir -p /var/run/ ; mkdir -p /run/php/

# COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d
# COPY ./conf/wp-config.php /var/
# COPY ./conf/confManager.sh /etc/

# RUN chmod +x /etc/confManager.sh

# # Lancement du script
# RUN 	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
# 		chmod +x wp-cli.phar && \
# 		mv wp-cli.phar /usr/local/bin/wp

# EXPOSE 9000
# ENTRYPOINT [ "bash", "/etc/confManager.sh" ]
# CMD ["/usr/sbin/php-fpm7.3", "--nodaemonize"]

# #For all php services: https://sys-admin.fr/installation-php-7-3-sur-debian/
# # All we do here is to install all tools and installation assistance. .phar = file format to stock php packets
# # php fpm is for the Fastcgi
