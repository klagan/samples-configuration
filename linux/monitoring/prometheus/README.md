# Getting started

The prometheus server is **active** and the node exporters are **passive**.

This means that the node exporter presents metrics - passively - on monitored server port 9100.  Periodically, the server will scrape these metrics - actively - by connecting to port 9100 and pulling the data.

A few more switches you can use in the `docker-compose.yml` to help manage data storage:

|Command|Description|
|-|-|
|storage.tsdb.retention.time|The primary flag for setting retention based on time. Supported units are y (years), w (weeks), d (days), h (hours), m (minutes), s (seconds), and ms (milliseconds)|
|storage.tsdb.retention.size|You can also set a maximum disk usage for your metrics. For example, --storage.tsdb.retention.size=10GB. Prometheus will delete old data whenever either the time or size limit is reached|

## Grafana

Ensure you create the grafana folders defined in the `docker-compose.yml`:

`mkdir -p ./grafana/data ./grafana/datasources`
