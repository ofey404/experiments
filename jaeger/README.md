# jaeger

This directory is for learning jaeger tracing system.

## Dependencies

We use all-in-one jaeger image like this:

```bash
docker run -d --name jaeger \
  -e COLLECTOR_ZIPKIN_HOST_PORT=:9411 \
  -p 5775:5775/udp \
  -p 6831:6831/udp \
  -p 6832:6832/udp \
  -p 5778:5778 \
  -p 16686:16686 \
  -p 14250:14250 \
  -p 14268:14268 \
  -p 14269:14269 \
  -p 9411:9411 \
  jaegertracing/all-in-one:1.30
```

Then we install some python dependencies:

```bash
pip install opentelemetry-api opentelemetry-sdk opentelemetry-exporter-jaeger
```

## UI

http://localhost:16686/search