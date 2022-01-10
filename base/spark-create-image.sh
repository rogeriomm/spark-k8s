#!/usr/bin/env zsh

#
# -n                    Build docker image with --no-cache
# -m                    Use minikube's Docker daemon.
#

set -x
set -e

HADOOP_VERSION=3.3.1

cd dependencies
mvn clean install dependency:copy-dependencies -Dhadoop.version=$HADOOP_VERSION

cd ../../spark

# shellcheck disable=SC1101
./dev/make-distribution.sh --name custom-spark --pip \
    -Phive -Phive-thriftserver -Pkubernetes -Dhadoop.version=$HADOOP_VERSION

if [ -d ./dist ]; then
  cd dist

  TAG=11.0-jdk-slim-bullseye
  ./bin/docker-image-tool.sh "$@" \
                           -t $TAG \
                           -p kubernetes/dockerfiles/spark/bindings/python/Dockerfile \
                           -b java_image_tag=$TAG \
                           build

fi    
