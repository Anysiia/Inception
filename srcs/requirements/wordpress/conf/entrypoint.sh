#!/bin/sh

mv /tmp/php-fpm.conf /etc/php7/php-fpm.conf
mv /tmp/www.conf    /etc/php7/php-fpm.d/www.conf

#Download wp-cli
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp


#Waiting for mariadb
while ! mariadb -h$MARIADB_HOST -u$MARIADB_USER -p$MARIADB_PASSWORD $MARIADB_DATABASE &>/dev/null;
do
    echo "Not connected to $MARIADB_DATABASE. Retry..."
	sleep 3
done

if [ ! -f "/var/www/html/index.php" ]; then
    
    #Download wp
    wp core download --path=/var/www/html --allow-root

    #Create wp-config file
    wp config create --dbname=$MARIADB_DATABASE --dbuser=$MARIADB_USER --dbpass=$MARIADB_PASSWORD \
        --dbhost=$MARIADB_HOST:3306 --dbprefix=$WP_PREFIX --dbcharset='utf8' --dbcollate='utf8_general_ci' \
        --force --path=/var/www/html --allow-root 

    #Install 
    wp core install --path=/var/www/html --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN \
        --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_MAIL --skip-email --allow-root

    #Add a new user with author role
    wp user create $WP_USER $WP_USER_MAIL --role=author --user_pass=$WP_USER_PASSWORD

    #Install theme and activate 
    wp theme install twentyseventeen --activate --force --allow-root

    #Change URL
    wp option update home $WP_URL
    wp option update siteurl $WP_URL
fi

#Launch php-fpm to etablished connection with nginx
# --nodaemonize / -F => Force to stay in foreground and ignore daemonize option from configuration file.
# --allow-to-run-as-root /-R Allow pool to run as root (disabled by default)

/usr/sbin/php-fpm7 -F -R
