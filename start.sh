#!/bin/sh

if [ -n "${SERVER_NAMES}" ]; then
    formatted_server_names=$(echo "${SERVER_NAMES}" | sed "s/,/','/g")
    formatted_server_names="['${formatted_server_names}']"

    sed -i "s/server_names = .*/server_names = ${formatted_server_names}/" /app/dnscrypt-proxy.toml
fi

exec dnscrypt-proxy
