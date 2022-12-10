FROM python:3.8-slim

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN pip3 install --upgrade pip; \
    pip3 install --upgrade virtualenv; \
    pip3 install cryptography; \
    pip3 install requests; \
    python3 -m pip install ansible;

ENTRYPOINT [ "/bin/bash" ]