FROM alpine:3.14

# Php7 is using instead of 8.0 because on 8.0 json is not supported
# Needed for wp-cli: php-phar and mariadb-client
# By default php7.3 is installed
# Package needed and optionnal:
# https://wpassist.me/wordpress-required-php-extensions/

RUN apk update -q ; \
	apk upgrade -q ; \
	apk add -q curl \
		mariadb-client \
		php7 \
		php7-curl \
		php7-dom \
		php7-exif \
		php7-fileinfo \
		php7-filter \
		php7-fpm \
		php7-gd \
		php7-hash \
		php7-iconv \
		php7-imagick \
		php7-json \
		php7-mbregex \
		php7-mbstring \
		php7-mycrypt \
		php7-mysqli \
		php7-openssl \
		php7-pcre \
		php7-phar \
		php7-simplexml \
		php7-sodium \
		php7-xml \
		php7-xmlreader \
		php7-zip \
		php7-zlib

COPY conf /tmp/

RUN adduser -S nginx ; \
	addgroup -S nginx ; \
	chmod +x /tmp/entrypoint.sh

WORKDIR /var/www/html/

ENTRYPOINT [ "sh", "/tmp/entrypoint.sh" ]
