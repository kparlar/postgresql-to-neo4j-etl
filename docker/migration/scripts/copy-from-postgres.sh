#!/bin/bash
echo "**********Copy from Postgresql to CSV - Started**********"
NODES=(catalog sales_category sales_category-catalog sales_category-sales_category)
export PGPASSWORD=$POSTGRES_PASSWORD

for i in "${NODES[@]}"
do
   echo "$i"
   test=$(head -n 1 ./sqls/sql-"$i".txt)
   psql \
       -X \
       -U $POSTGRES_USER \
       -h $POSTGRES_HOST \
       -p 5432 \
       -d test-db \
       -c "\\copy ($test) to '/postgresql-to-neo4j-etl/csv/"$i".csv' DELIMITER ',' CSV HEADER;"
done
echo "**********Copy from Postgresql to CSV - Completed**********"