ARG REPO
ARG TAG
ARG SPARK_VERSION

FROM ${REPO}spark-base-python-${SPARK_VERSION}:$TAG

# https://towardsdatascience.com/jupyter-notebook-spark-on-kubernetes-880af7e06351
RUN pip install \
    notebook==6.2.0 \
    ipynb==0.5.1 \
    sparkmonitor==1.1.1 \
    pyspark==3.1.2

# install extension to monitor spark
RUN jupyter nbextension install sparkmonitor --py --user --symlink
RUN jupyter nbextension enable  sparkmonitor --py
RUN jupyter serverextension enable --py --user --debug sparkmonitor
RUN ipython profile create && \
            echo "c.InteractiveShellApp.extensions.append('sparkmonitor.kernelextension')" >> \
               $(ipython profile locate default)/ipython_kernel_config.py

RUN ln -s /usr/local/lib/python3.8/site-packages/sparkmonitor/listener_2.12.jar /opt/spark/jars/listener_2.12.jar

#CMD jupyter notebook --port=8888 --ip=0.0.0.0 --no-browser --allow-root \
#     --NotebookApp.token='' --notebook-dir=/lab/jupyter/notbook