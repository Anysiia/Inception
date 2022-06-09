#!/bin/sh

#Download wp-cli
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp


#Waiting for mariadb
#while ! mysql -h$MARIADB_HOST -u$MARIADB_USER -p$MARIADB_PASSWORD $MARIADB_DATABASE &>/dev/null;
#do
#    echo "Not connected to $MARIADB_DATABASE (host: $MARIADB_HOST user: $MARIADB_USER pass: $MARIADB_PASSWORD)"
#	sleep 3
#done

sleep 15

if [ ! -f "/var/www/html/index.html" ]; then
    
    #Download wp
    wp core download --allow-root

    #wp-config file
    wp config create --dbname=$MARIADB_DATABASE --dbuser=$MARIADB_USER --dbpass=$MARIADB_PASSWORD \
        --dbhost=$MARIADB_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root

    #Install 
    wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN \
        --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_MAIL --skip-email --allow-root

    #Install and activate theme
    wp theme activate twentyseventeen --allow-root

    #Add a new user with author role
    wp user create $WP_USER $WP_MAIL --role=author --user_pass=$WP_USER_PASSWORD --allow-root
fi

#Launch php-fpm to etablished connection with nginx
# --nodaemonize / -F => Force to stay in foreground and ignore daemonize option from configuration file.
# --allow-to-run-as-root /-R Allow pool to run as root (disabled by default)

/usr/sbin/php-fpm7 -F -R
