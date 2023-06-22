ARG SPARK_VERSION
ARG HADOOP_VERSION
ARG JDK_TAG

FROM spark-py:${JDK_TAG}-${SPARK_VERSION}

ARG VERSION
ARG HADOOP_VERSION
ARG SPARK_VERSION

ARG NB_USER="star"
ARG NB_UID="1000"
ARG NB_GID="100"

ENV HADOOP_HOME /opt/hadoop-${HADOOP_VERSION}
ENV HADOOP_URL https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
ENV PATH="$SPARK_HOME/bin:$HADOOP_HOME/bin:$PATH"

ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    TZ=America/Sao_Paulo

USER root

RUN bash -c 'echo "LC_ALL=en_US.UTF-8" >> /etc/environment' ; \
    bash -c 'echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen' ; \
    bash -c 'echo "LANG=en_US.UTF-8" > /etc/locale.conf' && \
    \
    apt-get update && apt-get install --yes --no-install-recommends \
       curl wget sudo net-tools netcat gnupg vim unzip ack iptraf tcpdump htop inetutils-ping locales tini && \
    \
    # Install Mongodb client
    wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | apt-key add - && \
    echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/6.0 main" | tee /etc/apt/sources.list.d/mongodb-org-6.0.list && \
    curl -sSL https://www.mongodb.org/static/pgp/server-6.0.asc  -o mongoserver.asc && \
    gpg --no-default-keyring --keyring ./mongo_key_temp.gpg --import ./mongoserver.asc && \
    gpg --no-default-keyring --keyring ./mongo_key_temp.gpg --export > ./mongoserver_key.gpg && \
    mv mongoserver_key.gpg /etc/apt/trusted.gpg.d/ && \
    rm ./mongoserver.asc && \
    apt-get update && apt-get install -y mongodb-org-shell mongodb-org && \
    apt-get remove -y mongodb-org-server mongodb-org-mongos && \
    \
    # Cleanup
    rm -rf /var/lib/apt/lists/* && \
    apt-get autoclean && \
    apt-get clean && \
    \
    locale-gen en_US.UTF-8

# Install HADOOP
RUN curl -O https://dist.apache.org/repos/dist/release/hadoop/common/KEYS && gpg --import KEYS

COPY hadoop-$HADOOP_VERSION.tar.gz /tmp/hadoop.tar.gz
COPY hadoop-$HADOOP_VERSION.tar.gz.asc /tmp/hadoop.tar.gz.asc

#RUN set -x \
#    && curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
#    && curl -fSL "$HADOOP_URL.asc" -o /tmp/hadoop.tar.gz.asc \

RUN set -x \
    gpg --verify /tmp/hadoop.tar.gz.asc \
    && tar -xf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz* && \
    \
    mkdir $SPARK_HOME/conf

COPY files/ /

# Add self signed certificates
COPY certificates/ca.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates &&     rm /usr/local/share/ca-certificates/*

COPY conf/spark-env.sh "$SPARK_HOME/conf"
COPY conf/spark-defaults-${SPARK_VERSION}.conf "$SPARK_HOME/conf/spark-defaults.conf"
COPY exit.scala /
RUN "${SPARK_HOME}"/bin/spark-shell --repositories https://repo1.maven.org/maven2 -I /exit.scala

# Set AWS cli TLS CA certificates with the self signed certificates
ENV AWS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
