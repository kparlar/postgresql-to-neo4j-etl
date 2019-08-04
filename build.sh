#!/bin/sh

set -e

export IMAGE_MIGRATION=${IMAGE_MIGRATION:-postgresql-to-neo4j-etl-migration}
export IMAGE_NEO4J=${IMAGE_NEO4J:-postgresql-to-neo4j-etl-neo4j}

export SERVICE_TAG=${SERVICE_TAG:-latest}
echo "*** Using MIGRATION image: ${IMAGE_MIGRATION}:${SERVICE_TAG}"
echo "*** Building docker image"
docker build -f ./docker/migration/Dockerfile -t ${IMAGE_MIGRATION}:${SERVICE_TAG} .


echo "*** Using NEO4J image: ${IMAGE_NEO4J}:${SERVICE_TAG}"
echo "*** Building docker image"
docker build -f ./docker/neo4j/Dockerfile -t ${IMAGE_NEO4J}:${SERVICE_TAG} .
