FROM debian:buster

RUN apt-get update -yq \
	&& apt-get -yq upgrade \
	&& apt-get install mariadb-server -yq

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

COPY conf/ini.sh .
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf
# COPY conf/conf.cnf /etc/mysql/my.cnf #FIXME  conf non pris en compte
# COPY conf/conf.cnf /etc/my.cnf
# COPY conf/conf.cnf ~/my.cnf

RUN mkdir -p /var/run/mysqld \
	&& mkdir -p /run/mysqld \
	&& chown -R mysql:root /run/mysqld \
	&& chown -R mysql:root /var/run/mysqld \
	&& touch /var/run/mysqld/mysqld.sock \
	&& chmod +x ini.sh

EXPOSE 3306

ENTRYPOINT ["sh", "ini.sh"]
CMD mysqld_safe

