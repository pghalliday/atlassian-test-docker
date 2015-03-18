#!/bin/bash

{ gosu postgres postgres --single -jE <<-EOSQL
    CREATE USER stash WITH PASSWORD 'stash';
EOSQL
} && { gosu postgres postgres --single -jE <<-EOSQL
    CREATE DATABASE stash WITH OWNER stash;
EOSQL
}
