ARG REPO
ARG TAG
ARG VERSION

FROM ${REPO}spark-base-${VERSION}:${TAG}

RUN apt-get update && \
    apt-get install -y libarchive13 pandoc && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get autoclean && \
    apt-get clean

ARG miniforge_version="23.1.0-1"
ARG miniforge_sha256="cba9a744454039944480871ed30d89e4e51a944a579b461dd9af60ea96560886"

# Install python and R packages via conda
COPY env_python_3_with_R.yml /env_python_3_with_R.yml

#     sha256sum --strict -c miniforge.sha256 && \
RUN set -ex && \
    wget -nv https://github.com/conda-forge/miniforge/releases/download/${miniforge_version}/Mambaforge-${miniforge_version}-Linux-x86_64.sh -O miniforge.sh && \
    echo "${miniforge_sha256} miniforge.sh" > miniforge.sha256 && \
    bash miniforge.sh -b -p /opt/conda && \
    export PATH=/opt/conda/bin:$PATH && \
    conda update --yes -n base -c defaults conda && \
    conda config --set always_yes yes --set changeps1 no && \
    conda info -a && \
    conda install mamba -c conda-forge

RUN set -ex && \
    export PATH=/opt/conda/bin:$PATH && \
    mamba env update -f /env_python_3_with_R.yml --prune && \
    # Cleanup
    rm -v miniforge.sh miniforge.sha256  && \
    \
    mamba init bash && \
    echo mamba activate python_3_with_R >> /root/.bashrc && \
    \
    # Cleanup
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    mamba clean -ay

ENV PATH="/opt/conda/envs/python_3_with_R/bin:/opt/conda:bin:/opt/conda/condabin:$PATH"

# Some python packages are not available via conda, so we are using pip
COPY pip_packages.txt /pip_packages.txt
RUN set -ex && \
    pip install -q -r /pip_packages.txt
