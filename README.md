# OpenTelemetry Example Running Ruby v2.7.7 and Rails v6.0.6.1

Ensure you're on the correct Ruby version:

```sh
rbenv local 2.7.8
```

Install deps:

```sh
bundle install
```

Start server w/ ENV vars for configuration:

```sh
env OTEL_RESOURCE_ATTRIBUTES="highlight.project_id=YOUR_LD_SDK_KEY" OTEL_EXPORTER_OTLP_ENDPOINT="https://otel.observability.app.launchdarkly.com:4318" OTEL_TRACES_EXPORTER="otlp" rails server
```

## Run in GitHub Codespaces

1) Create a new Codespace on this repo. It will auto-detect `.devcontainer` and build the container with Ruby 2.7 and Postgres.

2) After the container starts, dependencies and database will be prepared automatically. If needed, run:

```sh
bundle install && bundle exec rails db:prepare
```

3) Start Rails (port is forwarded automatically):

```sh
OTEL_RESOURCE_ATTRIBUTES="highlight.project_id=YOUR_LD_SDK_KEY" \
OTEL_EXPORTER_OTLP_ENDPOINT="https://otel.observability.app.launchdarkly.com:4318" \
OTEL_TRACES_EXPORTER="otlp" \
bundle exec rails server -b 0.0.0.0 -p 3000
```

Or use VS Code Tasks: “Rails: server”.

Database connection in Codespaces is configured via env vars in the devcontainer: `DATABASE_HOST=db`, `DATABASE_USERNAME=postgres`, `DATABASE_PASSWORD=postgres`.

## Run locally with Docker

1) Build and start containers:

```sh
docker compose up --build
```

2) Visit http://localhost:3000

Environment is wired for Postgres inside Docker (`db:5432`). Override OTEL envs as needed:

```sh
docker compose run --rm -e OTEL_EXPORTER_OTLP_ENDPOINT=... -e OTEL_RESOURCE_ATTRIBUTES=... app bash
```
