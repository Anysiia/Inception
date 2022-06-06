FROM alpine:3.14

RUN apk update --quiet
RUN apk upgrade --quiet

#Install mariadb
RUN apk add --quiet mariadb mariadb-client
    
#Add entrypoint script
COPY    ./conf/entrypoint.sh entrypoint.sh
RUN     chmod +x entrypoint.sh

ENTRYPOINT [ "sh", "./entrypoint.sh" ]
