ENV_FILE ?= compose/base/.env.local
COMPOSE_FILE ?= compose/local/docker-compose.yaml
COMPOSE=docker compose --env-file $(ENV_FILE) -f $(COMPOSE_FILE)

define insert_uid
	@if ! grep -q '^AIRFLOW_UID=' $(ENV_FILE); then \
		echo "AIRFLOW_UID=$$(id -u)" >> $(ENV_FILE); \
		echo "Added AIRFLOW_UID=$$(id -u) to $(ENV_FILE)"; \
	else \
		echo "AIRFLOW_UID is already set in $(ENV_FILE)"; \
	fi
endef

prepare-env:
	$(call insert_uid)

up: prepare-env
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

logs:
	$(COMPOSE) logs -f

ps:
	$(COMPOSE) ps

restart: prepare-env
	$(COMPOSE) down
	$(COMPOSE) up -d

airflow-init: prepare-env
	$(COMPOSE) up airflow-init

shell:
	$(COMPOSE) exec webserver /bin/bash