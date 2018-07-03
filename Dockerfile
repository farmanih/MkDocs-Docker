FROM alpine:latest
MAINTAINER Hussein Farmani <husseinfarmani@gmail.com>

ENV MKDOCS_VERSION="0.17.2" \
    GIT_REPO='false' 

RUN apk add --update \
    ca-certificates bash vim nano python2 py-pip python2-dev py-setuptools && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*


COPY ./requirements.txt /
RUN pip install --upgrade pip && \
    pip install mkdocs==${MKDOCS_VERSION} && \
    pip install -r requirements.txt && rm -rf $HOME/.cache/pip

COPY ./bootstrap.sh /
RUN chmod +x bootstrap.sh

WORKDIR /mkdocs

EXPOSE 80
ENTRYPOINT ["/bootstrap.sh"]
