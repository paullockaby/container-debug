FROM debian:bullseye-slim@sha256:e3ed4be20c22a1358020358331d177aa2860632f25b21681d79204ace20455a6

# github metadata
LABEL org.opencontainers.image.source=https://github.com/plockaby/docker-debug

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -q update && apt-get -y upgrade && \
    apt-get install -y --no-install-recommends sudo time openssl gnutls-bin zip unzip bzip2 lynx vim vim-scripts curl whois telnet sqlite3 strace lsof less traceroute bash-completion socat busybox dnsutils net-tools tcpdump wget iputils-ping fping iproute2 ca-certificates nmap netcat-openbsd && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY /entrypoint /
RUN chmod +x /entrypoint

ENTRYPOINT ["/entrypoint"]
