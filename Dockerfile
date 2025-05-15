FROM debian:bookworm-slim

# Create the directory in which the scripts will be stored
RUN mkdir -p /opt/Nextcloud/log

# Update, upgrade and install some packages
RUN apt update \
    && apt -y upgrade \
    && apt install -yq --no-install-recommends \
    moreutils \
    && apt clean \
    && apt -y autoremove \
    && rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/* \
    /usr/share/doc \
    /usr/share/man \
    /usr/share/locale \
    /usr/share/info \
    /usr/share/lintian

# Install the Nextcloud repository
RUN apt update \
    && apt install -yq --no-install-recommends \
    openssl \
    ca-certificates \
    nextcloud-desktop-cmd \
    && apt upgrade -y \
    && apt-get clean \
    && apt -y autoremove \
    && rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/* \
    /usr/share/doc \
    /usr/share/man \
    /usr/share/locale \
    /usr/share/info \
    /usr/share/lintian

COPY *.sh /opt/Nextcloud/
WORKDIR /nextclouddata

ENTRYPOINT ["/bin/bash","/opt/Nextcloud/docker-entrypoint.sh"]
CMD ["/bin/bash", "/opt/Nextcloud/run.sh"]

ENV OC_USER=oc_username \
    OC_PASS=oc_passwordORtoken \
    OC_SERVER=yourserver.com \
    OC_PROTO=https \
    OC_URLPATH=/ \
    OC_WEBDAV=remote.php/webdav \
    OC_FILEPATH=/ \
    TRUST_SELFSIGN=0 \
    SYNC_HIDDEN=0 \
    SILENCE_OUTPUT=1 \
    RUN_INTERVAL=30 \
    RUN_UID=99 \
    RUN_GID=100
