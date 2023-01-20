Prj([
#     Docker(name="base",        version="3.1.3", prefix="spark", parm={"SPARK_VERSION": "3.1.3"}),
#     Docker(name="base-python", version="3.1.3", prefix="spark", parm={"SPARK_VERSION": "3.1.3"}),
#     Docker(name="jupyter",     version="3.1.3", prefix="spark", parm={"SPARK_VERSION": "3.1.3"}),

     Docker(name="base",        version="3.2.3", prefix="spark", parm={"SPARK_VERSION": "3.2.3"}),
     Docker(name="base-python", version="3.2.3", prefix="spark", parm={"SPARK_VERSION": "3.2.3"}),
     Docker(name="jupyter",     version="3.2.3", prefix="spark", parm={"SPARK_VERSION": "3.2.3"})
     ],
     "docker-spark")
