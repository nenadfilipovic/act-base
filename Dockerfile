## Select base image.
FROM python:buster

## Add node, npm.
RUN \
    echo "deb https://deb.nodesource.com/node_12.x buster main" > /etc/apt/sources.list.d/nodesource.list && \
    wget -qO- https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
    wget -qO- https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    apt-get update && \
    apt-get install -yqq nodejs yarn && \
    pip install -U pip && pip install pipenv && \
    npm i -g npm@^6

## Install docker.
RUN apt-get install  -yqq \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common && \
    wget -qO- https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt update -yqq && \
    apt-get install -yqq docker-ce docker-ce-cli containerd.io

## Install docker-compose.
RUN curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose
