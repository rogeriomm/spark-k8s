#!/usr/bin/env bash

#
# -n                    Build docker image with --no-cache
# -m                    Use minikube's Docker daemon.
#

pushd .

cd ${SPARK_HOME}
#TAG=14-jre-slim
#TAG=14.0-jdk-slim-buster
TAG=11.0-jdk-slim-buster
./bin/docker-image-tool.sh "$@" \
                           -t $TAG \
                           -p kubernetes/dockerfiles/spark/bindings/python/Dockerfile \
                           -b java_image_tag=$TAG \
                           build

popd
