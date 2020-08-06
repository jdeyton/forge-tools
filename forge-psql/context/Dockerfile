FROM postgres:12.3
COPY init-db.sql /docker-entrypoint-initdb.d/
COPY update-users.sh /docker-entrypoint-initdb.d/
