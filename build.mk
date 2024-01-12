Prj([
     Docker(name="base",        version="3.2", prefix="spark", parm={"SPARK_VERSION": "3.2.4", "HADOOP_VERSION": "3.2.4", "JDK_TAG": "11.0.16-jdk-slim-bullseye"}),
     Docker(name="base-python", version="3.2", prefix="spark", parm={"SPARK_VERSION": "3.2.4", "HADOOP_VERSION": "3.2.4"}),
     Docker(name="jupyter",     version="3.2", prefix="spark", parm={"SPARK_VERSION": "3.2.4", "HADOOP_VERSION": "3.2.4"}),

     Docker(name="base",        version="3.3", prefix="spark", parm={"SPARK_VERSION": "3.3.4", "HADOOP_VERSION": "3.3.6", "JDK_TAG": "11.0.16-jdk-slim-bullseye"}),
     Docker(name="base-python", version="3.3", prefix="spark", parm={"SPARK_VERSION": "3.3.4", "HADOOP_VERSION": "3.3.6"}),
     Docker(name="jupyter",     version="3.3", prefix="spark", parm={"SPARK_VERSION": "3.3.4", "HADOOP_VERSION": "3.3.6"}),

     Docker(name="base",        version="3.4", prefix="spark", parm={"SPARK_VERSION": "3.4.2", "HADOOP_VERSION": "3.3.6", "JDK_TAG": "11.0.21_9-jdk-jammy"}),
     Docker(name="base-python", version="3.4", prefix="spark", parm={"SPARK_VERSION": "3.4.2", "HADOOP_VERSION": "3.3.6"}),
     Docker(name="jupyter",     version="3.4", prefix="spark", parm={"SPARK_VERSION": "3.4.2", "HADOOP_VERSION": "3.3.6"}),

     Docker(name="base",        version="3.5", prefix="spark", parm={"SPARK_VERSION": "3.5.0", "HADOOP_VERSION": "3.3.6", "JDK_TAG": "11.0.21_9-jdk-jammy"}),
     Docker(name="base-python", version="3.5", prefix="spark", parm={"SPARK_VERSION": "3.5.0", "HADOOP_VERSION": "3.3.6"}),
     Docker(name="jupyter",     version="3.5", prefix="spark", parm={"SPARK_VERSION": "3.5.0", "HADOOP_VERSION": "3.3.6"})
     ],
     "docker-spark")
