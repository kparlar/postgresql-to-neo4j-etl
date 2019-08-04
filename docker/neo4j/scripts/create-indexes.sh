#!/bin/bash

echo "Create constraint + index together"

until cypher-shell -u $NEO4J_USER -p $NEO4J_DEFAULT_PASSWORD 'CALL dbms.changePassword("'"$NEO4J_PASSWORD"'")'
do
  echo "dbms.changePassword was failed, sleeping"
  sleep 10
done


until cypher-shell -u $NEO4J_USER -p $NEO4J_PASSWORD 'CREATE CONSTRAINT ON (c:Catalog) ASSERT c.catalog_id IS UNIQUE;'
do
  echo "create Catalog index catalog_id was failed, sleeping"
  sleep 10
done

until cypher-shell -u $NEO4J_USER -p $NEO4J_PASSWORD 'CREATE CONSTRAINT ON (sc:SalesCategory) ASSERT sc.sales_category_id IS UNIQUE;'
do
  echo "create SalesCategory index sales_category_id was failed, sleeping"
  sleep 10
done

