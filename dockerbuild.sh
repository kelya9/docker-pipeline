#!/bin/bash
image_name=webapp
region=us-east-1
REMOTE_REPOSITORY=$(aws ecr describe-repositories | jq -r '.repositories[0].repositoryUri')
aws_account_id=$(aws ecr describe-repositories | jq -r '.repositories[0].registryId')

num=`docker images | sort -r | awk '{print $2}' |head -1`
tag=$(echo $num + 1 | bc -l)
sudo docker build -t $image_name:$tag .
sudo aws ecr get-login-password --$region | docker login --username AWS --password-stdin $aws_account_id.dkr.ecr.$region.amazonaws.com
sudo docker tag $image_name:$tag $REMOTE_REPOSITORY:$tag
sudo docker push $REMOTE_REPOSITORY:$tag


#for ((tag=1;tag <5; tag++))
 #do
#echo "$tag"
#docker build -t webapp:$tag .
#docker tag webapp:$tag 145682747025.dkr.ecr.us-east-1.amazonaws.com/dockerstore:$tag
#aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 145682747025.dkr.ecr.us-east-1.amazonaws.com
#docker push 145682747025.dkr.ecr.us-east-1.amazonaws.com/dockerstore:$tag
#done

