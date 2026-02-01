FROM amazon/aws-cli:latest@sha256:9ba9ec979264e85bde370e704e5d2fdc40109edd1e7c3251d4f6823071204405 AS awscli
FROM debian:trixie@sha256:8f6a88feef3ed01a300dafb87f208977f39dccda1fd120e878129463f7fa3b8f AS base

# github metadata
LABEL org.opencontainers.image.source=https://github.com/paullockaby/container-debug

# install common tools
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -q update && apt-get -y upgrade && \
    apt-get install -y --no-install-recommends time openssl gnutls-bin zip unzip bzip2 lynx vim vim-scripts curl whois telnet sqlite3 strace lsof less traceroute bash-completion socat busybox dnsutils net-tools tcpdump wget iputils-ping fping iproute2 ca-certificates nmap netcat-openbsd groff procps git git-lfs gnupg2 jq yq && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc -o /tmp/ACCC4CF8.asc && \
    gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg /tmp/ACCC4CF8.asc && \
    rm -f /tmp/ACCC4CF8.asc && \
    sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt trixie-pgdg main" > /etc/apt/sources.list.d/pgdg.list' && \
    apt-get -q update && apt-get -y upgrade && \
    apt-get install -y --no-install-recommends postgresql-18 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# copy the aws cli over
COPY --from=awscli /usr/local/aws-cli /usr/local/aws-cli
RUN ln -s /usr/local/aws-cli/v2/current/bin/aws /usr/local/bin/aws && \
    ln -s /usr/local/aws-cli/v2/current/bin/aws_completer /usr/local/bin/aws_completer

COPY /entrypoint /
RUN chmod +x /entrypoint

ENTRYPOINT ["/entrypoint"]
