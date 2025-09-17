# OpenTelemetry Example Running Ruby v2.7.7 and Rails v6.0.6.1

Ensure you're on the correct Ruby version:

```sh
rbenv local 2.7.7
```

Install deps:

```sh
bundle install
```

Start server w/ ENV vars for configuration:

```sh
env OTEL_RESOURCE_ATTRIBUTES="highlight.project_id=YOUR_LD_SDK_KEY" OTEL_EXPORTER_OTLP_ENDPOINT="https://otel.observability.app.launchdarkly.com:4318" OTEL_TRACES_EXPORTER="otlp" rails server
```
