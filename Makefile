install-yarn:
  -curl -o- -L https://yarnpkg.com/install.sh | bash
	yarn install

install-elixir:
	brew install elixir

install:
	mix deps.get

setup: install-yarn install-elixir install compose-detached-db create-db migrate

test-api-docs:
	dredd ./apiary.apib http://127.0.0.1:4000

test:
	MIX_ENV=test mix espec

drop-db:
	mix ecto.drop

create-db:
	mix ecto.create

migrate:
	mix ecto.migrate

reset-db: drop-db create-db migrate

compile:
	mix compile

run:
	iex -S mix

build-and-run: compile run

compose-detached-db:
	docker-compose run -d --service-ports sb-pg

compose-create-db:
	docker-compose run --entrypoint="make create-db" api

compose-migrate-db:
	docker-compose run --entrypoint="make migrate" api

compose-build:
	docker-compose build

compose-run:
	docker-compose run --rm --service-ports api

compose-build-up:
	docker-compose up --build api
