# atlassian-test-docker

## Prerequisites

- docker
- fig

## Usage

- Add the following to your `/etc/hosts`

```
127.0.0.1   jira.test.net
127.0.0.1   stash.test.net
127.0.0.1   bamboo.test.net
```

- Run 

```
fig up
```

- Finish configuration by connecting to
  - http://jira.test.net/
  - http://stash.test.net/
  - http://bamboo.test.net/
- Optionally configure with Postgres databases at
  - `postgres.test.net:5432`
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

## Resetting data

- Run

```
fig rm -v
```
