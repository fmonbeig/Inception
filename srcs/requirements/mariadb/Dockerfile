FROM debian:buster

RUN apt-get update -yq \
	&& apt-get -yq upgrade \
	&& apt-get install mariadb-server -yq

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
CMD mysqld

