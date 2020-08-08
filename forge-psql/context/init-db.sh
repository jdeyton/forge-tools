#!/bin/bash

function get_secret {
    /usr/bin/head -1 "/run/secrets/psql-$1"
}

export PGHOST="$(get_secret host)"
export PGPORT="$(get_secret port)"
export PGUSER="$(get_secret postgres-user)"
export PGPASSWORD="$(get_secret postgres-pass)"

db="$(get_secret name)"
conductor="$(get_secret conductor-user)"
drone="$(get_secret drone-user)"
monitor="$(get_secret monitor-user)"

psql -d postgres <<EOF

CREATE DATABASE $db;
\connect $db;

CREATE ROLE $conductor WITH LOGIN PASSWORD '$(get_secret conductor-pass)';
CREATE ROLE $drone     WITH LOGIN PASSWORD '$(get_secret drone-pass)';
CREATE ROLE $monitor   WITH LOGIN PASSWORD '$(get_secret monitor-pass)';

CREATE TABLE archive (
    archive_uuid  uuid NOT NULL,
    name          text NOT NULL,
    description   text NOT NULL,
    data_type     text NOT NULL,
    units         text NOT NULL,
    creation_time timestamp NOT NULL DEFAULT NOW(),
    PRIMARY KEY (archive_uuid)
);
ALTER TABLE archive OWNER TO $conductor;

CREATE TABLE drone (
    drone_uuid    uuid NOT NULL,
    name          text NOT NULL,
    description   text NOT NULL,
    creation_time timestamp NOT NULL DEFAULT NOW(),
    PRIMARY KEY (drone_uuid)
);
ALTER TABLE drone OWNER TO $conductor;

CREATE TABLE event (
    archive_uuid uuid NOT NULL REFERENCES archive(archive_uuid),
    drone_uuid   uuid NOT NULL REFERENCES drone(drone_uuid),
    event_time   timestamp NOT NULL,
    event_value  text NOT NULL,
    PRIMARY KEY (archive_uuid, drone_uuid, event_time)
);
ALTER TABLE event OWNER TO $conductor;
GRANT INSERT ON event TO $drone;

EOF

unset PGPASSWORD