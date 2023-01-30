#!/bin/bash

for ((tag=1;tag <20; tag++))
 do
  echo "$tag"
sudo docker build -t dockerstore .
done

sudo docker images
if [ $# -eq 0 ]
  then
    tag='latest'
  else
    tag=$1
sudo docker build -t webapp:$tag .
fi

docker tag dockerstore:$tag 145682747025.dkr.ecr.us-east-1.amazonaws.com/dockerstore:$tag
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 145682747025.dkr.ecr.us-east-1.amazonaws.com
docker push 145682747025.dkr.ecr.us-east-1.amazonaws.com/dockerstore:$tag


#docker tag $imageID aws_account_id.dkr.ecr.region.amazonaws.com/my-repository:$tag
#docker push aws_account_id.dkr.ecr.region.amazonaws.com/my-repository:$tag
REPOSITORY=[[[[[ecr_registrory_name]]]]]
IMAGE=$REPOSITORY:latest
AWS_REGION=[[[[[your_region]]]]]

# docker login
aws ecr get-login --region $AWS_REGION

# docker build
docker build -t $IMAGE .

# push先のレポジトリ
REMOTE_REPOSITORY=`aws ecr describe-repositories | jq -r '.repositories | map(select(.repositoryName == $REPOSITORY))[0] | .repositoryUri'`

# docker tag. なんかタグ付けてる
docker tag $IMAGE $REMOTE_REPOSITORY

# docker push
docker push $REMOTE_REPOSITORY

# find old image
OLD_IMAGE_DIGESTS=`aws ecr --region $AWS_REGION list-images --repository-name $REPOSITORY --filter tagStatus=UNTAGGED | jq '.imageIds | map({imageDigest: .imageDigest})'`

# deleet old images if they exist
if [ ! "$OLD_IMAGE_DIGESTS" = '[]' ]; then
  aws ecr --region $AWS_REGION batch-delete-image --repository-name $REPOSITORY --image-ids "$OLD_IMAGE_DIGESTS"
fi