# File: Makefile

# ENV files
ENV_DEV=.env.dev
ENV_PROD=.env.prod

# Docker Compose Files
COMPOSE_DEV=docker-compose.dev.yml
COMPOSE_PROD=docker-compose.prod.yml
COMPOSE_NGINX=docker-compose.yml

# ===== Development =====

dev-up:
	docker-compose --env-file .env.dev -f docker-compose.dev.yml down --remove-orphans
	docker-compose --env-file .env.dev -f docker-compose.dev.yml up -d --build


dev-down:
	docker-compose --env-file $(ENV_DEV) -f $(COMPOSE_DEV) down

dev-logs:
	docker logs -f sentosa-api-dev

dev-db-logs:
	docker logs -f sentosa-db-dev

dev-restart:
	docker-compose --env-file $(ENV_DEV) -f $(COMPOSE_DEV) restart

# ===== Production =====

prod-up:
	docker-compose --env-file $(ENV_PROD) -f $(COMPOSE_PROD) up -d --build

prod-down:
	docker-compose --env-file $(ENV_PROD) -f $(COMPOSE_PROD) down

prod-logs:
	docker logs -f sentosa-api-prod

prod-db-logs:
	docker logs -f sentosa-db-prod

prod-restart:
	docker-compose --env-file $(ENV_PROD) -f $(COMPOSE_PROD) restart


# ===== Common =====
# Build and run the Nginx container
nginx-up:
	docker-compose -f $(COMPOSE_NGINX) up -d
nginx-down:
	docker-compose -f $(COMPOSE_NGINX) down
nginx-logs:
	docker logs -f nginx_proxy
nginx-restart:
	docker-compose -f $(COMPOSE_NGINX) restart

# Build and run the Jenkins container
jenkins-up:
	docker-compose -f docker-compose.jenkins.yml up -d
jenkins-down:
	docker-compose -f docker-compose.jenkins.yml down
jenkins-logs:
	docker logs -f jenkins
jenkins-restart:
	docker-compose -f docker-compose.jenkins.yml restart

# Restart all environments
restart-all: dev-restart prod-restart nginx-restart

# Nonaktifkan Maintenance
maintenance-off:
	docker-compose -f $(COMPOSE_NGINX) stop
	cp ./nginx/conf.d/sentosafishery.com.original.conf ./nginx/conf.d/sentosafishery.com.conf
	cp ./nginx/conf.d/cms.sentosafishery.com.original.conf ./nginx/conf.d/cms.sentosafishery.com.conf
	docker-compose -f $(COMPOSE_NGINX) up -d

# Aktifkan Maintenance
maintenance-on:
	docker-compose -f $(COMPOSE_NGINX) stop
	cp ./nginx/conf.d/maintenance.conf ./nginx/conf.d/sentosafishery.com.conf
	cp ./nginx/conf.d/maintenance.conf ./nginx/conf.d/cms.sentosafishery.com.conf
	docker-compose -f $(COMPOSE_NGINX) up -d
