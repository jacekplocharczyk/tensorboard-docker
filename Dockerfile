FROM python:3.6-alpine

LABEL maintainer=jacek.plocharczyk@protonmail.com

COPY requirements.txt /

RUN apk update \
    && apk --no-cache add lapack libstdc++ git \
    && apk --no-cache add --virtual .builddeps g++ gcc gfortran musl-dev lapack-dev \
    && pip3 install --upgrade pip \
    && pip install -r /requirements.txt \
    && apk del .builddeps g++ gcc gfortran musl-dev lapack-dev\
    && rm -rf /root/.cache /var/cache/apk/*

RUN mkdir /runs

EXPOSE 6006

ENTRYPOINT tensorboard --host 0.0.0.0 --logdir /runs