# alpineIonic

``docker pull steelburn/ionic``

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

## Introduction

This is an Ionic docker image built based on Alpine Linux. It strives to be as small as possible. In recent image, I've changed the webserver from built-in HTTP server to Lighttpd.

- Dockerfile Repo: [https://github.com/steelburn/alpineIonic](https://github.com/steelburn/alpineIonic)
- Image repo: [https://hub.docker.com/r/steelburn/ionic](https://hub.docker.com/r/steelburn/ionic)

## Exposed ports
| Port Number | Purpose |
|-------------|---------|
|80 | HTTP port |
| 8100| Ionic HTTP serving port (``SERVE=true``)|
| 35729 | Live reload port (deprecated)|
| 8080 | HTTP serving port with PWA (``PWE=true``)|


## How to use this container image?
Command line:
```
sudo docker run -ti -p <yourport>:80 -v /yourprojectfolder:/app/project steelburn/ionic
```

Of course, replace ```/yourproject``` with the actual directory of your project.

## Environment variables
This container take environment variable, *GITREPO*, which should contain URL to git repository of the project. *GITBRANCH* variable can be used to indicate specific branch to be used. Otherwise, we'll use the main git branch.
The script will automatically clone & run ``npm install`` and ``ionic build`` of the cloned project.

By default, once built, the code will be served by *lighttpd*. However, in certain cases, you may want to let it use built-in ``ng serve``. This is achievable by passing ``SERVE`` variable to ``true``.

You can also pass ``PWA`` variable, set to ``true``. Use this if your application requires PWA registration and lighttpd or ``ng serve`` doesn't work. 

 
Enable experimental SSL mode by passing an additional ``SSL`` variable, set to ``true``. By passing ``SSL=true``, you can also pass ``KEYPATH`` variable pointing to private key file; and ``CERTPATH`` variable, pointing to certificate file.

### What the container will run?
There is a ``build.sh`` script, which will do the following:
- switch to /app/project directory
- run a ``git pull`` on regular interval (every 3 minutes)
- if there's any new update from git repo, it'll run ``npm i`` and ``ionic build``.

There's also a ``start.sh`` script, which is the mastermind to run ``build.sh`` and start Lighttpd HTTP server.

### Script Flow
- start.sh
    - build.sh
# About
This docker image is maintained by [@steelburn](https://github.com/steelburn) ( steelburn[a]gmail[dot]com )
