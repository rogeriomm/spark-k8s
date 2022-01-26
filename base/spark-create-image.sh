#!/usr/bin/env zsh

#
# -n                    Build docker image with --no-cache
# -m                    Use minikube's Docker daemon.
#

set -x
set -e

HADOOP_VERSION=3.3.1
SPARK_VERSION=3.1.2
SPARK_MAJOR_VERSION=$(awk -F '.' '{print $1"."$2}' <<< $SPARK_VERSION)
DELTA_VERSION=1.0.0

TAG=11.0-jdk-slim-bullseye

unset SPARK_HOME

cd dependencies
mvn clean install dependency:copy-dependencies -Dhadoop.version=$HADOOP_VERSION -Ddelta.version=${DELTA_VERSION}

cd "../spark-$SPARK_MAJOR_VERSION"
git checkout "v$SPARK_VERSION"

# shellcheck disable=SC1101
#./dev/make-distribution.sh --name custom-spark --pip -DskipTests=true\
#    -Phive -Phive-thriftserver -Pkubernetes -Dhadoop.version=$HADOOP_VERSION

export SPARK_HOME="$(pwd)/dist"

if [ -d "$SPARK_HOME" ]; then
  cd "$SPARK_HOME"

  ./bin/docker-image-tool.sh "$@" \
                           -t "$TAG-$SPARK_VERSION" \
                           -p kubernetes/dockerfiles/spark/bindings/python/Dockerfile \
                           -b java_image_tag=$TAG \
                           build

fi    
