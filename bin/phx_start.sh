#!/bin/bash
set -eu

if [ -f "/usr/bin/docker" ] || [ -f "/usr/local/bin/docker" ]; then
  docker-compose run --rm web bash /app/bin/phx_start.sh $1
else
  cd /app/apps/$1
  mix phx.server
fi