FROM amazon/aws-cli:latest@sha256:2f465530a677d716db579d3ca85c38bda9f1f75f83e72012096440f540cb0640 AS awscli
FROM debian:bookworm@sha256:d93aa0b2100e5aea695a6584b1d694d1a14ea783ab86dbc33962efdc8c9819c9 AS base

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
