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

  SPARK_MAJOR_VERSION=$(awk -F '.' '{print $1"."$2}' <<< $SPARK_VERSION)

  TAG=11.0-jdk-slim-bullseye

  unset SPARK_HOME

  pushd .

  cd "dependencies/${SPARK_MAJOR_VERSION}"
  mvn clean install dependency:copy-dependencies -Dhadoop.version=$HADOOP_VERSION

  cd "../../spark-$SPARK_MAJOR_VERSION"
  git checkout "v$SPARK_VERSION"

  # shellcheck disable=SC1101
  ./dev/make-distribution.sh --name custom-spark --pip -DskipTests=true\
      -Phive -Phive-thriftserver -Pkubernetes -Dhadoop.version=$HADOOP_VERSION

  export SPARK_HOME="$(pwd)/dist"

  cp ../dependencies/"$SPARK_MAJOR_VERSION"/target/dependency/*.jar "$SPARK_HOME"/jars

  if [ -d "$SPARK_HOME" ]; then
    cd "$SPARK_HOME"

    ./bin/docker-image-tool.sh -t "$TAG-$SPARK_VERSION" \
                             -p kubernetes/dockerfiles/spark/bindings/python/Dockerfile \
                             -b java_image_tag=$TAG \
                             build
  else
     echo "Failed to make docker image on directory ${SPARK_HOME}"
     exit 1
  fi

  popd
}

check_docker() {
  [[ ! -f $MINIKUBE_HOME/docker-env ]] || source $MINIKUBE_HOME/docker-env

  if ! docker info; then
    echo "Docker isn't working"
    exit 1
  fi
}

export MAVEN_OPTS="-Xmx2g -XX:ReservedCodeCacheSize=2g -Xss4096k"

check_docker

#make_image 3.1.3 3.3.4
make_image 3.2.3 3.2.4
make_image 3.3.1 3.3.4
