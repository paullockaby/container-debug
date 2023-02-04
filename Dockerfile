FROM amazon/aws-cli:latest@sha256:8ae1328b124c859de164c0f51866a0e72e56e19495cf25b4b026d728fb860e6b AS awscli
FROM debian:bullseye@sha256:92277f7108c432febe41beffd367dbb6dac60b9fbfe517c77208e6457eafe22b AS base

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
