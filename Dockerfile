FROM elixir:latest
MAINTAINER Thomas Graves <thomas@ooo.pm>


RUN mkdir /app
ADD . /app
WORKDIR /app

CMD ["mix", "run"]
