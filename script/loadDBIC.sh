#!/bin/sh
# cria as classes do DBIC Schema 
#dbicdump -o dump_directory=./lib -o debug=1 -o use_moose=true yae::Schema 'dbi:SQLite:./db/yae.db'

./script/yac_create.pl model YAC DBIC::Schema YAC::Schema create=static dbi:SQLite:yac.db on_connect_do="PRAGMA foreign_keys = ON"
