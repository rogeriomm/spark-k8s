FROM spark-py:11.0-jdk-slim-buster

ENV HADOOP_VERSION=3.3.1
ENV HADOOP_HOME /opt/hadoop-${HADOOP_VERSION}
ENV HADOOP_URL https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz

ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    TZ=America/Sao_Paulo

USER root

RUN bash -c 'echo "LC_ALL=en_US.UTF-8" >> /etc/environment' ; \
    bash -c 'echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen' ; \
    bash -c 'echo "LANG=en_US.UTF-8" > /etc/locale.conf'

RUN apt-get install -y locales

RUN locale-gen en_US.UTF-8

RUN apt-get install -y \
      net-tools \
      curl \
      netcat \
      gnupg \
      wget \
      vim \
      links \
      unzip \
      ack \
      iptraf \
      tcpdump \
      htop \
      inetutils-ping

# Delta, Iceberg, AWS S3
COPY dependencies/target/dependency/*.jar $SPARK_HOME/jars/

# Install HADOOP
RUN curl -O https://dist.apache.org/repos/dist/release/hadoop/common/KEYS
RUN gpg --import KEYS

COPY hadoop-$HADOOP_VERSION.tar.gz /tmp/hadoop.tar.gz
COPY hadoop-$HADOOP_VERSION.tar.gz.asc /tmp/hadoop.tar.gz.asc

#RUN set -x \
#    && curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
#    && curl -fSL "$HADOOP_URL.asc" -o /tmp/hadoop.tar.gz.asc \

RUN set -x \
    gpg --verify /tmp/hadoop.tar.gz.asc \
    && tar -xf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz*

RUN mkdir $SPARK_HOME/conf

COPY spark-env.sh $SPARK_HOME/conf

# Overwrite TLS key store with our updates
COPY certs/cacerts $JAVA_HOME/lib/security/cacerts

# Add self signed certificates
COPY certs/*.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates

# Install aws client cli
WORKDIR /tmp
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip -q awscliv2.zip
RUN ./aws/install
ENV PATH $PATH:/opt/aws/dist
RUN mkdir -p /root/.aws
COPY aws/config /root/.aws/
COPY aws/credentials /root/.aws/
WORKDIR /root