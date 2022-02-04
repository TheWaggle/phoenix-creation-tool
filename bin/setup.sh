#!/bin/bash
set -eu

if [ -f "/usr/bin/docker" ] || [ -f "/usr/local/bin/docker" ]; then
  docker-compose stop
  bin/setup.sh
else
  docker-compose build
  bin/start.sh

  docker-compose run --rm web /bin/bash
  cd /app/apps/$1
  mix desp.get
  mix desp.compile

  mix ecto.drop
  mix ecto.setup
fi