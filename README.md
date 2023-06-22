   * Spark binary distribution
      * [Spark Kubernetes Dockerfile](spark-3.1.2-bin-custom-spark/kubernetes/dockerfiles/spark/Dockerfile)
      * [Spark Kubernetes Python Dockerfile](spark-3.1.2-bin-custom-spark/kubernetes/dockerfiles/spark/bindings/python/Dockerfile)
      * [Spark Kubernetes R Dockerfile](spark-3.1.2-bin-custom-spark/kubernetes/dockerfiles/spark/bindings/R/Dockerfile)

# Spark operator
   * https://github.com/GoogleCloudPlatform/spark-on-k8s-operator/tree/spark-operator-chart-1.1.6

```shell
helm repo add spark-operator https://googlecloudplatform.github.io/spark-on-k8s-operator
```

```shell
helm install my-release spark-operator/spark-operator --namespace spark-operator --create-namespace
```
# Issues
## com.amazonaws.SdkClientException: Unable to execute HTTP request: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target: Unable to execute HTTP request: PKIX path building failed
   * https://github.com/aws/aws-sdk-java/issues/2087: AmazonRDSClient.java: Unable to execute HTTP request: sun.security.validator.ValidatorException: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target
   * https://community.cloudera.com/t5/Community-Articles/How-to-configure-your-spark-application-to-use-Mongo-DB-with/ta-p/247296
   
## AttributeError: 'Namespace' object has no attribute 'no_user'
   * https://stackoverflow.com/questions/76000757/mamba-init-error-attributeerror-namespace-object-has-no-attribute-no-user
   * https://kirenz.github.io/codelabs/codelabs/miniforge-setup/#0

## java.lang.NoSuchMethodError: 'void io.netty.util.concurrent.SingleThreadEventExecutor.<init>(io.netty.util.concurrent.EventExecutorGroup
   * https://spark.apache.org/docs/3.2.4/
      * "For Python 3.9, Arrow optimization and pandas UDFs might not work due to the supported Python versions in Apache Arrow." 

## How to fix org.apache.spark.sql.internal.SQLConf$.PARQUET_FIELD_ID_READ_ENABLED() when running Spark with Delta Lake?
   * https://stackoverflow.com/questions/75260486/how-to-fix-org-apache-spark-sql-internal-sqlconf-parquet-field-id-read-enabled
   * https://docs.delta.io/latest/releases.html
   * https://libraries.io/maven/io.delta:delta-core_2.12
   * https://mvnrepository.com/artifact/io.delta/delta-core_2.12/2.0.2
# See also
   * [HIVE](docs/Hive.md)
   * [Jupyter](docs/Jupyter.md)

# References
   * [(MEDIUM) Build Your Own Big Data Ecosystem — Part 1](https://medium.com/geekculture/build-your-own-big-data-ecosystem-part-1-a19e4c778632)
   * [Learn How to Mount a Local Drive in a Pod in Minikube ](https://dev.to/coherentlogic/learn-how-to-mount-a-local-drive-in-a-pod-in-minikube-2020-3j48)
   * https://spark.apache.org/docs/latest/running-on-kubernetes.html#submitting-applications-to-kubernetes
   * https://doc.lucidworks.com/spark-guide/11031/running-spark-on-kubernetes
   * https://www.youtube.com/watch?v=8oo6WEgsOvg&list=WL&index=46&t=3904s: Novos Recursos do Delta Lake 1.0 com Apache Spark
      * https://bitbucket.org/luanmoreno/live/src/master/pyspark-yelp-elt-py/
   * https://towardsdatascience.com/jupyter-notebook-spark-on-kubernetes-880af7e06351: Jupyter Notebook & Spark on Kubernetes
     * https://github.com/itayB 
     * AWS S3
     * Localstack
     * Jupyter
      