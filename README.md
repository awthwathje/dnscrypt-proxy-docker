# dnscrypt-proxy-docker

This project makes the Dockerized [dnscrypt-proxy](https://github.com/DNSCrypt/dnscrypt-proxy) from the latest Alpine available for the general public.

## Run using a pre-built Docker image

Example `docker-compose.yml` config:

```yaml
version: "3.8"
services:
  dnscrypt_proxy:
    image: ghcr.io/awthwathje/dnscrypt-proxy-docker
    ports:
      - 53:53
    environment:
      - SERVER_NAMES=cloudflare,wikimedia # optional
```

Issuing `docker-compose up` command will run the app on port `53`. If you omit the `SERVER_NAMES`, the predefined servers from the default config will be used, which is `cloudflare` only.

### Environment variables

You can pass the following env variables to the container.

| Name | Example | Description |
|----------|----------|----------|
|   `SERVER_NAMES`   |   `cloudflare,wikimedia`   |   Comma-separated list of server names to use. |

## If you want to use your own config file

If you have your own `dnscrypt-proxy.toml`, you can mount it to `/app/dnscrypt-proxy.toml` and it will be used instead of a provided one:

Example `docker-compose.yml` config:

```yaml
version: "3.8"
services:
  dnscrypt_proxy:
    image: ghcr.io/awthwathje/dnscrypt-proxy-docker
    ports:
      - 53:53
    volumes:
      - ./dnscrypt-proxy.toml:/app/dnscrypt-proxy.toml
```

