# What is mapserver ?

"MapServer is an Open Source platform for publishing spatial data and interactive mapping applications to the web. Originally developed in the mid-1990’s at the University of Minnesota, MapServer is released under an MIT-style license, and runs on all major platforms (Windows, Linux, Mac OS X). MapServer is not a full-featured GIS system, nor does it aspire to be." 

> [Source : www.mapserver.org ](http://www.mapserver.org)

![logo](http://www.mapserver.org/_static/banner.png)

> [Slideshare](http://fr.slideshare.net/tbonfort/modgeocache-mapcache-a-fast-tiling-solution-for-the-apache-web-server)

# How to use this image

## Build mapserver docker image

This image is built under ubuntu 14.04.
```
docker build -t pamtrak06/mapcache-ubuntu14.04:latest https://raw.githubusercontent.com/pamtrak06/mapcache-ubuntu14.04/master/Dockerfile
```

Embedded wmts example from Data source : Environnement Canada, (licence)[http://dd.meteo.gc.ca/doc/LICENCE_GENERAL.txt]

## Run mapserver docker container

Run container
```
$ docker run -d -p80:80 -v /usr/local/mapserver:/maps pamtrak06/mapserver-ubuntugis14.04
```

Data are shared between host (/usr/local/mapserver) and container (/maps).
All *.map file could be stored in /maps ans data in /maps/data


Open a terminal session on a running container
```
$ docker ps
$ docker exec -d pamtrak06/mapserver-ubuntugis14.04 /bin/bash
```

Exit container without stop it
```
CTRL+P  &  CTRL+Q
```

Get docker vm ip : 
```
$ boot2Docker ip => 192.168.59.103
```

Test
http://192.168.59.103:8787/cgi-bin/mapserv

Result
```
No query information to decode. QUERY_STRING is set, but empty.
```

![ScreenShot](geometca0.png)![ScreenShot](geometca1.png)

## Configure container
Mapcache configuration file could be fully modified or replaced.
Prerequisite : open a terminal session in the container.

```
$ vi /etc/apache2/conf-available/mapcache.xml
```
configure mapcache.xml with help from http://mapserver.org/fr/mapcache/config.html,
and then after modification restart apache server like
```
$ apachectl restart
```

