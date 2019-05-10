# rancher-cert

Generate a self-signed cert for running Rancher 2 locally without browser cert errors.

When running Rancher locally the default self-signed cert may not work
with your browser. You might see an error like

```none
NET::ERR_CERT_INVALID
```

See the first answer on
https://serverfault.com/questions/845766/generating-a-self-signed-cert-with-openssl-that-works-in-chrome-58
which describes how to generate a certificate with AltName. To make this work
locally I'm using the name "rancherlocal". Certificates are generated in a local
volume and will not be regenerated unless that volume is deleted.

Note that the cert will still be untrusted...

```none
NET::ERR_CERT_AUTHORITY_INVALID
```

...but the browser should give you an "advanced" option to access the site anyway.

## How to run

- Update your `/etc/hosts` file to point rancherlocal to 127.0.0.1

  ```none
  127.0.0.1 rancherlocal
  ```

- Build and run the image

  ```sh
  docker build -t rancherlocal .
  docker run -d --name rancherlocal \
    -v rancher_certs:/etc/rancher/ssl \
    -v rancher_data:/var/lib/rancher \
    -p 443:443 \
    rancherlocal
  ```

- Access Rancher on https://rancherlocal
- Accept the untrusted certificate at browser prompt

## Run portainer for debugging

```sh
docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data --name portainer portainer/portainer
```

Access portainer on http://localhost:9000 to check "rancherlocal" container logs
and settings.
