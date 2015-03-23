# What is mapserver ?

"MapServer is an Open Source platform for publishing spatial data and interactive mapping applications to the web. Originally developed in the mid-1990’s at the University of Minnesota, MapServer is released under an MIT-style license, and runs on all major platforms (Windows, Linux, Mac OS X). MapServer is not a full-featured GIS system, nor does it aspire to be." 

> [Source : www.mapserver.org ](http://www.mapserver.org)

![logo](http://www.mapserver.org/_static/banner.png)

# How to use this image

## Build a local image

This image is built under ubuntu 14.04 with mapserver version 6.4.1.
```
docker build -t pamtrak06/mapserver-ubuntugis14.04:latest https://raw.githubusercontent.com/pamtrak06/mapserver-ubuntugis14.04/master/Dockerfile
```

## Run container

```
$ docker run -d -p 8989:80 -v /usr/local/mapserver:/maps pamtrak06/mapserver-ubuntugis14.04
```

Data are shared between host (/usr/local/mapserver) and container (/maps).
All *.map file could be stored in /maps and data in /maps/data

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

Test install : http://192.168.59.103:8989/cgi-bin/mapserv

```
No query information to decode. QUERY_STRING is set, but empty.
```

## Configure container

