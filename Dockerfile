FROM elixir:1.8

COPY ./ ./

RUN mix local.hex --force
RUN mix deps.get
RUN make compile

EXPOSE 4000/tcp

ENTRYPOINT iex -S mix
