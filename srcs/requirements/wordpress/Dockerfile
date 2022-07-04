FROM debian:buster

RUN apt-get update -yq \
&& apt-get install curl -yq \
&& curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
&& apt-get install wordpress -yq \
&& apt-get install php-fpm php-mysql -yq

RUN chmod +x wp-cli.phar \
&&	mv wp-cli.phar /usr/local/bin/wp \
&& wp cli update

# COPY (configuration file into /tmp/configure.sh)

EXPOSE 9000

# ENTRYPOINT
# -
