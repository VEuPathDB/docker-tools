FROM biocontainers/samtools:v1.9-4-deb_cv1

# set environment variables
ENV hisat2_version 2.1.0
ENV trimmomatic_version 0.39
ENV bedgraph2bigwig_version 369

ENV CLASSPATH /usr/local/Trimmomatic-${trimmomatic_version}/trimmomatic-${trimmomatic_version}.jar

ENV DEBIAN_FRONTEND=noninteractive

USER root

# Install dependencies
RUN apt-get update && apt-get install -y build-essential wget unzip default-jre python3 python tabix && apt-get clean && apt-get purge && rm -rf /var/lib/apt/lists/* /tmp/*

# download software
WORKDIR /usr/local/
RUN wget https://github.com/DaehwanKimLab/hisat2/archive/v${hisat2_version}.tar.gz
RUN wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-${trimmomatic_version}.zip

# unpack
RUN tar -xvzf v${hisat2_version}.tar.gz
RUN unzip Trimmomatic-${trimmomatic_version}.zip

# # install hisat2
WORKDIR /usr/local/hisat2-${hisat2_version}
RUN make
RUN ln -s /usr/local/hisat2-${hisat2_version}/hisat2 /usr/local/bin/hisat2
RUN ln -s /usr/local/hisat2-${hisat2_version}/hisat2-build /usr/local/bin/hisat2-build

# install bedgraph2bigwig
RUN wget -O bedGraphToBigWig http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64.v${bedgraph2bigwig_version}/bedGraphToBigWig
RUN chmod guo+x bedGraphToBigWig
RUN mv bedGraphToBigWig /usr/local/bin/


COPY ./bin/* /usr/local/bin/

USER biodocker


