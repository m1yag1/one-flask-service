# One Flask Service 

## Purpose

This service is meant to be a test service you can startup in Docker
Swarm to see if your setup is working.

## How it works

Since Docker `docker run` and the `docker service` command are so similar this project utilizes that to allow someone to quickly start the service to check if their AWS load balancers are working or whatever simply needs to return a response.

I wanted a way I could test that I setup everything correctly in my swarm after a deployment without needed to manage too much more than that. 

## Deploy

