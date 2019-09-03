FROM elixir:1.8

COPY ./ ./app
WORKDIR ./app

RUN rm -rf /app/_build
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN mix compile

EXPOSE 4000

ENTRYPOINT iex -S mix
