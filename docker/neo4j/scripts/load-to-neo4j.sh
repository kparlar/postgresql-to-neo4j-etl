#!/bin/bash

count=$(ls /var/lib/neo4j/import/completed.txt | wc -l)
while true;do
    while [[ $count != "1" ]]
    do
        echo "**** csv export has not been completed yet ****"
        sleep 10
        count=$(ls /var/lib/neo4j/import/completed.txt | wc -l)
    done
    count=$(ls /var/lib/neo4j/import/*.csv | wc -l)
    echo  "-----Count csv files: $count-----"
    echo  "-----Running neo4j-admin import-----"
    neo4j-admin import --mode=csv --database=graph.db --nodes:Catalog="/var/lib/neo4j/import/catalog.csv" --nodes:SalesCategory='/var/lib/neo4j/import/sales_category.csv' --relationships:HAS_CATEGORY='/var/lib/neo4j/import/sales_category-catalog.csv' --relationships:HAS_SUBCATEGORY='/var/lib/neo4j/import/sales_category-sales_category.csv' --id-type=STRING --report-file=/logs/import.report
    break
done