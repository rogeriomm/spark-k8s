Prj([
     Docker(name="base",        version="3.1.2", prefix="spark", parm={"SPARK_VERSION": "3.1.2"}),
     Docker(name="base-python", version="3.1.2", prefix="spark", parm={"SPARK_VERSION": "3.1.2"}),
     Docker(name="jupyter",     version="3.1.2", prefix="spark", parm={"SPARK_VERSION": "3.1.2"}),

     Docker(name="base",        version="3.2.0", prefix="spark", parm={"SPARK_VERSION": "3.2.0"}),
     Docker(name="base-python", version="3.2.0", prefix="spark", parm={"SPARK_VERSION": "3.2.0"}),
     Docker(name="jupyter",     version="3.2.0", prefix="spark", parm={"SPARK_VERSION": "3.2.0"})
     ],
     "docker-spark")
