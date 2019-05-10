#!/bin/bash
set -e

mkdir -p /etc/rancher/ssl
cd /etc/rancher/ssl
if [ -f "generated" ]; then
    echo "Certs already generated"
else
    echo "Generating certs"
    openssl req -newkey rsa:2048 -x509 -nodes -keyout key.pem \
        -new -out cert.pem \
        -subj /CN=rancherlocal \
        -reqexts SAN -extensions SAN \
        -config <(cat /etc/ssl/openssl.cnf \
            <(printf '[SAN]\nsubjectAltName=DNS:rancherlocal'))
    cp cert.pem cacerts.pem
    touch generated
fi

exec entrypoint.sh
