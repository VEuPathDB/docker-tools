FROM staphb/samtools:1.22.1


# This image has samtools, bedtools and deeptools;  All for processing sam/bam files; 

# # Install dependencies
RUN apt-get update && apt-get install -y build-essential wget unzip default-jre tabix procps libxml-simple-perl libjson-perl libtie-ixhash-perl liblzma-dev libcurl4-gnutls-dev zlib1g-dev libbz2-dev python3 python-setuptools python3-pip python3-venv git bedtools bzip2 libncurses5-dev && apt-get clean && apt-get purge && rm -rf /var/lib/apt/lists/* /tmp/*

# download software
# WORKDIR /usr/local/
# RUN git clone https://github.com/DaehwanKimLab/hisat2.git

# # unpack
# WORKDIR /usr/local/hisat2

# RUN make

# RUN ln -s /usr/local/hisat2/hisat2* /usr/local/bin/
# COPY ./bin/* /usr/local/bin/
# COPY ./lib/perl/* /usr/local/lib/site_perl/

RUN pip3 install deeptools

RUN wget http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/bedGraphToBigWig
RUN chmod +x bedGraphToBigWig
RUN mv bedGraphToBigWig /usr/local/

WORKDIR /work

