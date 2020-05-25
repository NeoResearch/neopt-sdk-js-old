FROM ubuntu:20.04

LABEL maintainer="NeoResearch"
ENV DEBIAN_FRONTEND noninteractive

# =====================================================================
# Nodejs packages & npm
RUN apt-get update \
    && apt-get install -y python3-pip cmake build-essential openjdk-8-jre-headless git nodejs
# =====================================================================

RUN git clone https://github.com/emscripten-core/emsdk.git

WORKDIR emsdk

RUN ./emsdk install latest

RUN ./emsdk activate latest

RUN /bin/bash -c "source ./emsdk_env.sh"
