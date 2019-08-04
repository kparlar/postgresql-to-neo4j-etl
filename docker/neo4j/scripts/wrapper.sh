#!/bin/bash

# turn on bash's job control
set -m

# Start the helper process
echo "load-to-neo4j - Started"
./load-to-neo4j.sh
echo "load-to-neo4j - completed"

# the my_helper_process might need to know how to wait on the
# primary process to start before it does its work and returns


# Start the primary process and put it in the background
echo "docker-entrypoint.sh neo4j - started at the background"
/docker-entrypoint.sh neo4j &

echo "create-indexes - Started"
./create-indexes.sh
echo "create-indexes - Completed"
# now we bring the primary process back into the foreground
# and leave it there
fg %1