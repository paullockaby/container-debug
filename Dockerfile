FROM debian:bullseye@sha256:859ea45db307402ee024b153c7a63ad4888eb4751921abbef68679fc73c4c739

# github metadata
LABEL org.opencontainers.image.source=https://github.com/plockaby/docker-debug

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -q update && apt-get -y upgrade && \
    apt-get install -y --no-install-recommends time openssl gnutls-bin zip unzip bzip2 lynx vim vim-scripts curl whois telnet sqlite3 strace lsof less traceroute bash-completion socat busybox dnsutils net-tools tcpdump wget iputils-ping fping iproute2 ca-certificates nmap netcat-openbsd postgresql-client && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY /entrypoint /
RUN chmod +x /entrypoint

ENTRYPOINT ["/entrypoint"]
