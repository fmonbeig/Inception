FROM debian:buster

RUN apt-get update -yq \
	&& apt-get -yq upgrade \
	&& apt-get install mariadb-server -yq

ENV MYSQL_ROOT_PASSWORD=password \
	MYSQL_USER=fmonbeig \
	MYSQL_DATABASE=wordpress \
	MYSQL_USERPASSWORD=password \
	MYSQL_ADMIN=admin \
	MYSQL_ADMIN_PASSWORD=admin_password \
	MYSQL_PASSWORD=password

RUN mkdir -p /var/run/mysqld \
	&& mkdir -p /run/mysqld \
	&& chown -R mysql:root /run/mysqld \
	&& chown -R mysql:root /var/run/mysqld \
	&& chown -R mysql:root /var/lib/mysql

COPY conf/ini.sh .
# COPY conf/conf.cnf /etc/mysql/my.cnf
# COPY conf/conf.cnf /etc/my.cnf
# COPY conf/conf.cnf ~/my.cnf

EXPOSE 3306

# ENTRYPOINT ["sh", "ini.sh"]
CMD mysqld
