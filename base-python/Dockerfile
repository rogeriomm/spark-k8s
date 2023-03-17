ARG REPO
ARG TAG
ARG SPARK_VERSION

FROM ${REPO}spark-base-${SPARK_VERSION}:$TAG

RUN apt-get update && \
    apt-get install -y ipython3 && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get autoclean && \
    apt-get clean

########################################################################################################################
# Install conda to manage python and R packages
# FIXME Conda version. See https://github.com/apache/zeppelin/blob/master/scripts/docker/zeppelin/bin/Dockerfile
ARG miniconda_version="py39_4.12.0"
# Hashes via https://docs.conda.io/en/latest/miniconda_hashes.html
ARG miniconda_sha256="78f39f9bae971ec1ae7969f0516017f2413f17796670f7040725dd83fcff5689"
# Install python and R packages via conda
COPY env_python_3_with_R.yml /env_python_3_with_R.yml
RUN set -ex && \
    wget -nv https://repo.anaconda.com/miniconda/Miniconda3-${miniconda_version}-Linux-x86_64.sh -O miniconda.sh && \
    echo "${miniconda_sha256} miniconda.sh" > anaconda.sha256 && \
    sha256sum --strict -c anaconda.sha256 && \
    bash miniconda.sh -b -p /opt/conda && \
    export PATH=/opt/conda/bin:$PATH && \
    conda update --yes -n base -c defaults conda && \
    conda config --set always_yes yes --set changeps1 no && \
    conda info -a && \
    conda install mamba -c conda-forge

RUN export PATH=/opt/conda/bin:$PATH && \
    mamba env update -f /env_python_3_with_R.yml --prune && \
    # Cleanup
    rm -v miniconda.sh anaconda.sha256  && \
    # Cleanup based on https://github.com/ContinuumIO/docker-images/commit/cac3352bf21a26fa0b97925b578fb24a0fe8c383
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    mamba clean -ay

    # Allow to modify conda packages. This allows malicious code to be injected into other interpreter sessions, therefore it is disabled by default
    # chmod -R ug+rwX /opt/conda

RUN export PATH=/opt/conda/bin:$PATH && \
    mamba init bash && \
    echo mamba activate python_3_with_R >> /root/.bashrc

ENV PATH /opt/conda/envs/python_3_with_R/bin:/opt/conda/bin:$PATH
# Add CONDA self signed certificates

########################################################################################################################
# Some python packages are not available via conda, so we are using pip
COPY pip_packages.txt /pip_packages.txt
RUN set -ex && \
    pip install -q -r /pip_packages.txt
