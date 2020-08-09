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
    listen NGINX_PORT;
    server_name NGINX_HOST [NGINX_HOST_ALIAS [...]];
    location / {
        proxy_pass http://APP_HOST:APP_PORT/;
    }
}
```

Set the below values:
* **NGINX_PORT:** The port where requests are served.
* **NGINX_HOST:** The host where requests are served.
* **NGINX_HOST_ALIAS:** (optional) Additional alias(es), e.g., www.host.com
* **APP_HOST:** The host where the underlying web app is served.
* **APP_PORT:** The port where the underlying web app is served.

Set the `nginx.conf` as a docker secret:

```
cat nginx.conf | docker secret create forge-keeper-nginx-forward -
```

### Deploy

In this directory, run:

```
docker stack deploy -c stack.yml nginx
```
