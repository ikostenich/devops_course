FROM jenkins/jenkins:2.290

ARG HELM_VERSION-3.5.4
ARG DEBIAN_FRONTEND=noninteractive
ARG ANSIBLE_VERSION=2.10.7

# install plugins

RUN /usr/local/bin/install-plugins.sh ssh-slaves \
  mailer \
  greenballs \
  simple-theme-plugin \
  rebuild \
  github \
  mask-passwords \
  kubernetes \
  docker-plugin \
  slack \
  docker-workflow \
  blueocean \
  stashNotifier \
  show-build-parameters \
  credentials \
  configuration-as-code \
  command-launcher \
  external-monitor-job \
  ssh-agent \
  pipeline-stage-view

USER root
RUN apt-get update && apt-get install -y apt-transport-https \
  ca-certificates curl gnupg2 \
  software-properties-common \
  python-pip \
  curl \
  gnupg2
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) stable"
RUN apt-get update && apt-get install -y docker-ce-cli
RUN apt-get update && \
  apt-get install -y gcc python-dev libkrb5-dev && \
  apt-get install python3-pip -y && \
  pip3 install --upgrade pip && \
  pip3 install --upgrade virtualenv && \
  pip3 install pywinrm[kerberos] && \
  apt install krb5-user -y && \ 
  pip3 install pywinrm && \
  pip3 install ansible

USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean:1.24.6 docker-workflow:1.26"