RAILS_CONTAINER = web

.PHONY: app

app-build:
	@docker-compose build

app-init:
	@docker-compose run --rm $(RAILS_CONTAINER) bash -c \
      "bundle install && rails db:setup"

app:
	@docker-compose up

app-detach:
	@docker-compose up -d

app-bash:
	@docker-compose run --rm $(RAILS_CONTAINER) bash

app-running-bash:
	@docker-compose exec $(RAILS_CONTAINER) bash

app-stop:
	@docker-compose stop

app-down:
	@docker-compose down

app-down-v:
	@docker-compose down -v
