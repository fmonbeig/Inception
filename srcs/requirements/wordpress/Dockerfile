FROM debian:9

RUN apt-get update -yq \
&& apt-get install wordpress -yq \
&& apt-get clean -y

# COPY (configuration file into /tmp/configure.sh)

EXPOSE 3306
VOLUME /app/logs

ENTRYPOINT mysqld
