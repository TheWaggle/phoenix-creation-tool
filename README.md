# セットアップ手順

## phonix app を作成する場合

```
mkdir apps
bin/setup.sh
bin/login.sh
cd apps
mix phx.new プロジェクト名
```

hostname を db に変更
config/dev.ex
```
config :sample, Sample.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "db",
  database: "sample_dev",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
```

ip を [ip: {0, 0, 0, 0}, port: 4000] に変更
config/dev.ex
```
config :sample, SampleWeb.Endpoint,
  # Binding to loopback ipv4 address prevents access from other machines.
  # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
  http: [ip: {0, 0, 0, 0}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
```

```
cd プロジェクト名
mix ecto.create
mix phx.server
```

shell script の編集
bin/phx_start.sh
```
#!/bin/bash
set -eu

if [ -f "/usr/bin/docker" ] || [ -f "/usr/local/bin/docker" ]; then
  docker-compose run --rm web bash /app/bin/phx_start.sh
else
  cd /app/apps/プロジェクト名
  mix phx.server
fi
```

bin/setup.sh
```
!/bin/bash
set -eu

if [ -f "/usr/bin/docker" ] || [ -f "/usr/local/bin/docker" ]; then
  docker-compose stop
  docker-compose build
  docker-compose run --rm web /app/bin/setup.sh
else
  cd /app/apps/プロジェクト名
  mix deps.get
  mix deps.compile

  mix ecto.drop
  mix ecto.setup
fi
```

## phonix app が存在する場合

```
git clone リポジトリ
cd プロジェクト名
bin/setup.sh
bin/start.sh
bin/phx_start.sh
```









