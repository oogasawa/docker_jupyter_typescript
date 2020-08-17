# Copyright (c) Osamu Ogasawara
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=jupyter/datascience-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Osamu Ogasawara <osamu.ogasawara@gmail.com>"

#USER root
USER $NB_UID
WORKDIR $HOME


ENV PATH="$HOME/bin":"$PATH"
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash \
	&& export NVM_DIR="$HOME/.nvm" \
	&& [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \ 
	&& [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" \
	&& nvm install --lts --latest-npm \
    && nvm alias default lts/* \
    && nvm install stable \
	&& npm config set prefix $HOME \
	&& npm install -g zebras vega-lite \
	&& npm install -g typescript @types/node ts-node \
	&& npm install -g typedoc jsdoc \
	&& npm install -g yarn \
	&& npm install -g webpack webpack-cli ts-loader \
	&& npm install -g tslab \
	&& tslab install \
	&& jupyter kernelspec list


RUN pip3 install bash_kernel \
	&& python3 -m bash_kernel.install	    

WORKDIR $HOME


