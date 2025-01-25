FROM alpine:3 AS base

ARG LABEL_ORG_OPENCONTAINERS_IMAGE_SOURCE=""

LABEL org.opencontainers.image.source=${LABEL_ORG_OPENCONTAINERS_IMAGE_SOURCE}

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
