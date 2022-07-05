FROM debian:buster

RUN apt-get update -yq \
&& apt-get install curl -yq \
&& curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
&& apt-get install wordpress -yq \
&& apt-get install -y \
	php7.3 \
	php-common \
	php7.3-cli \
	php7.3-fpm \
	php7.3-json \
	php7.3-mysql \
	php7.3-common \
	php7.3-opcache \
	php7.3-readline \
	php7.3-curl \
	php7.3-gd \
	php7.3-mbstring \
	php7.3-intl \
	php7.3-gmp \
	php7.3-xml \
	php7.3-zip

RUN chmod +x wp-cli.phar \
&&	mv wp-cli.phar /usr/local/bin/wp \
&& wp cli update

EXPOSE 9000

ENTRYPOINT ["sh", "ini.sh"]
