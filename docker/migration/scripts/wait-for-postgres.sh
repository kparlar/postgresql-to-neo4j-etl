#!/bin/sh

set -e

host=$POSTGRES_HOST
user=$POSTGRES_USER
echo "HOST: "$host

until PGPASSWORD=$POSTGRES_PASSWORD psql -h $host -U $user -c '\q'; do
  echo "Postgres is unavailable - sleeping"
  sleep 10
done

echo "Postgres is up - executing command"
