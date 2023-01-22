FROM python:alpine3.17

LABEL maintainer="Robert de Bock <robert@meinit.nl>"
LABEL build_date="2023-01-22"

WORKDIR /github/workspace

ADD requirements.txt /requirements.txt
RUN python3 -m pip install -r /requirements.txt && \
    python3 -m pip cache purge

RUN apk add --update --no-cache --virtual build_dependencies gcc musl-dev libffi-dev openssl-dev rust cargo && \
    rm -rf /root/.cache /root/.cargo && \
    apk del build_dependencies

CMD set -euxo pipefail ; cd ${path:-./} ; ansible-galaxy role import --api-key ${galaxy_api_key} --branch ${git_branch} $(echo $GITHUB_REPOSITORY | cut -d/ -f1) $(echo $GITHUB_REPOSITORY | cut -d/ -f2)
