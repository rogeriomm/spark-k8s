ARG REPO
ARG TAG
ARG SPARK_VERSION

FROM ${REPO}spark-base-python-${SPARK_VERSION}:$TAG

RUN apt-get install -y \
    graphviz \
    pkg-config

# Install RUST compiler: https://www.rust-lang.org/tools/install
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > /tmp/install-rustup.sh && \
    sh /tmp/install-rustup.sh -y
# source "$HOME/.cargo/env"

# https://crates.io/crates/evcxr_jupyter
RUN source "$HOME/.cargo/env" &&  \
    cargo install evcxr_jupyter && \
    evcxr_jupyter --install \
    rustup component add rust-src \
    cargo install polars


ENV PYTHONPATH=/opt/spark/python/lib/pyspark.zip:/opt/spark/python/lib/py4j-0.10.9.5-src.zip:$PYTHONPATH
# https://towardsdatascience.com/jupyter-notebook-spark-on-kubernetes-880af7e06351
RUN pip install \
        PyYAML==6.0 \
        notebook==6.5.2 \
        ipynb==0.5.1 \
        sparkmonitor==2.1.1 \
        jupyter_server==2.0.6

# install extension to monitor spark: https://pypi.org/project/sparkmonitor/
RUN jupyter nbextension install sparkmonitor --py --user --symlink
RUN jupyter nbextension enable  sparkmonitor --py
#### RUN jupyter serverextension enable --py --user --debug sparkmonitor FIXME
RUN ipython profile create && \
            echo "c.InteractiveShellApp.extensions.append('sparkmonitor.kernelextension')" >> \
               $(ipython profile locate default)/ipython_kernel_config.py

RUN ln -s /opt/conda/envs/python_3_with_R/lib/python3.8/site-packages/sparkmonitor/listener_2.12.jar /opt/spark/jars/listener_2.12.jar

COPY start.sh /
RUN chmod u+x /start.sh

CMD ["/start.sh"]