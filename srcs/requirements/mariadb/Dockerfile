FROM debian:buster

RUN apt-get update -yq \
	&& apt-get -yq upgrade \
	&& apt-get install mariadb-server -yq
	# && apt-get install mysql-server

# ENV MYSQL_ROOT_PASSWORD=password \
# 	MYSQL_USER=fmonbeig \
# 	MYSQL_DATABASE=wordpress \
# 	MYSQL_USERPASSWORD=password \
# 	MYSQL_ADMIN=admin \
# 	MYSQL_ADMIN_PASSWORD=admin_password \
# 	MYSQL_PASSWORD=password

COPY conf/ini.sh .
COPY conf/default.conf /etc/mysql/my.cnf
COPY conf/default.conf /etc/my.cnf
COPY conf/default.conf ~/my.cnf
# COPY conf/conf.cnf /etc/mysql/conf.d/mysql.cnf

RUN mkdir -p /var/run/mysqld \
	&& mkdir -p /run/mysqld \
	&& chown -R mysql:root /run/mysqld \
	&& chown -R mysql:root /var/run/mysqld \
	&& chown -R mysql:mysql /var/lib/mysql \
	&& chmod +x ini.sh

EXPOSE 3306

ENTRYPOINT ["sh", "ini.sh"]

