FROM debian:buster

RUN apt-get update -yq \
	&& apt-get install mariadb-server -yq \
	&& apt-get clean -y

RUN mkdir -p /var/run/mysqld \
	&& mkdir -p /run/mysqld \
	&& chown -R mysql:root /run/mysqld \
	&& chown -R mysql:root /var/run/mysqld

COPY conf/ini.sh .

EXPOSE 3306

ENTRYPOINT ["sh", "ini.sh"]
