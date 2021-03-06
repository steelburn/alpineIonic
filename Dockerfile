FROM alpine
COPY . /app
COPY etc/lighttpd/* /etc/lighttpd/
WORKDIR /app
VOLUME /app/project
RUN \
    apk add --update --no-cache \
	nodejs npm git python3 python2 curl make \
	lighttpd lighttpd-mod_auth && \
    rm -rf /var/cache/apk/* && \
    npm i -g npm@latest && \
    npm uninstall -g ionic && \
    npm i -g cordova @ionic/cli && \
    npm i -g http-server
EXPOSE 80 8100 35729 8080
# HEALTHCHECK --interval=2m --timeout=5s --start-period=5m CMD curl -f http://localhost:80/ || exit 1

CMD ["sh", "start.sh"]

