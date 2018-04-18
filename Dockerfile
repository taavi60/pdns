FROM alpine:3.7

# Add community repo and install packages
RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/v3.7/community" >> /etc/apk/repositories && \
    echo "@main http://dl-cdn.alpinelinux.org/alpine/v3.7/main" >> /etc/apk/repositories && \
    apk add -U --no-cache \
    pdns@community pdns-backend-mysql@community pdns-backend-bind@community pdns-backend-pipe@community\
    && apk add gcc python2-dev musl-dev py2-pip py2-netaddr && pip install IPy py-radix PyYAML \
    && apk del gcc
#    rm -rf /var/cache/apk/* 

# Give ownership of default config file to recursor:recursor
# This enables runtime zone/script reloading with rec_control

# Make sure the include-dir always exists

# Make /data a volume
VOLUME /data

# Run pdns_recursor
CMD [ "/usr/sbin/pdns_server", "--disable-syslog=yes", "--daemon=no", "--local-address=0.0.0.0" ]

