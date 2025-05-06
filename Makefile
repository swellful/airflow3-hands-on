MODE ?= local
ENV_FILE=compose/.env.${MODE}
AIRFLOW_COMPOSE_FILE=compose/airflow/docker-compose.local.yaml
MARQUEZ_COMPOSE_FILE=compose/marquez/docker-compose.yaml

COMPOSE=docker compose --env-file $(ENV_FILE) -f $(AIRFLOW_COMPOSE_FILE) -f $(MARQUEZ_COMPOSE_FILE)

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

.PHONY: logs
logs:
	$(COMPOSE) logs -f

ps:
	$(COMPOSE) ps

airflow-init:
	$(COMPOSE) up airflow-init

shell:
	$(COMPOSE) exec webserver /bin/bash
