#!/bin/sh

echo "=== setup env var =="
if [ "$PGDATA" != "$HOME/postgres_data" ]; then
    echo "set PGDATA"
    echo 'export PGDATA="$HOME/postgres_data"' >> ~/.zshrc
else
    echo "PGDATA already set"
fi
export PGDATA="$HOME/postgres_data"

if [ "$PGHOST" != "/tmp" ]; then
    echo "set PGHOST"
    echo 'export PGHOST="/tmp"' >> ~/.zshrc
else
    echo "PGHOST already set"
fi
export PGHOST="/tmp"

echo "=== remove old PGDATA ==="
if [ -d "$PGDATA" ]; then
    rm -rf "$PGDATA"
fi

if [ ! -f roger_roger.dump ]; then
    echo "/!\ file roger_roger.dump not found"
    exit 1
fi


initdb --locale "$LANG" -E UTF8

echo "=== Start server PostgreSQL ==="
postgres -k "$PGHOST" > /tmp/logfile_pg 2>&1 &
PID=$!

echo "waiting server..."
sleep 3

echo "=== create database ==="

createuser -s postgres
createdb -U postgres roger_roger

echo "=== import databse from dump ==="

pg_restore -U postgres -O -d roger_roger roger_roger.dump

echo "=== stop server ==="
pg_ctl stop -D "$PGDATA"

echo "=== end ==="
echo "close this terminal"
