pushd .
cd spark-3.1.2-bin-custom-spark
TAG=11-jre-slim
./bin/docker-image-tool.sh -t 1.0 -p kubernetes/dockerfiles/spark/bindings/python/Dockerfile -b java_image_tag=$TAG build
popd
