FROM elixir:latest
MAINTAINER Thomas Graves <thomas@ooo.pm>

RUN mix local.hex --force

RUN mkdir /app
ADD . /app
WORKDIR /app

CMD ["mix", "run"]
