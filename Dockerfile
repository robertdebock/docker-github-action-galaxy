FROM python:3.7-alpine

WORKDIR /github/workspace

RUN apk add --update --no-cache python py-pip && \
    apk add --update --no-cache --virtual build_dependencies gcc musl-dev libffi-dev openssl-dev && \
    pip install ansible && \
    apk del build_dependencies

CMD ansible-galaxy role import --api-key ${galaxy_api_key} $(echo $GITHUB_REPOSITORY | cut -d/ -f1) $(echo $GITHUB_REPOSITORY | cut -d/ -f2)
