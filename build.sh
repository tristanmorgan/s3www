#!/bin/sh

export DOCKER_HOST=ssh://tristan@inspirone.node.home.consul

TS_VAR=$(date +%s)
docker build --progress plain --platform=linux/amd64 -t registry.service.home.consul/s3www:$TS_VAR-amd64 .
docker build --progress plain --platform=linux/arm64/v8 -t registry.service.home.consul/s3www:$TS_VAR-arm64 .
docker push registry.service.home.consul/s3www:$TS_VAR-arm64
docker push registry.service.home.consul/s3www:$TS_VAR-amd64

docker manifest create registry.service.home.consul/s3www:$TS_VAR --amend registry.service.home.consul/s3www:$TS_VAR-arm64 --amend registry.service.home.consul/s3www:$TS_VAR-amd64
docker manifest push registry.service.home.consul/s3www:$TS_VAR
docker manifest rm registry.service.home.consul/s3www:$TS_VAR

docker manifest create registry.service.home.consul/s3www:latest --amend registry.service.home.consul/s3www:$TS_VAR-arm64 --amend registry.service.home.consul/s3www:$TS_VAR-amd64
docker manifest push registry.service.home.consul/s3www:latest
docker manifest rm registry.service.home.consul/s3www:latest
