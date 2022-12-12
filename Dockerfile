FROM debian:bullseye-slim

WORKDIR /app

ADD dnscrypt-proxy.toml /app/dnscrypt-proxy.toml

RUN apt update

RUN apt install --yes ca-certificates dnscrypt-proxy

RUN mkdir /var/log/dnscrypt-proxy

EXPOSE 53

CMD [ "dnscrypt-proxy", "-config", "/app/dnscrypt-proxy.toml" ]