#!/bin/bash
echo "**********Migration - Started**********"
./wait-for-postgres.sh
./copy-from-postgres.sh
./change-header.sh
echo "**********Migration - Completed**********"