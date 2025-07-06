#!/bin/bash

if ! docker plugin ls | grep -q '^loki[[:space:]].*ENABLED'; then
  docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions >/dev/null 2>&1 || true
fi

echo "Pulling latest images..."
docker compose -f compose.yaml pull

echo "Removing old containers..."
docker compose -f compose.yaml down

echo "Starting up with new images..."
docker compose -f compose.yaml up -d

echo "Cleaning up old images..."
docker image prune -f