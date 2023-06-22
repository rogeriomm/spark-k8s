#!/usr/bin/env zsh

#
# -n                    Build docker image with --no-cache
# -m                    Use minikube's Docker daemon.
#

set -x
set -e

make_image() {
  SPARK_VERSION=$1
  HADOOP_VERSION=$2
  TAG=$3

  SPARK_MAJOR_VERSION=$(awk -F '.' '{print $1"."$2}' <<< "$SPARK_VERSION")

  pushd .

  cd "spark-$SPARK_MAJOR_VERSION"
  git checkout "v$SPARK_VERSION"

  ./dev/make-distribution.sh --name custom-spark --pip -DskipTests=true -Dio.netty.tryReflectionSetAccessible=true \
      -Phive -Phive-thriftserver -Pkubernetes -Dhadoop.version="$HADOOP_VERSION"

  export SPARK_HOME="$(pwd)/dist"

  if [ -d "$SPARK_HOME" ]; then
    cd "$SPARK_HOME"

    ./bin/docker-image-tool.sh -t "$TAG-$SPARK_VERSION" \
                             -p kubernetes/dockerfiles/spark/bindings/python/Dockerfile \
                             -b java_image_tag="$TAG" \
                             build
  else
     echo "Failed to make docker image on directory ${SPARK_HOME}"
     exit 1
  fi

  popd
}

check_docker() {
  #[[ ! -f "$MINIKUBE_HOME"/docker-env ]] || source "$MINIKUBE_HOME"/docker-env

  if ! docker info; then
    echo "Docker isn't working"
    exit 1
  fi
}

check_java() {
  java_version=$(java -version 2>&1 | grep -i version | cut -d'"' -f2 | cut -d'.' -f1-2)
  if [ "$java_version" != "11" ]; then
    exit 2
  fi
}

export MAVEN_OPTS="-Xss64m -Xmx2g -XX:ReservedCodeCacheSize=2g"

check_java

check_docker

make_image 3.2.4 3.2.4 11.0.16-jdk-slim-bullseye
#make_image 3.3.2 3.3.5 11.0.16-jdk-slim-bullseye
#make_image 3.4.0 3.3.5 11.0.16-jdk-slim-bullseye
#
#
#
