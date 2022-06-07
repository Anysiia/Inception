#!/bin/sh

#Config to allow connections
sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

if [ ! -d "/run/mysqld" ]
then
    mkdir -p /run/mysqld
    chown -R mysql:mysql /run/mysqld
fi 

if [ ! -d "/var/lib/mysql/mysql" ]
then
    echo "Initialisation of mysql"
    chmod 766 /var/lib/mysql
    chown -R mysql:mysql /var/lib/mysql

    #Init db
    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql

    /usr/bin/mysqld --user=mysql & sleep 2

    echo "un"
    sudo mysql -e "USE mysql;"
    sudo mysql -e "DELETE FROM mysql.user WHERE User='';"
    sudo mysql -e "DROP DATABASE IF EXISTS test;"
    sudo mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';"
    sudo mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');" 
    
    echo "two"
    sudo mysql -e "CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE} CHARACTER SET utf8 COLLATE utf8_general_ci;"
    sudo mysql -e "CREATE USER IF NOT EXISTS ${MARIADB_USER}'@'%' IDENTIFIED BY ${MARIADB_PASSWORD};"
    sudo mysql -e "GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO ${MARIADB_USER}'@'%';"
    sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';"
    sudo mysql -e "FLUSH PRIVILEGES;"

    pkill mysqld
fi

/usr/bin/mysqld --user=mysql