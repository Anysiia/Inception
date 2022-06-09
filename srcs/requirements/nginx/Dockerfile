FROM alpine:3.14

#Install nginx and openssl
RUN apk update -q ; \
	apk upgrade -q ; \
	apk add -q nginx \
		openssl

#Create directories and conf for log and access
RUN mkdir -p /var/www/wordpress ; \
	mkdir -p /etc/nginx/ssl ; \
	ln -sf /dev/stdout /var/log/nginx/access.log ; \
	ln -sf /dev/stderr /var/log/nginx/error.log

# Create self-signed ssl key
RUN openssl req -newkey rsa:4096 -x509 -sha256 -nodes -days 365\
	-out /etc/nginx/ssl/cmorel-a.42.fr.crt \
	-keyout /etc/nginx/ssl/cmorel-a.42.fr.key \
	-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=cmorel-a.42.fr/UID=cmorel-a"

# Server configuration
COPY ./conf/nginx.conf /etc/nginx/http.d/default.conf

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
