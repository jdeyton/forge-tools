# forge-psql

This project includes the recipe for launching a containerized database with the
required content for the forge-keeper project.

## Prerequisites

* Docker Engine 18.06.0+, or docker-compose 1.22.0+
* PostgreSQL 12 client (for debugging)

## How to Deploy

### Create the password files

These are stored in /etc/forge/data/psql/<username> and are locked down to only
the root user.

### docker-compose

In this directory, run as `root`:

```
docker-compose -f stack.yml up
```

### Docker Swarm

TBD!!!

## Connecting

```
psql -h localhost -p 55432 -U <user> -d forge_data
```