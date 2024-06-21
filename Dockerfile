FROM alpine:edge
ARG TARGETPLATFORM
LABEL MAINTAINER="i@nn.ci"
VOLUME /opt/alist/data/
WORKDIR /opt/alist/
COPY /build/${TARGETPLATFORM}/alist ./
COPY entrypoint.sh /entrypoint.sh
RUN apk update && \
    apk upgrade --no-cache && \
    apk add --no-cache bash ca-certificates su-exec tzdata; \
    chmod +x /entrypoint.sh && \
    rm -rf /var/cache/apk/* && \
    /entrypoint.sh version
ENV PUID=0 PGID=0 UMASK=022
EXPOSE 5244 5245
CMD [ "/entrypoint.sh" ]
