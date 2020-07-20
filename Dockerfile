FROM alpine
COPY . /app
COPY etc/lighttpd/* /etc/lighttpd/
WORKDIR /app
VOLUME /app/project
RUN \
    apk add --update --no-cache \
	nodejs npm git python3 curl \
	lighttpd lighttpd-mod_auth && \
    rm -rf /var/cache/apk/* && \
    npm i -g npm@latest && \
    npm i -g ionic cordova 
EXPOSE 80 8100 35729
# HEALTHCHECK --interval=2m --timeout=5s --start-period=5m CMD curl -f http://localhost:80/ || exit 1

CMD ["sh", "start.sh"]

