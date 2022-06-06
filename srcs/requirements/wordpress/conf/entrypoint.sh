#!/bin/sh

#Download wp-cli
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

#Waiting for mariadb
while ! mariadb -h$MARIADB_HOST -u$MARIADB_USER -p$MARIADB_PASSWORD $MARIADB_DATABASE &>/dev/null; do
    echo "Not connected to inceptiondb"
	sleep 3
done


#Download wp
wp core download --allow-root --path=/var/www/html

#Install WP
wp core install --allow-root --url=${DOMAIN_NAME} --title=${WP_TITLE} \
    --admin_user=${WP_ADMIN} --admin_password=${WP_ADMIN_PASSWORD} \
    --admin_email=${WP_ADMIN_MAIL} --skip-email --path=/var/www/html

#Install and activate theme
wp theme activate twentyseventeen --allow-root --path=/var/www/html

#Add a new user with author role
wp user create ${WP_USER} ${WP_MAIL} --role=author --user_pass=${WP_USER_PASSWORD} \
	--allow-root --path=/var/www/html


#Launch php-fpm to etablished connection with nginx
# --nodaemonize / -F => Force to stay in foreground and ignore daemonize option from configuration file.
# --allow-to-run-as-root /-R Allow pool to run as root (disabled by default)

exec php-fpm7 -F
