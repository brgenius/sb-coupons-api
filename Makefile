install-yarn:
  -curl -o- -L https://yarnpkg.com/install.sh | bash
	yarn install

install-elixir:
	brew install elixir

install:
		mix deps.get

setup: install-yarn install-elixir install

test-api-docs:
	dredd ./apiary.apib http://127.0.0.1:4000

test:
	MIX_ENV=test mix espec

compile:
	mix compile

run:
	iex -S mix

build-and-run: compile run
