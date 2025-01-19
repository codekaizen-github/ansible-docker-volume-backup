FROM alpine:3 AS base

ARG OWNER=codekaizen-github
ARG REPO=ansible-docker-deploy

LABEL org.opencontainers.image.source=https://github.com/${OWNER}/${REPO}

ENV ANSIBLE_CONFIG=/workspace/ansible/ansible.cfg

RUN apk add --update --no-cache \
    ansible \
    bash \
    openssh \
    sshpass

COPY . /workspace

RUN ansible-galaxy install -r /workspace/ansible/requirements.yml

ENTRYPOINT ["/usr/bin/env", "bash", "/workspace/entrypoint.sh"]

FROM base AS dev

RUN apk add --update --no-cache \
    git

ENTRYPOINT []
CMD ["/bin/bash"]
