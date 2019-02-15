FROM python:2.7.15-alpine3.7

RUN  apk add --update supervisor \
        \
        && mkdir -p /etc/supervisor/conf.d/ \
        \
        && mkdir -p /var/log/supervisor/ \
        \
        && apk add --no-cache bash \
        \
        && apk add --no-cache tzdata \
        \
        && cp /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime \
        \
        && echo "Asia/Ho_Chi_Minh" > /etc/timezone
RUN apk add --no-cache build-base linux-headers pcre-dev \
    libjpeg zlib tiff-dev freetype-dev make openssl-dev py2-pip \
    libffi-dev gettext gcc libpq netcat-openbsd libxml2-dev zlib-dev \
    libxslt-dev ca-certificates musl-dev python-dev \
    libre2-dev xz-dev g++ \
    && pip --no-cache-dir install --upgrade pip setuptools \
    && rm  -rf /tmp/* /var/cache/apk/*
ADD supervisord.conf /etc/
ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
