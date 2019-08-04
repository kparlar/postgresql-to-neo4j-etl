FROM neo4j:3.5

ENV NEO4J_AUTH=neo4j/neo4j
ENV SERVICE_NAME=postgresql-to-neo4j-etl
WORKDIR /$SERVICE_NAME

COPY ./docker/neo4j/scripts/ /$SERVICE_NAME/

CMD ["./wrapper.sh"]