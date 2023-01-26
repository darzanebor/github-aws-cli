FROM alphaceti/default-python:0.2.0
RUN apk add --update --no-cache docker-cli && \
    pip3 --no-cache-dir install awscli
