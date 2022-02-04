#!/bin/bash
set -eu

if [ -f "/usr/bin/docker" ] || [ -f "/usr/local/bin/docker" ]; then
  docker-compose stop
  docker-compose build
  docker-compose run --rm web /app/bin/setup.sh $1
else
  cd /app/apps/$1
  mix deps.get
  mix deps.compile

  mix ecto.drop
  mix ecto.setup
fi