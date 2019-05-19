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
  -e TZ=Australia/Melbourne \
  -p 5050:5050 \
  -v <path/to/config.yml>:/config \
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
| `-e TZ=Australia/Melbourne` | Specify a timezone |
| `-v /config` | Flexget config files |
| `-v /media` | Location of your media library on disk |
| `-v /downloads` | Location of your download directory |
