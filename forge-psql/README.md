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

#### Create Secrets

You need to ensure the following details are captured as docker secrets:
* **host:** database hostname
* **port:** database port
* **name:** database name
* **postgres-user** and **postgres-password**
* **conductor-user** and **conductor-password**
* **drone-user** and **drone-password**
* **monitor-user** and **monitor-password**

- Run `docker secret create forge-keeper-psql-<secret> -`
- Type in the secret.
- Press `Enter` and `CTRL+D`.

#### Build the Image

Go to the `context` directory and run this as root:

```
docker build -t forge-keeper-db .
```

#### Deploy the Service

In this directory, run as `root`:

```
docker stack deploy -c stack.yml forge-keeper-db
```

## Connecting

```
psql -h <host> -p <port> -U <user> -d <db>
```