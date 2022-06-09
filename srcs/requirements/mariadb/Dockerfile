FROM alpine:3.14

RUN apk update -q ; \
    apk upgrade -q ; \
    apk add -q mariadb \
        mariadb-client
    
#Add entrypoint script
COPY    ./conf/entrypoint.sh entrypoint.sh
RUN     chmod +x entrypoint.sh

ENTRYPOINT [ "sh", "./entrypoint.sh" ]
