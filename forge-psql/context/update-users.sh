#!/bin/bash

db=forge_data
admin=postgres

export PGPASSWORD=$(/usr/bin/head -1 /run/secrets/forge-data-psql-$admin)
for user in conductor drone monitor; do
    pw=$(/usr/bin/head -1 /run/secrets/forge-data-psql-$user)
    psql -d $db -U $admin -c \
        "ALTER ROLE $user WITH PASSWORD '$pw'"
done
