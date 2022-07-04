FROM debian:buster

RUN apt-get update -yq \
&& apt-get install wordpress -yq \
&& apt-get clean -y

# COPY (configuration file into /tmp/configure.sh)

EXPOSE 9000

ENTRYPOINT
