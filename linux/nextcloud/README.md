# Getting started

```docker
# start the containers
docker compose up -d

# if you want to watch the logs
docker compose logs -f
```

## Troubleshooting

`Access through untrusted domans`

The configurations are documented in the [official documentation](https://docs.nextcloud.com/server/25/admin_manual/installation/installation_wizard.html#trusted-domains), but it does not address the issue in the context of docker.

First, we need to clean any prior configurations that may have been set up during the failed launch:

```docker
# this line will remove the volumes that were created
docker compose down -v
```

Add the following environment variable:

```
 NEXTCLOUD_TRUSTED_DOMAINS: <SERVER_IP>
```

> In my samples, this should already be set up, but this background information may be helpful
