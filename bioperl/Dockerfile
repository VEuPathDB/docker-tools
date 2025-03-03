FROM bioperl/bioperl:stable

RUN apt-get update && apt-get install -y wget build-essential libbz2-dev zlib1g-dev libncurses5-dev libncursesw5-dev liblzma-dev git

WORKDIR /app

RUN wget https://cpan.metacpan.org/authors/id/L/LD/LDS/Bio-SamTools-1.43.tar.gz
RUN tar -xvzf Bio-SamTools-1.43.tar.gz
RUN cd Bio-SamTools-1.43 && perl INSTALL.pl YES

RUN cpanm Bio::Coordinate::GeneMapper
