FROM postgres:latest

WORKDIR /usr/bin/

RUN apt-get -qq update --fix-missing \
  && apt-get install -y wget perl libgomp1 git ant build-essential unzip default-jre python3 cpanminus bioperl libaio1 emacs libjson-perl libmodule-install-rdf-perl libxml-parser-perl libdate-manip-perl libtext-csv-perl libstatistics-descriptive-perl libtree-dagnode-perl libxml-simple-perl maven default-jdk libdbd-pg-perl sudo && apt-get clean \
  && apt-get purge && rm -rf /var/lib/apt/lists/* /tmp/*

WORKDIR /gusApp
WORKDIR /gusApp/gus_home
WORKDIR /gusApp/project_home

ENV GUS_HOME=/gusApp/gus_home
ENV PROJECT_HOME=/gusApp/project_home
ENV PATH=$PROJECT_HOME/install/bin:$PATH
ENV PATH=$GUS_HOME/bin:$PATH
ENV PATH=$GUS_HOME:$PATH
ENV PATH=$PROJECT_HOME:$PATH
ENV GITHUB_USERNAME=rdemko2332
ENV GITHUB_TOKEN=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

RUN export INSTALL_GIT_COMMIT_SHA=2cc3a8d2749b94f846fc2e72d42a9e05f50866d1 \
    && git clone https://github.com/VEuPathDB/install.git \
    && cd install \
    && git checkout $INSTALL_GIT_COMMIT_SHA

RUN mkdir -p $GUS_HOME/config && cp $PROJECT_HOME/install/config/gus.config.sample $GUS_HOME/config/gus.config

RUN export GUS_GIT_COMMIT_SHA=28a02f0f67b8bf0ded2759692cf7e63bde2c13e3 \
    && git clone https://github.com/VEuPathDB/GusAppFramework.git \
    && mv GusAppFramework GUS \
    && cd GUS \
    && git checkout $GUS_GIT_COMMIT_SHA 

RUN export APICOMMONDATA_GIT_COMMIT_SHA=postgres-migration \
    && git clone https://github.com/VEuPathDB/ApiCommonData.git \
    && cd ApiCommonData \
    && git checkout $APICOMMONDATA_GIT_COMMIT_SHA
    
RUN export FGPUTIL_GIT_COMMIT_SHA=postgres-migration \
    && git clone https://github.com/VEuPathDB/FgpUtil.git \
    && cd FgpUtil \
    && git checkout $FGPUTIL_GIT_COMMIT_SHA

RUN export TUNING_MANAGER_GIT_COMMIT_SHA=920c4d5d83045316d2c5224052891e2392bd21ee \
    && git clone https://github.com/VEuPathDB/TuningManager.git \
    && cd TuningManager \
    && git checkout $TUNING_MANAGER_GIT_COMMIT_SHA

RUN export DoTS_GIT_COMMIT_SHA=82776f13e4b9d827a05e59038b1a03c2de9e0caa \
    && git clone https://github.com/VEuPathDB/DoTS.git \
    && cd DoTS \
    && git checkout $DoTS_GIT_COMMIT_SHA

RUN export CBIL_GIT_COMMIT_SHA=de0d042c8645ae96863ff2f0ddff90f314e3fc26 \
    && git clone https://github.com/VEuPathDB/CBIL.git \
    && cd CBIL \
    && git checkout $CBIL_GIT_COMMIT_SHA

RUN export GUS_SCHEMA_GIT_COMMIT_SHA=55d59828ad483b2fe9883b2fe6a522061258934c \
    && git clone https://github.com/VEuPathDB/GusSchema.git \
    && cd GusSchema \
    && git checkout $GUS_SCHEMA_GIT_COMMIT_SHA 

RUN bld FgpUtil
RUN bld ApiCommonData/Load
RUN touch $PROJECT_HOME/GUS/Model/lib/perl/generated
RUN bld GUS

COPY bin/gus.config /gusApp/gus_home/config/gus.config
COPY bin/*.jar $GUS_HOME/lib/java/db_driver/

WORKDIR /gusApp

RUN chown -R postgres **/**/**/**/**/**/**/**/**/**/**/*
RUN chown -R postgres **/**/**/**/**/**/**/**/**/**/*
RUN chown -R postgres **/**/**/**/**/**/**/**/**/*
RUN chown -R postgres **/**/**/**/**/**/**/**/*
RUN chown -R postgres **/**/**/**/**/**/**/*
RUN chown -R postgres **/**/**/**/**/**/*
RUN chown -R postgres **/**/**/**/**/*
RUN chown -R postgres **/**/**/**/*
RUN chown -R postgres **/**/**/*
RUN chown -R postgres **/**/*
RUN chown -R postgres **/*
RUN chown -R postgres *

COPY bin/*.sh /docker-entrypoint-initdb.d
RUN cd /docker-entrypoint-initdb.d \
    && chmod +x *.sh

WORKDIR /work