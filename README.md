# fallingreign/flexget

A simple [flexget](https://flexget.com) container with:

* [deluge-client](https://pypi.org/project/deluge-client/) (required for [deluge plugin](https://flexget.com/Plugins/deluge))
* [subliminal](https://subliminal.readthedocs.io/en/latest/) (required for [subliminal plugin](https://flexget.com/Plugins/subliminal))

### Usage

```
docker create \
  --name=flexget \
  -e PUID=1000 \
  -e PGID=1000 \
<<<<<<< HEAD
  -e TZ=Country/City \
=======
  -e TZ=Australia/Melbourne \
  -e FLEXGET_LOG_LEVEL=info
  -e FLEXGET_WEB_PASS=password
>>>>>>> e5f3e307ce05d74ab0d46141da8d9bb2e0d8f6e8
  -p 5050:5050 \
  -v <path/to/config>:/config \
  -v <path/to/media>:/media \
  -v <path/to/downloads>:/downloads \
  --restart always \
  fallingreign/flexget
```

#### Container Parameters

| Parameter | Function |
| :----: | --- |
| `-p 5050` | The port for the flexget webinterface |
| `-e PUID=1000` | for UserID |
| `-e PGID=1000` | for GroupID |
<<<<<<< HEAD
| `-e TZ=Country/City` | Specify a [timezone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones_) |
=======
| `-e TZ=Australia/Melbourne` | Specify a timezone |
| `-e FLEXGET_LOG_LEVEL=debug` | Specify a flexget debug level|
| `-e FLEXGET_WEB_PASS=password` | Specify a password for the flexget web interface|
>>>>>>> e5f3e307ce05d74ab0d46141da8d9bb2e0d8f6e8
| `-v /config` | Flexget config files |
| `-v /media` | Location of your media library on disk |
| `-v /downloads` | Location of your download directory |
