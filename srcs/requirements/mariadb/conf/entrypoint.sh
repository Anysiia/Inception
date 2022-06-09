#!/bin/sh

#Create /run/mysqld if not exists
if [ ! -d "/run/mysqld" ]
then
    mkdir -p /run/mysqld
    chown -R mysql:mysql /run/mysqld
fi 

#Init mysql and create db if db not exists
if [ ! -d "/var/lib/mysql/${MARIADB_DATABASE}" ]
then
    echo "Initialisation of mysql"
    chmod 766 /var/lib/mysql
    chown -R mysql:mysql /var/lib/mysql

    #Init db
    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql

    #Create and config 
    /usr/bin/mysqld --user=mysql & sleep 2
    mysql -e "USE mysql;"
    mysql -e "DELETE FROM mysql.user WHERE User='';"
    mysql -e "DROP DATABASE IF EXISTS test;"
    mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';"
    mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
    mysql -e "GRANT ALL ON *.* TO 'root'@'172.%' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';"  
    mysql -e "CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE} CHARACTER SET utf8 COLLATE utf8_general_ci;"
    mysql -e "CREATE USER IF NOT EXISTS \`${MARIADB_USER}\`@'localhost' IDENTIFIED BY '${MARIADB_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE}\`.* TO \`${MARIADB_USER}\`@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';"
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';"
    mysql -e "FLUSH PRIVILEGES;"
    pkill mysqld
fi

#Config to allow connections
sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

/usr/bin/mysqld --user=mysql
