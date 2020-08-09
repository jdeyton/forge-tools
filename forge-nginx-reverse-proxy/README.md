# forge-nginx-reverse-proxy

This project includes the recipe for launching an nginx-based reverse proxy
that redirects traffic to an underlying web app.

## Prerequisites

* Docker Engine 18.06.0+.

## How to Deploy

### Configuration

Create an `nginx.conf` file like the below:

```
server {
    listen 443 ssl;
    server_name NGINX_HOST [NGINX_HOST_ALIAS [...]];
    ssl_certificate /etc/ssl/certs/my-cert.pem;
    ssl_certificate_key /etc/ssl/private/my-key.pem;
    location / {
        proxy_pass http://APP_HOST:APP_PORT/;
        proxy_set_header Host "localhost";
    }
}

server {
    listen 80;
    server_name rachi rachni.arcturus.forge.digital;
    location / {
        return 301 https://$host$request_uri;
    }
}
```

Set the below values:
* **NGINX_HOST:** The host where requests are served.
* **NGINX_HOST_ALIAS:** (optional) Additional alias(es), e.g., www.host.com
* **APP_HOST:** The host where the underlying web app is served.
* **APP_PORT:** The port where the underlying web app is served.

Set the `nginx.conf` as a docker secret:

```
cat nginx.conf | docker secret create forge-keeper-nginx-conf -
```

Set the SSL certificate and key files as docker secrets:

```
cat /path/to/cert.pem | docker secret create forge-keeper-https-cert -
cat /path/to/key.pem | docker secret create forge-keeper-https-key -
```

### Deploy

In this directory, run:

```
docker stack deploy -c stack.yml nginx
```
