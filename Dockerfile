
FROM elixir:1.12.3

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install git vim sudo inotify-tools

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
RUN apt-get install -y nodejs

ARG USERID=1000
ARG GROUPID=1000

RUN groupadd -g $GROUPID devel
RUN useradd -u $USERID -g devel -m devel

COPY --chown=devel:devel . /app

USER devel

WORKDIR /app

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install --force hex phx_new 1.6.6