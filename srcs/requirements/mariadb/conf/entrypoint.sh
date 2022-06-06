#!/bin/sh

#Install batabase
/usr/bin/mysql_install_db --user=root --basedir=/usr --datadir=/var/lib/mysql

#Launch mysqld to operate changes
/usr/bin/mysqld --user=root --datadir=/var/lib/mysql & sleep 2

#################CONFIG####################################################
#Delete anonymous users
mysql -e "DELETE FROM mysql.user WHERE User='';"

#Remove test database
mysql -e "DROP DATABASE IF EXISTS test;"
mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';"

#Create database 
mysql -e "CREATE DATABASE IF NOT EXISTS \`${MARIADB_DATABASE}\`;"

#Add user
mysql -e "CREATE USER IF NOT EXISTS \`${MARIADB_USER}\`@'localhost' IDENTIFIED BY '${MARIADB_PASSWORD}';"

#Add rights for user on MARIADB_DATABASE
mysql -e "GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE}\`.* TO \`${MARIADB_USER}\`@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';"

#Change root password
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';"

#Apply change
mysql -e "FLUSH PRIVILEGES"
###########################################################################

#Stop and relaunch mysql
pkill mysqld
/usr/bin/mysqld --user=root --datadir=/var/lib/mysql
