FROM    python:3.6-alpine

# Install apks
RUN     apk add --no-cache shadow tzdata

# Install flexget & plugins
RUN     pip3 install -U pip && pip3 install -U \
        flexget \
        deluge_client \
        subliminal>=2.0

# Volumes
VOLUME  /config
WORKDIR /config

# Add init script
COPY    etc/init.sh /scripts/init.sh
RUN     chmod +x /scripts/init.sh

# App entry point
CMD     ["/scripts/init.sh"]

# Flexget web interface
EXPOSE  5050/tcp