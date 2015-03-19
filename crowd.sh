#!/bin/bash

{ gosu postgres postgres --single -jE <<-EOSQL
    CREATE USER crowd WITH PASSWORD 'crowd';
EOSQL
} && { gosu postgres postgres --single -jE <<-EOSQL
    CREATE DATABASE crowd WITH OWNER crowd;
EOSQL
} && { gosu postgres postgres --single -jE <<-EOSQL
    CREATE DATABASE crowdid WITH OWNER crowd;
EOSQL
}
