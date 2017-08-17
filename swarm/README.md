
Prerequisites
=============

This demo requires the following software to be installed

- Virtualbox
- Docker
- Docker machine
- Docker compose
- Make

Setup
=====

Create a Docker swarm by running the following command

    . setup.sh

This script is run within the current shell context setting the value of REGISTRY used later

Build an image 
==============

    make build

Deploy and scale 
================

    docker service create -d --replicas 3 -p 80 --name demo  $REGISTRY/swarm-demo:v1

Scale the service

    docker service ps demo 
    docker service scale demo=9
    docker service ps demo 

    
Integration with Compose
===============
Given the following compose file

    version: '3'
    services:
      web1:
        image: nginx:stable-alpine
        ports:
         - "80"

      web2:
        image: 192.168.99.100:5000/swarm-demo:v1
        ports:
         - "80"

Can be deployed as a swarm services

    docker stack deploy --compose-file docker-compose.yml test

Now there should be two services running

    $ docker service ls
    ID                  NAME                MODE                REPLICAS            IMAGE                               PORTS
    fks88h45c7u0        demo                replicated          9/9                 192.168.99.100:5000/swarm-demo:v1   *:0->80/tcp
    g7g5zsk99ceb        test_web1           replicated          1/1                 nginx:stable-alpine                 *:0->80/tcp
    s2b6ile4j3w9        test_web2           replicated          1/1                 192.168.99.100:5000/swarm-demo:v1   *:0->80/tcp


Misc
====
Point Docker client at the manager node

    eval $(docker-machine env swarm-manager1)

Set the registry variable

    REGISTRY=$(docker-machine ip swarm-registry):5000

Delete all services

    docker service rm $(docker service ls -q)

