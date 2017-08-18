
Prerequisites
=============
This demo requires the following software to be installed

- Virtualbox
- Docker
- Docker machine
- Make
- kubectl
- kompose

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

    make deploy

Check the dashboard to see running Deployment, Service and Pod

    minikube dashboard

and look at the expose service

    minikube service demo

Scale the Deployment

    
Integration with Compose
===============
Given the following compose file

     version: '3'
     services:
       web1:
         image: nginx:stable-alpine
         ports:
           - "80"
         labels:
           kompose.service.type: LoadBalancer
     
       web2:
         image: 192.168.99.100:5000/k8s-demo:v1
         ports:
           - "80"
         labels:
           kompose.service.type: LoadBalancer


Can be deployed as a swarm services

    kompose up

Now there should be two services running, these can be seen the web browser as follows

    minikube service web1
    minikube service web2


