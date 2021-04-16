FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y build-essential wget libkrb5-3 libpng12-0 && apt-get clean && apt-get purge && rm -rf /var/lib/apt/lists/* /tmp/*
RUN wget -O bedGraphToBigWig https://github.com/ENCODE-DCC/kentUtils/raw/v302.1.0/bin/linux.x86_64/bedGraphToBigWig
RUN chmod guo+x bedGraphToBigWig
RUN mv bedGraphToBigWig /usr/local/bin/

