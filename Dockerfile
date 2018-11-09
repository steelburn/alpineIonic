FROM alpine
COPY . /app
WORKDIR /app
RUN \
    apk add nodejs npm git && \
    npm i -g npm@latest && \
    npm i -g ionic cordova 
