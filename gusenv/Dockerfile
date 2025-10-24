FROM rocker/r-ver:4.5.1

ENV DEBIAN_FRONTEND=noninteractive

ARG GITHUB_USERNAME \
    GITHUB_TOKEN

RUN apt-get update && apt-get install -y git build-essential ant wget unzip perl unzip maven libjson-perl libtie-ixhash-perl zlib1g-dev && apt-get clean && apt-get purge && rm -rf /var/lib/apt/lists/* /tmp/*


WORKDIR /gusApp
WORKDIR /gusApp/gus_home
WORKDIR /gusApp/project_home

ENV GUS_HOME=/gusApp/gus_home
ENV PROJECT_HOME=/gusApp/project_home
ENV PATH=$PROJECT_HOME/install/bin:$PATH
ENV PATH=$GUS_HOME/bin:$PATH

RUN export INSTALL_GIT_COMMIT_SHA=279760cf46dbfa327b573d75483f677f8963387a \
    && git clone https://github.com/VEuPathDB/install.git \
    && cd install \
    && git checkout $INSTALL_GIT_COMMIT_SHA

RUN mkdir -p $GUS_HOME/config && cp $PROJECT_HOME/install/config/gus.config.sample $GUS_HOME/config/gus.config

RUN export GUS_GIT_COMMIT_SHA=cf9a99dba00bea3875f9eb5128294ed4a7a25377 \
    && git clone https://github.com/VEuPathDB/GusAppFramework.git \
    && mv GusAppFramework GUS \
    && cd GUS \
    && git checkout $GUS_GIT_COMMIT_SHA \
    && bld GUS/Supported \
    && bld GUS/Community

RUN export CBIL_GIT_COMMIT_SHA=9c580cab4f7664e435d04ab44d82c019bd432829 \
    && git clone https://github.com/VEuPathDB/CBIL.git \
    && cd CBIL \
    && git checkout $CBIL_GIT_COMMIT_SHA \
    && bld CBIL



RUN rm -rf /gusApp/gus_home/lib/perl/CBIL/StudyAssayResults
RUN rm -rf /gusApp/gus_home/lib/perl/CBIL/TranscriptExpression

# RUN export FGP_GIT_COMMIT_SHA=e5fbefafc4aa368b71236e8d0db8c9880c1b6e2f \
#     && git clone https://github.com/VEuPathDB/FgpUtil.git \
#     && cd FgpUtil \
#     && git checkout $FGP_GIT_COMMIT_SHA \
#     && bld FgpUtil

# RUN export TM_GIT_COMMIT_SHA=4e66af9a7fd877d39c79886d06d80e7a9b5bbbec \
#     && git clone https://github.com/VEuPathDB/TuningManager.git \
#     && cd TuningManager \
#     && git checkout $TM_GIT_COMMIT_SHA \
#     && bld TuningManager

# RUN export DOTS_GIT_COMMIT_SHA=82776f13e4b9d827a05e59038b1a03c2de9e0caa \
#     && git clone https://github.com/VEuPathDB/DoTS.git \
#     && cd DoTS \
#     && git checkout $DOTS_GIT_COMMIT_SHA
# #&& bld DoTS

# RUN export APICOMMONDATA_GIT_COMMIT_SHA=d1036d6d33972f0265c88d1cd7602d018b54e540 \
#     && git clone https://github.com/VEuPathDB/ApiCommonData.git \
#     && cd ApiCommonData \
#     && git checkout $APICOMMONDATA_GIT_COMMIT_SHA \
#     && bld ApiCommonData/Load

# install MetaCycle R package
RUN R -e "install.packages('MetaCycle', dependencies=TRUE, repos='http://cran.rstudio.com/')"

# install marray and affy from BioConductor
RUN R -e "install.packages('BiocManager', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "requireNamespace('BiocManager'); BiocManager::install('marray', ask=FALSE)"
RUN R -e "requireNamespace('BiocManager'); BiocManager::install('affy', ask=FALSE)"

WORKDIR /work
