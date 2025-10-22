FROM ubuntu:bionic
# NOTE: we need old versions of gtk and glib

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update --fix-missing && apt-get install -y \
    wget \
    build-essential \
    libgtk2.0-dev

RUN wget https://github.com/wxWidgets/wxWidgets/releases/download/v2.8.4/wxWidgets-2.8.4.tar.gz && \
    tar xzvf wxWidgets-2.8.4.tar.gz && cd wxWidgets-2.8.4 && \
    mkdir gtk-build && cd gtk-build && \
    export CFLAGS=-std=c99 CXXFLAGS=-std=c++98 && \ 
    ../configure --prefix=$HOME/wxWidget && \
    make -j$(nproc) && make install # failing on make due to glib incompatibility
    #ldconfig && cd / && rm -rf /tmp/build from GPT, may need modification

RUN cd $HOME

# install RMAExpress
# will need to get wxwdigets to compile first
#RUN wget https://rmaexpress.bmbolstad.com/download/RMAExpress_1.0.5_src.tar.gz && \
#    tar xzvf RMAExpress_1.0.5_src.tar.gz && cd RMAExpress_1.0.5_src && \
#    cp Makefile.unx Makefile && make all

# will probably need to add to PATH etc once compiled
