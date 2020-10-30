#!/bin/bash
set -e

printf "creating network --->\n"
docker network create notes-api-network;
printf "network created --->\n"

printf "\n"

printf "starting db container --->\n"
docker container run \
    --detach \
    --name=db-container \
    --env POSTGRES_DB=notesdb \
    --env POSTGRES_PASSWORD=63eaQB9wtLqmNBpg \
    --network=notes-api-network \
    postgres:12;
printf "db container started --->\n"

printf "\n"

cd api;

printf "creating api image --->\n"
docker image build . --tag notes-api-image;
printf "api image created --->\n"
printf "starting api container --->\n"
docker container run \
    --detach \
    --name=notes-api-container \
    --env-file .env \
    --env DB_PASSWORD=63eaQB9wtLqmNBpg \
    --publish=3000:3000 \
    --network=notes-api-network \
    notes-api-image;

docker container exec notes-api-container npm run db:migrate;
printf "api container started --->\n"

printf "\n"

printf "all containers are up and running"