FROM elixir:latest
MAINTAINER Thomas Graves <thomas@ooo.pm>

<<<<<<< HEAD
=======
RUN mix local.hex --force
>>>>>>> develop

RUN mkdir /app
ADD . /app
WORKDIR /app

CMD ["mix", "run"]
