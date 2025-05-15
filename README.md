# docker-nextcloudcmd-client
[![Docker Pulls](https://img.shields.io/docker/pulls/dyonr/nextcloudcmd-client)](https://hub.docker.com/r/dyonr/nextcloudcmd-client)
[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/dyonr/nextcloudcmd-client/latest)](https://hub.docker.com/r/dyonr/nextcloudcmd-client)  

Dockerized Nextcloud command line client (nextcloudcmd) to sync from any supported Nextcloud(-like) environment.  
This container _should_ work with any Nextcloud, TransIP STACK or any other Nextcloud(-like) based storage endpoint.

This project is a continuation of [docker-nextcloudcmd-client](https://github.com/DyonR/docker-nextcloudcmd-client) to use Nextcloud instead of ownCloud.  
This project is **only** tested with **TransIP's STACK**.

The main use of this Docker is to be able to synchronise with a Nextcloud(-like) environment that is not part of the server that you run this Docker on.
Example use case of this container is that you have a remote (Nextcloud-like) cloud storage somewhere, that you wish to have continously synced with your server that runs this Docker. Like the Nextcloud of a friend or a paid Nextcloud(-like) environment like TransIP STACK.

## Docker Features
* Base: Debian 10
* Size: <100MB
* **Ability to only sync only one (sub)folder**
* Created with [Unraid](https://unraid.net/) in mind


# Run container from Docker registry
The container is available from the Docker registry and this is the simplest way to get it.

To run the container use this command:
```
$ docker run -d \
             --name='nextcloudcmd-client' \
             -v /your/nextclouddata/path/:/nextclouddata \
             -e NEXTCLOUD_USER=nextcloud_username \
             -e NEXTCLOUD_PASS=nextcloud_password \
             -e NEXTCLOUD_SERVER=mynextcloud.com \
             --restart unless-stopped \
             'dyonr/nextcloudcmd-client'
```

# Environment Variables & Volumes
## Environment Variables
| Variable | Required | Function | Example | Default |
|----------|----------|----------|----------|----------|
|`NEXTCLOUD_USER`| Yes | Username (or email) to connect to Nextcloud |`NEXTCLOUD_USER=dyonr`||
|`NEXTCLOUD_PASS`| Yes | Password or App-Token for the Nextcloud user |`NEXTCLOUD_PASS=ac98df79ed7fb`||
|`NEXTCLOUD_SERVER`| Yes | Nextcloud Environment server address, with port if it's not a default port number |`NEXTCLOUD_SERVER=example.com:8443`||
|`NEXTCLOUD_PROTO`| No | Connect via http or https |`NEXTCLOUD_PROTO=https`|`https`|
|`NEXTCLOUD_URLPATH`| No | Server path to the Nextcloud instance (example: https://example.com:8443/Nextcloud/ becomes `/Nextcloud/`) |`NEXTCLOUD_URLPATH=/Nextcloud/`| `/Nextcloud/`|
|`NEXTCLOUD_WEBDAV`| No | In case the webdav path is not `remote.php/webdav`, you can change it here |`NEXTCLOUD_WEBDAV=remote.php/webdav`| `remote.php/webdav` |
|`NEXTCLOUD_FILEPATH`| No | Only sync one specific folder |`NEXTCLOUD_FILEPATH=/Pictures/Holiday-2020`|`/`|
|`TRUST_SELFSIGN`| No | Ignore self-signed certificate errors (Set to `1` to ignore SSL errors)|`TRUST_SELFSIGN=0`|`0`|
|`SYNC_HIDDEN`| No | Set to `1` to sync all hidden files within the specified Nextcloud directory|`SYNC_HIDDEN=0`|`0`|
|`SILENCE_OUTPUT`| No | Set to `0` to get more verbose output |`SILENCE_OUTPUT=1`|`1`|
|`RUN_INTERVAL`| No | Interval in seconds at which the client will run and check for changes |`RUN_INTERVAL=60`|`30`|
|`RUN_UID`| No | UID of the occlient user and the /nextclouddata folder/files |`RUN_UID=99`|`99`|
|`RUN_GID`| No | GID of the occlient user and the /nextclouddata folder/files |`RUN_UID=100`|`100`|

## Volumes
| Volume | Required | Function | Example |
|----------|----------|----------|----------|
| `nextclouddata` | Yes | Nextcloud sync location | `/your/nextclouddata/path/:/nextclouddata`|

## Ports
This Docker container exposes no ports, has no UI and therfore does not need to have any ports exposed.

# Issues
If you are having issues with this container please submit an issue on GitHub.
Please provide logs, Docker version and other information that can simplify reproducing the issue.
If possible, always use the most up to date version of Docker, you operating system, kernel and the container itself. Support is always a best-effort basis.

## Disclaimer
I am not responsible for any data loss due wrong configurations.
