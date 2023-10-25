FROM ubuntu:jammy

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update --fix-missing && apt-get install -y \
    wget \
    curl \
    libtime-hires-perl

WORKDIR /usr/local/

COPY ./install-edirect.sh /usr/local/

RUN /usr/local/install-edirect.sh

ENV PATH="/usr/local/edirect:${PATH}"
