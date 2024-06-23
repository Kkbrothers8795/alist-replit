FROM kirodewal/alist:latest
RUN apk update && \
    apk add --no-cache ffmpeg \
    rm -rf /var/cache/apk/* && \
    /entrypoint.sh version
ENV PUID=0 PGID=0 UMASK=022
EXPOSE 5244 5245
CMD [ "/entrypoint.sh" ]
