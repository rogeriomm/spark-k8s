#!/usr/bin/env bash

#
# -n                    Build docker image with --no-cache
# -m                    Use minikube's Docker daemon.
#

cd dependencies
mvn clean install dependency:copy-dependencies -Dhadoop.version=3.3.1

cd ../../spark

#./dev/make-distribution.sh --name custom-spark --pip \
#    -Phive -Phive-thriftserver -Pkubernetes -Dhadoop.version=3.3.1


cd dist
#14-jre-slim   14.0-jdk-slim-buster
TAG=11.0-jdk-slim-buster
./bin/docker-image-tool.sh "$@" \
                           -t $TAG \
                           -p kubernetes/dockerfiles/spark/bindings/python/Dockerfile \
                           -b java_image_tag=$TAG \
                           build
