FROM ghcr.io/linuxserver/baseimage-ubuntu:jammy

# environment settings
ENV HOME="/config"
ENV DEBIAN_FRONTEND="noninteractive"
ENV DUPLICACY_WEB_VERSION=Stable

RUN \
  sed -i 's/archive.ubuntu.com/mirrors.xtom.com/g' /etc/apt/sources.list \
  && apt-get update \
  && apt-get install -y ca-certificates dbus tzdata jq curl wget \
  && rm -f /var/lib/dbus/machine-id && ln -s /config/machine-id /var/lib/dbus/machine-id \
  && rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

# copy local files
COPY /root /

# ports and volumes
EXPOSE 3875/tcp
VOLUME /config /logs /cache
