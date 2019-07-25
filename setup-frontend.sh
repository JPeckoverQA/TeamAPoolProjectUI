#!/bin/bash

#docker build -t docker.io/jpeckover/pool_frontend:latest .
sudo docker pull jpeckover/pool_frontend:latest .

sudo docker run -d --name frontend -p 80:80 docker.io/jpeckover/pool_frontend:latest

#docker ps
#docker logs -f frontend
