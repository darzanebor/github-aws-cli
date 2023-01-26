FROM alphaceti/default-python:0.2.0
RUN pip3 --no-cache-dir install awscli
ENTRYPOINT ["aws"]
