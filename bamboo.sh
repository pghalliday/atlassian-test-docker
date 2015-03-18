#!/bin/bash

{ gosu postgres postgres --single -jE <<-EOSQL
    CREATE USER bamboo WITH PASSWORD 'bamboo';
EOSQL
} && { gosu postgres postgres --single -jE <<-EOSQL
    CREATE DATABASE bamboo WITH OWNER bamboo;
EOSQL
}
