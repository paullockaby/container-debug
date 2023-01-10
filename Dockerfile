FROM amazon/aws-cli:latest@sha256:b795e1ec8607f51fdf5a745ac976559f723a527f51a2c98c7d3ada547ab4def2 AS awscli
FROM debian:bullseye@sha256:c66c0e5dc607baefefda1d9e64a3b3a317e4189c540c8eac0c1a06186fe353a1 AS base

# github metadata
LABEL org.opencontainers.image.source=https://github.com/plockaby/docker-debug

# install common tools
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -q update && apt-get -y upgrade && \
    apt-get install -y --no-install-recommends time openssl gnutls-bin zip unzip bzip2 lynx vim vim-scripts curl whois telnet sqlite3 strace lsof less traceroute bash-completion socat busybox dnsutils net-tools tcpdump wget iputils-ping fping iproute2 ca-certificates nmap netcat-openbsd postgresql-client groff procps git git-lfs && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# copy the aws cli over
COPY --from=awscli /usr/local/aws-cli /usr/local/aws-cli
RUN ln -s /usr/local/aws-cli/v2/current/bin/aws /usr/local/bin/aws && \
    ln -s /usr/local/aws-cli/v2/current/bin/aws_completer /usr/local/bin/aws_completer


COPY /entrypoint /
RUN chmod +x /entrypoint

ENTRYPOINT ["/entrypoint"]
