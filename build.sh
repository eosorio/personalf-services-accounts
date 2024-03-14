#!/bin/bash

# Image will be tagged as devel. I need a pipeline to promote it to stable

docker_image_name=eosorio/personalf-services-accounts
version_today=$(date "+%Y%m%d")

# Produced image should be dev and after testing promoted as stable (removing the dev tag)
docker build -t $docker_image_name:${version_today}-dev -f personalf-services-accounts/Dockerfile .

# Tagging image as latest
docker tag $docker_image_name:${version_today}-dev $docker_image_name:latest