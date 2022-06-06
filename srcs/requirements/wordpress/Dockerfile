FROM alpine:3.14

# Php7 is using instead of 8.0 because on 8.0 json is not supported
# Php extensions needed by wordpress: 
# - Required: php-json && php-mysqli
# - Needed to proprely communicate with nginx : php-fpm
# - Needed for wp-cli: php-phar and mariadb-client
# - Others: php-curl (remote requests), php-mbstring (handle UTF8 text)
# By default php7.3 is installed

RUN apk update --quiet
RUN apk upgrade --quiet

RUN apk add --quiet curl mariadb-client
RUN apk add --quiet php7 php7-fpm php7-json php7-mysqli php7-curl php7-mbstring php7-phar

RUN rm -f /etc/php7/php-fpm.d/www.conf
COPY ./conf/phpfpm.conf /etc/php7/php-fpm.d/www.conf
COPY ./conf/wp-config.php ./

RUN mkdir -p /var/www/wordpress
RUN set -x ; \
	addgroup -g 82 -S www-data ; \
	adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1
# 82 is the standard uid/gid for "www-data" in Alpine
RUN chmod 755 -R /var/www/wordpress
RUN chown -R www-data:www-data /var/www/wordpress

COPY ./conf/entrypoint.sh   ./
RUN chmod +x entrypoint.sh

EXPOSE 9000

ENTRYPOINT [ "./entrypoint.sh" ]
