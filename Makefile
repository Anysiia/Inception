# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cmorel-a <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/05/12 14:45:25 by cmorel-a          #+#    #+#              #
#    Updated: 2022/06/01 11:16:35 by cmorel-a         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DATA_PATH := /home/cmorel-a/data
DOCKER := sudo docker
COMPOSE := cd ./srcs/ && sudo docker-compose
DNS_SETUP = $(shell cat /etc/hosts | grep 'cmorel-a' | wc -l)

#Create path for volumes, change dns host and start infra
all:
	@sudo mkdir -p $(DATA_PATH)/database
	@sudo mkdir -p $(DATA_PATH)/wordpress
ifeq ($(DNS_SETUP), "0")
	@echo "DNS redirection\n"
	@sudo chmod 666 /etc/hosts
	@sudo echo "127.0.0.1	cmorel-a.42.fr" >> /etc/hosts
endif
	@$(COMPOSE) up --build -d --remove-orphans

#List all containers
list:
	@echo "Using docker ps -a"
	@$(DOCKER) ps -a
	@echo "Using docker-compose ps"
	@$(COMPOSE) ps

#List all volumes
volumes:
	@$(DOCKER) volume ls
	@$(DOCKER) volume inspect srcs_wordpress-volume
	@$(DOCKER) volume inspect srcs_mariadb-volume

#Network
network:
	@$(DOCKER) network ls

#Logs all containers
log:
	@$(COMPOSE) logs

#Logs mariadb
mdblog:
	@$(DOCKER) logs 42mariadb

#Logs wp
wplog:
	@$(DOCKER) logs 42wordpress

#Logs nginx
nginxlog:
	@$(DOCKER) logs 42nginx

#Stop all containers
down:
	@$(COMPOSE) down

#Stop all containers, their images and their volumes
#Remove path and clear all environment
clean:
	@$(COMPOSE) down --volumes --rmi all --remove-orphans
	@$(DOCKER) system prune --volumes --all --force
	@sudo rm -rf $(DATA_PATH)
	@$(DOCKER) network prune --force
	@$(DOCKER) volume prune --force
	@sudo sed -i '/127.0.0.1	cmorel-a.42.fr/d' /etc/hosts
	@sudo chmod 644 /etc/hosts

#Redo the infra
re:	clean all

.PHONY: all list volumes network log mdblog wplog nginxlog down clean re
