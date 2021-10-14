FROM spark-py:1.0

ENV HADOOP_VERSION=3.3.1
ENV HADOOP_HOME /opt/hadoop-${HADOOP_VERSION}
ENV HADOOP_URL https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz

ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    TZ=America/Sao_Paulo

USER root

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
      locales \
      iptraf \
      tcpdump \
      htop \
      bind9-dnsutils \
      inetutils-ping

RUN bash -c 'echo "LC_ALL=en_US.UTF-8" >> /etc/environment' ; \
    bash -c 'echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen' ; \
    bash -c 'echo "LANG=en_US.UTF-8" > /etc/locale.conf'

RUN locale-gen en_US.UTF-8

### Install HADOOP
RUN curl -O https://dist.apache.org/repos/dist/release/hadoop/common/KEYS
RUN gpg --import KEYS

COPY hadoop-$HADOOP_VERSION.tar.gz /tmp/hadoop.tar.gz
COPY hadoop-$HADOOP_VERSION.tar.gz.asc /tmp/hadoop.tar.gz.asc

#RUN set -x \
#    && curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
#    && curl -fSL "$HADOOP_URL.asc" -o /tmp/hadoop.tar.gz.asc \

RUN set -x \
    gpg --verify /tmp/hadoop.tar.gz.asc \
    && tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz*

### Download JAVA packages
RUN cd /opt/spark ; \
    echo "System.exit(0)" > /tmp/exit.scala ; \
    ./bin/spark-shell  --packages org.apache.hadoop:hadoop-aws:$HADOOP_VERSION,org.apache.hadoop:hadoop-client:$HADOOP_VERSION,org.apache.hadoop:hadoop-common:$HADOOP_VERSION,io.delta:delta-core_2.12:1.0.0,org.apache.iceberg:iceberg-spark3-runtime:0.12.0 \
                      -i /tmp/exit.scala

