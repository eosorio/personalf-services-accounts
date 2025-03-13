#!/bin/bash

# Run this script from the upper directory (personalf-services-accounts/build.sh)

# Image will be tagged as devel. I need a pipeline to promote it to stable
container_image_name=eosorio/personalf-services-accounts
version_today=$(date "+%Y%m%d")

# Produced image should be dev and after testing promoted as stable (removing the dev tag)
docker build -t $container_image_name:${version_today}-dev -f personalf-services-accounts/Dockerfile .

# Tagging image as latest
docker tag $container_image_name:${version_today}-dev $container_image_name:latest