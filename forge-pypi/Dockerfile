FROM pywharf/pywharf:0.2.3

COPY config.toml .
COPY admin.toml .

EXPOSE 60001/tcp

VOLUME ["/pywharf-root"]

ENTRYPOINT ["pywharf", "server", "/pywharf-root", "--config=./config.toml", "--admin_secret=./admin.toml", "--port=60001"]
