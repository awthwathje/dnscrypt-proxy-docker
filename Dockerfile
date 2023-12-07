FROM debian:bullseye-slim

WORKDIR /app

ADD dnscrypt-proxy.toml /app/dnscrypt-proxy.toml

RUN apt update && \
    apt upgrade --yes && \
    apt install --yes ca-certificates dnscrypt-proxy

RUN groupadd -r dnscrypt --gid=65053 && \
    useradd -r -g dnscrypt --uid=65053 dnscrypt

USER dnscrypt

RUN mkdir /var/log/dnscrypt-proxy

EXPOSE 53

CMD [ "dnscrypt-proxy", "-config", "/app/dnscrypt-proxy.toml" ]
