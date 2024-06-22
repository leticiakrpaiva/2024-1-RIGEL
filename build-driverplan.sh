#!/bin/bash

docker build \
	--tag 'driverplan:latest' \
	--build-arg="DUSER_UID=$(id -u)" \
	--build-arg="DUSER_GID=$(id -g)" \
	--file=Dockerfile .

mkdir -p data/web/static data/web/media data/postgres/data
