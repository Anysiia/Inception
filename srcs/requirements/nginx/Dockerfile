FROM alpine:3.14

RUN apk update --quiet
RUN apk upgrade --quiet

#Install nginx and usefull packages
RUN apk add --quiet nginx 
RUN apk add --quiet openssl
RUN apk add --quiet openrc

#Create directories
RUN mkdir -p /var/www/wordpress && mkdir -p /etc/nginx/ssl

# Create self-signed ssl key
RUN openssl req -newkey rsa:4096 -x509 -sha256 -nodes -days 365\
	-out /etc/nginx/ssl/cmorel-a.42.fr.crt \
	-keyout /etc/nginx/ssl/cmorel-a.42.fr.key \
	-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=cmorel-a.42.fr/UID=cmorel-a"

# Server configuration
COPY ./conf/nginx.conf /etc/nginx/http.d/default.conf

RUN rc-update add nginx default

RUN ln -sf /dev/stdout /var/log/nginx/access.log ; \
	ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
