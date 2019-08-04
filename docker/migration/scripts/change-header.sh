#!/bin/bash
echo "**********Change Header - Started**********"
chmod 777 -R ./
echo "**********First Line Deletion started**********"
NODES=(catalog sales_category sales_category-catalog sales_category-sales_category)
echo "**********Delete Header of CSVs - Started **********"
for i in "${NODES[@]}"
do
   echo "$i"
   sed -i 1d ./csv/"$i".csv
done
echo "**********Delete Header of CSVs - Started **********"
echo "**********Add New Header to CSVs - Started**********"

for i in "${NODES[@]}"
do
   echo "$i"
   test=$(head -n 1 ./headers/header-"$i".txt)
   sed -i '1s/^/'"$test"'\n/' ./csv/"$i".csv
   #sed -i 's/,f$/,false/g' ./csv/"$i".csv
   #sed -i 's/,t$/,true/g' ./csv/"$i".csv
done
count=$(ls ./csv/*.csv | wc -l)
if [ ${#NODES[@]} -eq 0 ]; then
    echo "CSVs have not been created"
else
    touch ./csv/completed.txt
fi


chmod 777 -R ./
echo "**********Add New Header to CSVs - Completed**********"