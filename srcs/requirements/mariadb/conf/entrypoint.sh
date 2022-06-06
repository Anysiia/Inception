#!/bin/sh

if [ ! d "/run/mysqld" ]; then
    mkdir -p /run/mysqld
    chown -R mysql:mysql /run/mysqld
fi

if [ ! d "/var/lib/mysql/mysql" ]; then
    chown -R mysql:mysql /var/lib/mysql

    #Init db
    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

    #Create tmp file

    tmp=`mariadb_tmp`
    if [ ! -f "$tmp" ]; then
        return 1
    fi

    cat << EOF > $tmp
USE mysql;
FLUSH PRIVILEGES;
    
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
    
CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER IF NOT EXISTS ${MARIADB_USER}'@'%' IDENTIFIED BY ${MARIADB_PASSWORD};
GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO ${MARIADB_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
FLUSH PRIVILEGES;

EOF
    #Run 
    /usr/bin/mysqld --user=mysql --bootstrap < $tmp
    rm -f $tmp
fi

#Config to allow connections
sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

#Stop and relaunch mysql

exec /usr/bin/mysqld --user=mysql --console
