# forge-psql

This project includes the recipe for launching a containerized database with the
required content for the forge-keeper project.

## Prerequisites

* Docker Engine 18.06.0+, or docker-compose 1.22.0+
* PostgreSQL 12 client (for debugging)

## How to Deploy

### docker-compose

**NOTE:** The stack definition targets deployment via swarm. To use docker-
compose, you will need to update the secrets in the `.yml` to use the file-
based secrets instead of the external/named secrets.

#### Create Password Files

These are stored in `/etc/forge/data/psql/<username>` and are locked down to
only the root user.

#### Build/Start the Service

In this directory, run as `root`:

```
docker-compose -f stack.yml up
```

### Docker Swarm

#### Create Password Secrets

- Run `docker secret create forge-data-psql-<username> -`
- Type in the password.
- Press `Enter` and `CTRL+D`.

#### Build the Image

Go to the `context` directory and run this as root:

```
docker build -t forge-data .
```

#### Deploy the Service

In this directory, run as `root`:

```
docker stack deploy -c stack.yml forge-data
```

## Connecting

```
psql -h localhost -p 55432 -U <user> -d forge_data
```