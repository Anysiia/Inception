FROM alpine:3.14

# Php7 is using instead of 8.0 because on 8.0 json is not supported
# Php extensions needed by wordpress: 
# - Required: php-json && php-mysqli
# - Needed to proprely communicate with nginx : php-fpm
# - Needed for wp-cli: php-phar and mariadb-client
# - Others: php-curl (remote requests), php-mbstring (handle UTF8 text)
# By default php7.3 is installed

RUN apk update -q ; \
	apk upgrade -q ; \
	apk add -q curl \
		mariadb-client \
		php7 \
		php7-fpm \
		php7-json \
		php7-mysqli \
		php7-curl \
		php7-mbstring \
		php7-phar \
		zip

COPY conf /tmp/

RUN adduser -S nginx ; \
	addgroup -S nginx ; \
	chmod +x /tmp/entrypoint.sh

WORKDIR /var/www/html/

ENTRYPOINT [ "sh", "/tmp/entrypoint.sh" ]
