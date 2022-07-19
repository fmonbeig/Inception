FROM debian:buster

RUN apt-get update -y \
	&& apt-get -y upgrade \
	&& apt-get install mariadb-server -y

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

RUN mkdir -p /var/run/mysqld \
	&& mkdir -p /run/mysqld \
	&& chown -R mysql:root /run/mysqld \
	&& chown -R mysql:root /var/run/mysqld \
	&& touch /var/run/mysqld/mysqld.sock \
	&& chmod +x ini.sh


EXPOSE 3306

ENTRYPOINT ["sh", "ini.sh"]
CMD ["mysqld_safe"]


# FROM debian:buster

# LABEL Dokerimage="mariadb"

# #ENV MARIADB_DATABASE=test1
# #ENV MARIADB_ADMIN=Elon
# #ENV MARIADB_ADMIN_PASSWORD=Musk
# #ENV MARIADB_USER=Warren
# #ENV MARIADB_USERPASSWORD=Buffet


# RUN	apt-get update && apt-get -y upgrade && apt-get install -y mariadb-server

# RUN     mkdir -p /var/run/mysqld && mkdir -p /run/mysqld
# RUN     chown -R mysql:root /run/mysqld && chown -R mysql:root /var/run/mysqld
# RUN     touch  /var/run/mysqld/mysqld.sock

# COPY    conf/conf.sh /
# COPY	conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

# EXPOSE 3306
# ENTRYPOINT  ["sh", "conf.sh"]

# #mysqld_safe # For linux distributions which doesn't handle systemd
# #(systemd: default service manager which has default timeout and kill the process)
# CMD ["mysqld_safe"]

