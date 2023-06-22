#
# https://github.com/jupyter/docker-stacks/blob/main/scipy-notebook/Dockerfile
#
ARG REPO
ARG TAG
ARG VERSION

FROM ${REPO}spark-base-python-${VERSION}:$TAG

RUN apt-get update && \
    apt-get install -y graphviz pkg-config  \
             # nbconvert dependencies
             # https://nbconvert.readthedocs.io/en/latest/install.html#installing-tex
             texlive-xetex texlive-fonts-recommended  texlive-plain-generic \
             # Enable clipboard on Linux host systems
             xclip  \
             # for cython: https://cython.readthedocs.io/en/latest/src/quickstart/install.html
             build-essential \
             # for latex labels
             cm-super \
             dvipng \
             # for matplotlib anim
             ffmpeg && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get autoclean && \
    apt-get clean

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
#RUN pip install \
#        PyYAML==6.0 \
#        notebook==6.5.4 \
#        ipynb==0.5.1 \
#        jupyter_server==2.5.0 \
#        jupyterlab==3.6.3 \
#        sparkmonitor==2.1.1 && \
#        jupyter nbextension install sparkmonitor --py --user --symlink && \
#        jupyter nbextension enable  sparkmonitor --py && \
#        echo "c.InteractiveShellApp.extensions.append('sparkmonitor.kernelextension')" >> \
#               $(ipython profile locate default)/ipython_kernel_config.py
COPY env_python_3_jupyter.yml /env_python_3_jupyter.yml

RUN  mamba env update -f /env_python_3_jupyter.yml --prune && \
     # Cleanup
     find /opt/conda/ -follow -type f -name '*.a' -delete && \
     find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
     mamba clean -ay

COPY start.sh /
RUN chmod u+x /start.sh

CMD ["/start.sh"]