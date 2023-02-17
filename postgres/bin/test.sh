#!/bin/bash

set -e

cd ~

pg_ctl -o "-c listen_addresses='localhost'" -w -D /var/lib/postgresql/data -l logfile restart

psql -U postgres -d postgres -p 5432 <<-EOSQL
        CREATE ROLE gus_w;
	CREATE ROLE gus_r;
	CREATE TABLESPACE indx LOCATION '/var/lib/postgresql/data';
EOSQL

build GUS install -append -installDBSchemaSkipRoles
installApidbSchema --db postgres --create
bld GUS
