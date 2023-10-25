FROM biocontainers/samtools:v1.9-4-deb_cv1

# set environment variables
ENV hisat2_version 2.1.0
ENV trimmomatic_version 0.39
ENV bedgraph2bigwig_version 369
ENV ngsutils_version 0.5.9
ENV bedtools_version 2.30.0

ENV CLASSPATH /usr/local/Trimmomatic-${trimmomatic_version}/trimmomatic-${trimmomatic_version}.jar

ENV DEBIAN_FRONTEND=noninteractive

USER root

# this was causing an issue with apt update;  doesn't appear that any packages are installed from backports though
RUN rm /etc/apt/sources.list.d/backports.list

# # Install dependencies
 RUN apt-get update && apt-get install -y build-essential wget unzip default-jre python3 python tabix procps liblzma-dev libcurl4-gnutls-dev zlib1g-dev libbz2-dev python-dev && apt-get clean && apt-get purge && rm -rf /var/lib/apt/lists/* /tmp/*

# download software
WORKDIR /usr/local/
RUN wget https://github.com/DaehwanKimLab/hisat2/archive/v${hisat2_version}.tar.gz
RUN wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-${trimmomatic_version}.zip
RUN wget https://github.com/ngsutils/ngsutils/archive/refs/tags/ngsutils-${ngsutils_version}.tar.gz
RUN wget https://github.com/arq5x/bedtools2/releases/download/v${bedtools_version}/bedtools-${bedtools_version}.tar.gz

# unpack
RUN tar -xvzf v${hisat2_version}.tar.gz
RUN unzip Trimmomatic-${trimmomatic_version}.zip
RUN tar -xvzf ngsutils-${ngsutils_version}.tar.gz
RUN tar -zxvf bedtools-${bedtools_version}.tar.gz

# # install hisat2
WORKDIR /usr/local/hisat2-${hisat2_version}
RUN make
RUN ln -s /usr/local/hisat2-${hisat2_version}/hisat2 /usr/local/bin/hisat2
RUN ln -s /usr/local/hisat2-${hisat2_version}/hisat2-build /usr/local/bin/hisat2-build

# install ngsutils
WORKDIR /usr/local/ngsutils-ngsutils-${ngsutils_version}
RUN sed -i 's/coverage>=3.5.3/coverage>=3.5.3,<6.0/g' requirements.txt
RUN make
RUN ln -s /usr/local/ngsutils-ngsutils-${ngsutils_version}/bin/bamutils /usr/local/bin/bamutils

# install bedtools
WORKDIR /usr/local/bedtools2
RUN make
RUN ln -s /usr/local/bedtools2/bin/bedtools /usr/local/bin/bedtools


# install bedgraph2bigwig
RUN wget -O bedGraphToBigWig http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64.v${bedgraph2bigwig_version}/bedGraphToBigWig
RUN chmod guo+x bedGraphToBigWig
RUN mv bedGraphToBigWig /usr/local/bin/

COPY ./bin/* /usr/local/bin/
COPY ./lib/perl/* /usr/local/lib/site_perl/

USER biodocker
