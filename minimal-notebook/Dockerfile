FROM redhat/ubi8-minimal


LABEL name="odh-notebook-jupyter-minimal-ubi8-python-3.8" \
    summary="Minimal Jupyter notebook image for ODH notebooks" \
    description="Minimal Jupyter notebook image with base Python 3.8 builder image based on UBI8 for ODH notebooks" \
    io.k8s.display-name="Minimal Jupyter notebook image for ODH notebooks" \
    io.k8s.description="Minimal Jupyter notebook image with base Python 3.8 builder image based on UBI8 for ODH notebooks" \
    authoritative-source-url="https://github.com/opendatahub-io/notebooks" \
    io.openshift.build.commit.ref="main" \
    io.openshift.build.source-location="https://github.com/opendatahub-io/notebooks/tree/main/jupyter/minimal/ubi8-python-3.8" \
    io.openshift.build.image="quay.io/opendatahub/notebooks:jupyter-minimal-ubi8-python-3.8"

WORKDIR /opt/app-root/bin

COPY utils utils/
COPY requirements.txt start-notebook.sh ./




# ENV NODEJS_VERSION=18
# COPY utils/install-npm.sh install-npm.sh



RUN  microdnf update 

RUN microdnf install scl-utils

# install python essentials
RUN microdnf --nodocs -y  install python3-pip python3-wheel python3-setuptools

RUN python3 -m pip install --upgrade pip

# install npm via https://github.com/stolostron/common-nodejs-parent
# RUN echo -e "[nodejs]\nname=nodejs\nstream=${NODEJS_VERSION}\nprofiles=\nstate=enabled\n" > /etc/dnf/modules.d/nodejs.module
# RUN microdnf install nodejs && microdnf remove nodejs-full-i18n npm nodejs-docs
# RUN ./install-npm.sh

RUN microdnf  --nodocs -y install curl

RUN microdnf clean all

WORKDIR /jupyter/s2i

COPY .s2i/bin .

WORKDIR /jupyter/builder

COPY builder .

WORKDIR /jupyter/config

COPY config .

WORKDIR /jupyter/gateway

COPY gateway .

WORKDIR /jupyter/scripts

COPY scripts .

WORKDIR /jupyter/supervisor

COPY supervisor .

# RUN /bin/bash 

RUN chown -R 1001 /jupyter
RUN chgrp -R 0 /jupyter
RUN chmod -R g+w /jupyter

USER 1001

LABEL io.k8s.description="S2I builder for custom Jupyter notebooks." \
      io.k8s.display-name="Jupyter Notebook" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,jupyter" \
      io.openshift.s2i.scripts-url="image:///opt/app-root/builder"


RUN /tmp/s2i/assemble

CMD [ "/opt/app-root/builder/run" ]
# 