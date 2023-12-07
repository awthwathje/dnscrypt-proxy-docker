FROM debian:bullseye-slim

WORKDIR /app

ADD dnscrypt-proxy.toml /app/dnscrypt-proxy.toml

RUN apt update && \
    apt upgrade --yes && \
    apt install --yes ca-certificates dnscrypt-proxy

RUN groupadd -r dnscrypt --gid=65053 && \
    useradd -r -g dnscrypt --uid=65053 dnscrypt

RUN mkdir /var/log/dnscrypt-proxy && \
    chown dnscrypt:dnscrypt /var/log/dnscrypt-proxy

USER dnscrypt

EXPOSE 53

CMD [ "dnscrypt-proxy", "-config", "/app/dnscrypt-proxy.toml" ]
