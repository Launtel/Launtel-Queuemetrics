# Launtel Queuemetrics

[![Docker Pulls](https://img.shields.io/docker/pulls/mtlynch/logpaste.svg?maxAge=604800)](https://hub.docker.com/r/agentsquirrel/launtel_queuemetrics)

A build of Queuemetrics designed for use inside Launtel version pinned at: 19.10.21-137

Allows for variables to be set inside a compose file unlike the stock Loway build.

## Running

To start using this QM build a few pieces need to be laid out first:

* A database will need to created either on the same host as the container or elsewhere.
* The web.xml file from this repo will need to be downloaded or created. This file is mounted into the container at creation time so on container deletion you don't lose your license key.
* Download the docker-compose.yml file.

The compose file needs to be modified with the relevant details from your database.
Any other variables such as timezone can also be modified as needed.

```
services:
  qm:
    container_name: mycontainer
    image: https://hub.docker.com/r/agentsquirrel/launtel_queuemetrics
    hostname: mycontainer
    network_mode: bridge
    environment:
    - TZ=Australia/Melbourne
    - DB=mydb
    - DBPASS=mydbpass
    - DBUSER=mydbuser
    - DBHOST=mydbhost
    - MEM=265
    - VIRTUAL_HOST=myvhost.name
    - CERT_NAME=mycertificate
    ports:
    - "8080"
    volumes:
    - web.xml:/data/web.xml
```

The container is designed to run behind a reverse proxy such as: [https://hub.docker.com/r/jwilder/nginx-proxy](https://hub.docker.com/r/jwilder/nginx-proxy)

If not running behind a reverse proxy, add the port you would like exposing to the "ports" directive in the format:
```
ports:
- "8080:8080"
```
Which would expose port 8080 on the Docker host.

In addition the VIRTUAL_HOST and CERT_NAME variables can be removed if no reverse proxy is in front of Queuemetrics.

Once everything is setup, run:

```
docker-compose up -d
```
