# alpineIonic

This is an Ionic docker image built based on Alpine Linux. It strives to be as small as possible. In recent image, I've changed the webserver from built-in HTTP server to Lighttpd.

- Dockerfile Repo: [https://github.com/steelburn/alpineIonic](https://github.com/steelburn/alpineIonic)
- Image repo: [https://hub.docker.com/r/steelburn/ionic](https://hub.docker.com/r/steelburn/ionic)

## Exposed ports
| Port Number | Purpose |
|-------------|---------|
|80 | HTTP port |
| 8100| Ionic HTTP serving port (deprecated)|
| 35729 | Live reload port (deprecated)|

## How to use this container image?
Command line:
```
sudo docker run -ti -p <yourport>:80 -v /yourprojectfolder:/app/project steelburn/ionic
```

Of course, replace ```/yourproject``` with the actual directory of your project.

### What the container will run?
There is a ``build.sh`` script, which will do the following:
- switch to /app/project directory
- run a ``git pull`` on regular interval (every 3 minutes)
- if there's any new update from git repo, it'll run ``npm i`` and ``ionic build``.

There's also a ``start.sh`` script, which is the mastermind to run ``build.sh`` and start Lighttpd HTTP server.

# About
This docker image is maintained by [@steelburn](https://github.com/steelburn) ( steelburn[a]gmail[dot]com )
