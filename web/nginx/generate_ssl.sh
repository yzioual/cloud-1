#!/usr/bin/env bash
set -e

SSL_DIR="$(dirname "$0")/ssl"
mkdir -p "$SSL_DIR"

if [ ! -f "$SSL_DIR/server.crt" ] || [ ! -f "$SSL_DIR/server.key" ]; then
    echo "Generating self-signed TLS certificates in $SSL_DIR..."
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout "$SSL_DIR/server.key" \
        -out "$SSL_DIR/server.crt" \
        -subj "/C=FR/ST=Paris/L=Paris/O=Cloud1/CN=localhost"
    echo "Certificates generated successfully."
else
    echo "Certificates already exist."
fi
