#!/bin/bash

{ gosu postgres postgres --single -jE <<-EOSQL
    CREATE USER confluence WITH PASSWORD 'confluence';
EOSQL
} && { gosu postgres postgres --single -jE <<-EOSQL
    CREATE DATABASE confluence WITH OWNER confluence;
EOSQL
}
