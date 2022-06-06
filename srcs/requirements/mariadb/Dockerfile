FROM alpine:3.14

RUN apk update --quiet
RUN apk upgrade --quiet

#Install mariadb
RUN apk add --quiet mariadb mariadb-client

#Add directory and change rights
RUN mkdir -p /var/lib/mysql ; \
    mkdir -p /run/mysqld ; \
    chmod 766 /var/lib/mysql ; \
    chown -R mysql:mysql /var/lib/mysql
    
#Add entrypoint script
COPY    ./conf/entrypoint.sh entrypoint.sh
RUN     chmod +x entrypoint.sh

EXPOSE 3306

ENTRYPOINT [ "./entrypoint.sh" ]
