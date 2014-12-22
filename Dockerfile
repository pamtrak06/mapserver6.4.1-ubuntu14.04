FROM pamtrak06/ubuntu14.04-apache2-python

MAINTAINER pamtrak06 <pamtrak06@gmail.com>

# Install mapcache compilation prerequisites
RUN apt-get install -y software-properties-common g++ make cmake wget git

# Install mapcache dependencies provided by Ubuntu repositories
RUN apt-get install -y \
	libxml2-dev \
	libxslt1-dev \
	libproj-dev \
	libfribidi-dev \
	libcairo2-dev \
	librsvg2-dev \
	libmysqlclient-dev \
	libpq-dev \
	libcurl4-gnutls-dev \
	libexempi-dev \
	libgdal-dev \
	libgeos-dev

# Install libharfbuzz from source as it is not in a repository
RUN apt-get install -y bzip2
RUN cd /tmp && wget http://www.freedesktop.org/software/harfbuzz/release/harfbuzz-0.9.19.tar.bz2 && \
    tar xjf harfbuzz-0.9.19.tar.bz2 && \
    cd harfbuzz-0.9.19 && \
    ./configure && \
    make && \
    make install && \
    ldconfig

# Install Mapserver itself
RUN git clone https://github.com/mapserver/mapserver/ /usr/local/src/mapserver

# Compile Mapserver for Apache
RUN mkdir /usr/local/src/mapserver/build && \
    cd /usr/local/src/mapserver/build && \
    cmake ../ -DWITH_THREAD_SAFETY=1 \
        -DWITH_PROJ=1 \
        -DWITH_KML=1 \
        -DWITH_SOS=1 \
        -DWITH_WMS=1 \
        -DWITH_FRIBIDI=1 \
        -DWITH_HARFBUZZ=1 \
        -DWITH_ICONV=1 \
        -DWITH_CAIRO=1 \
        -DWITH_RSVG=1 \
        -DWITH_MYSQL=1 \
        -DWITH_GEOS=1 \
        -DWITH_POSTGIS=1 \
        -DWITH_GDAL=1 \
        -DWITH_OGR=1 \
        -DWITH_CURL=1 \
        -DWITH_CLIENT_WMS=1 \
        -DWITH_CLIENT_WFS=1 \
        -DWITH_WFS=1 \
        -DWITH_WCS=1 \
        -DWITH_LIBXML2=1 \
        -DWITH_GIF=1 \
        -DWITH_EXEMPI=1 \
        -DWITH_XMLMAPFILE=1 \
    -DWITH_FCGI=0 && \
    make && \
    make install && \
    ldconfig


# Apache configuration for mapcache
#COPY mapserver.load /etc/apache2/mods-available/
#COPY mapserver.conf /etc/apache2/mods-available/

# Enable mapcache module in Apache
#RUN a2enmod mapserver

# Volumes
VOLUME ["/var/www", "/var/log/apache2", "/etc/apache2"]

# Expose ports
EXPOSE 22 80 443

# Define default command
CMD ["apachectl", "-D", "FOREGROUND"]
