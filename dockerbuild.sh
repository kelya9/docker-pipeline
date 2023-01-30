#!/bin/bash
tag = ${BUILD_NUMBER}
docker build -t webapp:$tag .
docker tag webapp:$tag 145682747025.dkr.ecr.us-east-1.amazonaws.com/dockerstore:$tag
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 145682747025.dkr.ecr.us-east-1.amazonaws.com
docker push 145682747025.dkr.ecr.us-east-1.amazonaws.com/dockerstore:$tag

