FROM debian:buster

RUN apt-get update -yq \
	&& apt-get -yq upgrade \
	&& apt-get install mariadb-server -yq

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

COPY conf/ini.sh .
COPY conf/conf.cnf /etc/mysql/my.cnf
COPY conf/conf.cnf /etc/my.cnf
COPY conf/conf.cnf ~/my.cnf
# COPY conf/conf.cnf /etc/mysql/conf.d/mysql.cnf

RUN mkdir -p /var/run/mysqld \
	&& mkdir -p /run/mysqld \
	&& chown -R mysql:root /run/mysqld \
	&& chown -R mysql:root /var/run/mysqld \
	&& chown -R mysql:mysql /var/lib/mysql \
	&& chmod +x ini.sh

EXPOSE 3306

ENTRYPOINT ["sh", "ini.sh"]
CMD mysqld

