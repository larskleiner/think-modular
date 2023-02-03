.PHONY: all $(MAKECMDGOALS)

include .env
export

setup: destroy build start install update generate-login-url ## Setup application from scratch.

destroy: ## Destroy application.
	docker-compose down --remove-orphans

build: ## Build application.
	docker-compose build

start: ## Start application.
	docker-compose up -d

stop: ## Stop application.
	docker-compose stop

install: ## Install application.
	docker-compose exec -T drupal composer install --ignore-platform-reqs --prefer-source
	docker-compose exec -T drupal drush si social --db-url=mysql://$(DB_USER):$(DB_PASSWORD)@$(DB_HOST)/$(DB_NAME) -y
	docker-compose exec -T drupal drush cset system.site uuid "$(DRUPAL_UUID)" -y

update: ## Update application.
	docker-compose exec -T drupal drush cr
	docker-compose exec -T drupal drush updb -y
	docker-compose exec -T drupal drush cim -y
	docker-compose exec -T drupal drush cr

generate-login-url: ## Generate a one-time login link
	docker-compose exec -T drupal drush uli

ssh: ## Login to the PHP container's shell
	docker exec -it think-modular_drupal bash

help: ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
