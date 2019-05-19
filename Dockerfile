FROM    python:3.6-alpine

# Environment Vars
ENV     PUID 1000
ENV     PGID 1000
ENV     TZ Australia/Melbourne

# Update timezone
RUN     apk add --no-cache tzdata
RUN     ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime \
        && echo ${TZ} > /etc/timezone

# Create a user
RUN     adduser -D -u ${PUID} -g ${PGID} flexget
WORKDIR /home/flexget/

# Volumes
VOLUME  /config

# Install flexget & plugins
RUN     pip3 install -U pip && pip3 install -U \
        flexget \
        deluge_client \
        subliminal>=2.0
   
# Add init script
COPY    etc/init.sh /home/flexget/
RUN     chmod +x ./init.sh

USER    flexget
CMD     ["./init.sh"]

# Flexget web interface
EXPOSE  5050/tcp