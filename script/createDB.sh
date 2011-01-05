#!/bin/sh
# cria o banco de dados sqlite
if [ -e yac.db ]; then
cp yac.db yac.db.bk;
fi
#sqlite3 -echo db/yae.db < db/yae.sql
sqlite3 yac.db < yac.sql
