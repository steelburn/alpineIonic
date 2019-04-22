FROM alpine
COPY . /app
WORKDIR /app
VOLUME /app/project
RUN \
    apk add nodejs npm git curl && \
    npm i -g npm@latest && \
    npm i -g ionic cordova 
EXPOSE 8100 35729
HEALTHCHECK --interval=2m --timeout=5s --start-period=5m \
  CMD curl -f http://localhost:8100/ || exit 1

CMD ["sh", "run.sh"]

