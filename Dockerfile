FROM python:3.7-alpine

WORKDIR /github/workspace

RUN apk add --update --no-cache python py-pip && \
    apk add --update --no-cache --virtual build_dependencies gcc musl-dev libffi-dev openssl-dev && \
    pip install ansible && \
    apk del build_dependencies

CMD cd ${GITHUB_REPOSITORY} ; ansible-galaxy role import --api-key GALAXY_API_KEY
