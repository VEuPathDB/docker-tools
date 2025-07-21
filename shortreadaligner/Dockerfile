FROM biocontainers/samtools:v1.9-4-deb_cv1

ENV DEBIAN_FRONTEND=noninteractive

USER root

# this was causing an issue with apt update;  doesn't appear that any packages are installed from backports though
RUN rm /etc/apt/sources.list.d/backports.list

# debian buster repos are no longer available in the default repo URL so update URLs to point to archive.debian.org instead
RUN sed -i -E 's/(security|deb)\.debian.org/archive\.debian.org/g' /etc/apt/sources.list

# # Install dependencies
 RUN apt-get update && apt-get install -y build-essential wget unzip default-jre python3 python tabix procps liblzma-dev libcurl4-gnutls-dev zlib1g-dev libbz2-dev python-dev  git && apt-get clean && apt-get purge && rm -rf /var/lib/apt/lists/* /tmp/*

# download software
WORKDIR /usr/local/
RUN git clone https://github.com/DaehwanKimLab/hisat2.git

# unpack
WORKDIR /usr/local/hisat2

RUN make

RUN ln -s /usr/local/hisat2/hisat2* /usr/local/bin/
COPY ./bin/* /usr/local/bin/
COPY ./lib/perl/* /usr/local/lib/site_perl/

WORKDIR /work
