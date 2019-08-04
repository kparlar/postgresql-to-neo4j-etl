#!/bin/sh

sudo chmod 777 -R ./docker/neo4j/
rm -v ./docker/neo4j/conf/*
rm -rf ./docker/neo4j/data
rm -v ./docker/neo4j/import/*
rm -v ./docker/neo4j/logs/*