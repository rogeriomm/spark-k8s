#!/usr/bin/env bash

# https://spark.apache.org/docs/latest/hadoop-provided.html
export SPARK_DIST_CLASSPATH=$("${HADOOP_HOME}"/bin/hadoop classpath)
