install-yarn:
  -curl -o- -L https://yarnpkg.com/install.sh | bash
	yarn install

test-api-docs:
	dredd ./apiary.apib http://127.0.0.1:4000

run:
	iex -S mix
