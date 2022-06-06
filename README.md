# Inception

## Config VM

### Stop nginx and mysql

stop for one time:
- `sudo systemctl stop <service>`

disable on restart:
- `sudo systemctl disable <service>`

to enable and restart:
- `sudo systemctl restart <service>`
- `sudo systemctl enable <service>`

### Config SSH

Do not work now ...

### Shared-folder between VM and my own session

create a shared folder
https://carleton.ca/scs/tech-support/troubleshooting-guides/creating-a-shared-folder-in-virtualbox/

Give access to folder
`sudo adduser <vm-user> vboxsf`

### Add user on docker group
`sudo usermod -aG docker <user>`

## Docker commands

Built a dockerfile:
- `docker build -t <image-name> <path>`

Run an image:
- `docker run -d -p 443:443 <image-name>`

Images:
- `docker images ls`
- `docjer images rm <image-name>`

Containers:
- `docker container ls`
- `docker rm -f <container-name>`

Remove all:
- `docker system prune -a -f --volumes`

Go in interactive mode in a specific container:
- `docker exec -ti <container-name> /bin/bash`

## Global documentation

https://medium.com/swlh/wordpress-deployment-with-nginx-php-fpm-and-mariadb-using-docker-compose-55f59e5c1a

## Dockerfile

https://matthewfeickert.github.io/intro-to-docker/08-entry/index.html

## Nginx

### Start nginx container with entrypoint
https://stackoverflow.com/questions/18861300/how-to-run-nginx-within-a-docker-container-without-halting

### Open SSL
https://devopscube.com/create-self-signed-certificates-openssl/

#### Subjects
https://www.ibm.com/docs/en/ibm-mq/7.5?topic=certificates-distinguished-names

#### TLSv1.2 & TLSv1.3
https://www.cyberciti.biz/faq/configure-nginx-to-use-only-tls-1-2-and-1-3/

### Conf
https://www.cyberciti.biz/faq/configure-nginx-to-use-only-tls-1-2-and-1-3/

## MariaDB

https://www.digitalocean.com/community/tutorials/how-to-install-mariadb-on-debian-10

https://mariadb.com/kb/en/mysql_install_db/
https://bertvv.github.io/notes-to-self/2015/11/16/automating-mysql_secure_installation/

Connecting:

- `mysql -p <username> -p`

- to a specific database : `mysql -u root -p <database-name>`

https://www.mariadbtutorial.com/getting-started/connect-to-mariadb/

### Create database

https://mariadb.com/kb/en/create-database/

## Wordpress

https://developer.wordpress.org/apis/wp-config-php/

### Server environment for WP
https://make.wordpress.org/hosting/handbook/server-environment/

### wp-cli
https://jf-blog.fr/wp-cli-configuration-et-utilisation/

https://developer.wordpress.org/cli/commands/

### Config php-fpm
https://www.php.net/manual/fr/install.fpm.configuration.php

### Add www-data

https://gist.github.com/briceburg/47131d8caf235334b6114954a6e64922

## Docker-compose

https://docs.docker.com/compose/compose-file/compose-file-v3/

Restart dockers containers and why they do not restart if they are manually killed
https://serverfault.com/questions/884759/how-does-restart-always-policy-work-in-docker-compose
