# alpineIonic

This is an Ionic docker image built based on Alpine Linux. It strives to be as small as possible.

Dockerfile Repo: [https://github.com/steelburn/alpineIonic](https://github.com/steelburn/alpineIonic)
Image repo: [https://hub.docker.com/r/steelburn/ionic](https://hub.docker.com/r/steelburn/ionic)

## Exposed ports
| Port Number | Purpose |
|-------------|---------|
| 8100| Ionic HTTP serving port |
| 35729 | Live reload port |

## How to use this container image?
Command line:
```
sudo docker run -ti -p 8100:8100 -p 35729:35729 -v /yourprojectfolder:/app/project steelburn/ionic
```
Alternatively, just in case Ionic bug is still there, we need to use host networking. Use this command line:
```
sudo docker run -ti -p 8100:8100 -p 35729:35729 -v /yourprojectfolder:/app/project --net host steelburn/ionic
```
Of course, replace ```/yourproject``` with the actual directory of your project.

### What the container will run?
There is a run.sh script, which will do the following:
- switch to /app/project directory
- run a ```git pull``` on regular interval (every 2 minutes)
- run ```ionic serve ``` inside the directory

# About
This docker image is maintained by @steelburn ( steelburn[a]gmail[dot]com )
