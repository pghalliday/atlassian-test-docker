#!/bin/bash

{ gosu postgres postgres --single -jE <<-EOSQL
    CREATE USER jira WITH PASSWORD 'jira';
EOSQL
} && { gosu postgres postgres --single -jE <<-EOSQL
    CREATE DATABASE jira WITH OWNER jira;
EOSQL
}
