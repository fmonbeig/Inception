FROM debian:9

RUN apt-get update -yq \
&& apt-get install mariadb-server -yq \
&& apt-get clean -y

COPY conf/ini.sh .

EXPOSE 3306

ENTRYPOINT ["sh", "ini.sh"]
