FROM python:3.11

WORKDIR /usr/src/devops

COPY requirements.txt ./
COPY oci_devops ./

RUN pip install --no-cache-dir -r requirements.txt
ENV APPLICATION_TARGET=generic-bu ALIAS_TARGET=generic_bu