FROM registry.access.redhat.com/ubi9/ubi-minimal:9.4

RUN mkdir /models
COPY models/ /models/

USER 1001
