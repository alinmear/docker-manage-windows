FROM alpine:3.5

MAINTAINER Paul Steinlechner 

ENV TIMEZONE=Europe/Vienna MANAGEWINDOWS_CRON='0 3 * * *' \
    MANAGEWINDOWS_DOMAIN="DOMAIN.LOC" MANAGEWINDOWS_KDC="kdc.domain.loc"

RUN apk --update add bash supervisor python py-pip openssl ca-certificates krb5 krb5-libs && \
    apk --update add --virtual build-dependencies \
    python-dev libffi-dev openssl-dev build-base \
    krb5-dev && \
    pip install --upgrade pip cffi && \
    pip install ansible==2.2.2 pywinrm[kerberos] && \
    apk del build-dependencies && rm -rf /var/cache/apk/*

RUN ln -snf /usr/share/zoneinfo/Europe/Vienna /etc/localtime && echo $TIMEZONE > /etc/timezone

COPY files/entrypoint.sh /entrypoint.sh
COPY files/supervisord.conf /etc/supervisord.conf

RUN chmod +x /entrypoint.sh

VOLUME ["/opt/manage-windows"]

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/supervisord"]
