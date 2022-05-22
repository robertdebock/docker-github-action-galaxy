FROM python:3.9-alpine

LABEL maintainer="Robert de Bock <robert@meinit.nl>"
LABEL build_date="2022-05-22"

WORKDIR /github/workspace

RUN apk add --update --no-cache --virtual build_dependencies gcc musl-dev libffi-dev openssl-dev rust cargo && \
    pip install --no-cache-dir ansible-core && \
    rm -rf /root/.cache /root/.cargo && \
    apk del build_dependencies

CMD cd ${path:-./} ; ansible-galaxy role import --api-key ${galaxy_api_key} --branch ${git_branch} $(echo $GITHUB_REPOSITORY | cut -d/ -f1) $(echo $GITHUB_REPOSITORY | cut -d/ -f2)

# vim: set filetype=dockerfile:
