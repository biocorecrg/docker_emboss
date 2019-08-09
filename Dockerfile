FROM debian:stretch

# File Author / Maintainer
MAINTAINER Luca Cozzuto <lucacozzuto@gmail.com> 

ARG EMBOSS_VERSION=6.6.0
ARG PHYLIP_VERSION=1:3.696+dfsg-5
ARG VIENNA_VERSION=2.4.13

# Install required packages
RUN apt-get update
RUN apt-get install -y build-essential curl autoconf libxaw7-dev libpcre3-dev

#INSTALLING EMBOSS
RUN bash -c 'curl -K -L ftp://emboss.open-bio.org/pub/EMBOSS/EMBOSS-${EMBOSS_VERSION}.tar.gz > emboss.tar.gz'
RUN tar -zxf emboss.tar.gz; \
	rm -f emboss.tar.gz
	
RUN	cd EMBOSS-${EMBOSS_VERSION}; ./configure --disable-shared; 
RUN	cd EMBOSS-${EMBOSS_VERSION}; ldconfig; make
RUN	cd EMBOSS-${EMBOSS_VERSION}; ldconfig; make; make install
	
#INSTALLING PHYLIP
RUN apt-get install phylip=${PHYLIP_VERSION}

#INSTALLING VIENNA
RUN bash -c 'curl -K -L https://www.tbi.univie.ac.at/RNA/download/sourcecode/2_4_x/ViennaRNA-${VIENNA_VERSION}.tar.gz > vienna.tar.gz'
RUN tar -zxf vienna.tar.gz; \
	rm -f vienna.tar.gz

RUN	cd ViennaRNA-${VIENNA_VERSION}; ./configure
RUN	cd ViennaRNA-${VIENNA_VERSION}; make 
RUN	cd ViennaRNA-${VIENNA_VERSION}; make install

