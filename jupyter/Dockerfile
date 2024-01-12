#
# https://github.com/jupyter/docker-stacks/blob/main/scipy-notebook/Dockerfile
#
ARG REPO
ARG TAG
ARG VERSION

FROM ${REPO}spark-base-python-${VERSION}:$TAG

# Almond Scala version: 3.3.0, 2.13
ARG SCALA_VERSION="3.3.0"
ARG ALMOND_VERSION="0.14.0-RC14"

RUN apt-get update && \
    apt-get install -y \
             # jupyterlab-git server extension
             git \
             graphviz pkg-config \
             # nbconvert dependencies
             # https://nbconvert.readthedocs.io/en/latest/install.html#installing-tex
             texlive-xetex texlive-fonts-recommended  texlive-plain-generic \
             # Enable clipboard on Linux host systems
             xclip  \
             # for cython: https://cython.readthedocs.io/en/latest/src/quickstart/install.html
             build-essential \
             # for latex labels
             cm-super \
             dvipng && \
             # for matplotlib anim \
             #ffmpeg && \
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

COPY env_python_3_jupyter.yml /env_python_3_jupyter.yml

RUN  mamba env update -f /env_python_3_jupyter.yml --prune && \
     # Cleanup
     find /opt/conda/ -follow -type f -name '*.a' -delete && \
     find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
     mamba clean -ay

RUN cd /usr/local/bin && curl -Lo coursier https://git.io/coursier-cli && chmod +x ./coursier && \
    coursier launch --fork almond:${ALMOND_VERSION} --scala ${SCALA_VERSION} -- --install

COPY start.sh /
RUN chmod u+x /start.sh

CMD ["/start.sh"]