FROM ubuntu:14.04
MAINTAINER Grant Heffernan <grant@mapzen.com>

ENV TERM                vt100
ENV INSTALL_FROM        "ppa"
ENV PPA_VERSION         ""

# runtime options
ENV GENERATE_TEST_DATA  ${GENERATE_TEST_DATA:-false}
ENV TEST_DATA_URL       ${TEST_DATA_URL:-https://s3.amazonaws.com/metro-extracts.mapzen.com}
ENV TEST_DATA_EXTRACTS  ${TEST_DATA_EXTRACTS:-rome_italy.osm.pbf}

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install wget jq supervisor -y

ADD ./scripts /scripts
RUN /scripts/install.sh

ADD ./conf /conf

RUN apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 8002
CMD ["/scripts/start_valhalla.sh"]
