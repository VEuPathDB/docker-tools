FROM veupathdb/gus-apidb-base:1.2.12

# BioPerl for InsertSequenceFeatures' GFF reader.
RUN apt-get update \
    && apt-get install -y --no-install-recommends libbio-perl-perl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# The base image's GusAppFramework (bca3334) ISF does not compile on perl 5.38.
ARG GUS_COMMIT=1032fbf33754da71ee8657100c6a440f2924a41a \
    CBIL_COMMIT=81061b102a5df29cc2230c4758eeaf8e8922f5a7

RUN cd $PROJECT_HOME \
    && rm -rf GUS CBIL \
    && git clone -q https://github.com/VEuPathDB/GusAppFramework.git GUS \
    && git -C GUS checkout -q $GUS_COMMIT \
    && git clone -q https://github.com/VEuPathDB/CBIL.git \
    && git -C CBIL checkout -q $CBIL_COMMIT \
    && bld CBIL \
    && bld GUS/PluginMgr \
    && bld GUS/Supported \
    && bld GUS/Community

# ApiCommonData/Load as install/build.xml's defaultComponentInstall lays it out,
# without the FgpUtil/TuningManager/DoTS imports that `bld ApiCommonData` needs.
ARG APICOMMONDATA_COMMIT=585237ffed0bfaa2f1c047c813a7f584091dbe5d

RUN cd $PROJECT_HOME \
    && git clone -q https://github.com/VEuPathDB/ApiCommonData.git \
    && git -C ApiCommonData checkout -q $APICOMMONDATA_COMMIT \
    && mkdir -p $GUS_HOME/bin $GUS_HOME/lib/xml $GUS_HOME/lib/perl/ApiCommonData/Load/Plugin \
    && cp -r ApiCommonData/Load/bin/. $GUS_HOME/bin/ \
    && cp -r ApiCommonData/Load/lib/xml/. $GUS_HOME/lib/xml/ \
    && cp -r ApiCommonData/Load/lib/perl/. $GUS_HOME/lib/perl/ApiCommonData/Load/ \
    && cp -r ApiCommonData/Load/plugin/perl/. $GUS_HOME/lib/perl/ApiCommonData/Load/Plugin/ \
    && chmod -R +x $GUS_HOME/bin \
    && echo $APICOMMONDATA_COMMIT > $GUS_HOME/APICOMMONDATA_COMMIT

# GUS::Model must match the target database's schema, so it is generated at run
# time with gus.config mounted (rm -rf $GUS_HOME/lib/perl/GUS/Model && bld GUS/Model)
# and the result committed as a per-database image.

WORKDIR /work
