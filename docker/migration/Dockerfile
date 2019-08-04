FROM postgres:10.0-alpine

ENV SERVICE_NAME=postgresql-to-neo4j-etl
WORKDIR /$SERVICE_NAME

COPY ./docker/migration/scripts/ /$SERVICE_NAME/
COPY ./docker/migration/headers/ /$SERVICE_NAME/headers/
COPY ./docker/migration/sqls/ /$SERVICE_NAME/sqls/

CMD ["./migration.sh"]