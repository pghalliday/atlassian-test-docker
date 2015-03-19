# atlassian-test-docker

## Prerequisites

- docker
- docker-compose

## Usage

- Add the following to your `/etc/hosts`

```
127.0.0.1   crowd.test.net
127.0.0.1   jira.test.net
127.0.0.1   stash.test.net
127.0.0.1   bamboo.test.net
127.0.0.1   confluence.test.net
```

- Run 

```
docker-compose up
```

- Finish configuration by connecting to
  - http://crowd.test.net/
  - http://jira.test.net/
  - http://stash.test.net/
  - http://bamboo.test.net/
  - http://confluence.test.net/
- Optionally configure with Postgres databases at
  - `postgres.test.net:5432`
  - Crowd
    - database `crowd`
    - user `crowd`
    - password `crowd`
  - JIRA
    - database `jira`
    - user `jira`
    - password `jira`
  - Stash
    - database `stash`
    - user `stash`
    - password `stash`
  - Bamboo
    - database `bamboo`
    - user `bamboo`
    - password `bamboo`
  - Confluence
    - database `confluence`
    - user `confluence`
    - password `confluence`

## Resetting data

- Run

```
docker-compose rm
```

## Deployment notes

1. Run the Crowd setup wizard and configure with Postgres database (CrowdID is already configured through environment variables in docker-compose)
1. Run the JIRA setup wizard and configure with Postgres database
  - eventually the nginx gateway will timeout as JIRA restarts or something while creating the database
  - return to the base URL to continue with the wizard
  - seems to be ok to configure the same administrator user name, etc as supplied for Crowd
  - set up JIRA for 'software development', ie. 'JIRA + JIRA Agile'
1. Integrate Crowd and JIRA  following this guide - https://confluence.atlassian.com/display/CROWD/Integrating+Crowd+with+Atlassian+JIRA
  - Add groups, etc. to the default Crowd directory (we don't want separate directories for different applications - we want single sign on)
  - use `jira`/`jira` for the application name and password to match the environment variables set in `docker-compose.yml` for the `jira` container
  - Use CIDR notation to specify the JIRA IP address, eg. `172.17.1.1/24` as the IP may change
  - when adding the crowd server URL to JIRA, remember to append `/crowd`, eg. `http://crowd.test.net/crowd`
1. Run the Stash setup wizard and configure with Postgres database
  - seems to NOT be ok to configure the same administrator user name, etc as supplied for Crowd
    - The accounts do seem to get linked but the passwords do not (ie. changing the password in Crowd does not change the password required for Stash)
  - link to JIRA but don't use JIRA user database (will use Crowd)
1. Integrate Crowd and Stash  following this guide - https://confluence.atlassian.com/display/CROWD/Integrating+Crowd+with+Atlassian+Stash
  - Add groups, etc. to the default Crowd directory (we don't want separate directories for different applications - we want single sign on)
  - Add at least one group to add stash users to (eg, `stash-users`)
    - It's a good idea to add other groups and set their permissions appropriately in Stash, eg.
      - `stash-creators`
      - `stash-admins`
      - `stash-system-admins`
    - remember to add these to the `stash` application in Crowd as well
  - Use CIDR notation to specify the Stash IP address, eg. `172.17.1.1/24` as the IP may change
  - when adding the crowd server URL to Stash, remember to append `/crowd`, eg. `http://crowd.test.net/crowd`
  - to enable SSO with Crowd, log into the container and edit the `~/shared/stash-config.properties` file via `docker-compose run stash /bin/bash`
    - this will require a restart of Stash
1. Integrate JIRA and Stash
  - Under application links in both applications enable all the Oauth options for both incoming and outgoing
