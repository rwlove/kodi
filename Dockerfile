FROM ubuntu:16.04

#####
# Configure Environment Variables
#####

# # Ensure UTF-8 lang and locale
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8
ENV TZ         America/Los_Angeles

ENV DEBIAN_FRONTEND noninteractive

#####
# Configure APT Cacher Proxy
#####

RUN  echo 'Acquire::http { Proxy "http://apt-cache-proxy:3142"; };' >> /etc/apt/apt.conf.d/01proxy


#####
# Update and Install Packages
#####

RUN apt-get -y update && \
apt-get -y dist-upgrade

RUN apt-get install -y software-properties-common

#add-apt-repository -y ppa:team-xbmc/ppa && \

RUN add-apt-repository -y multiverse && \
add-apt-repository -y ppa:team-xbmc/unstable && \
add-apt-repository -y ppa:wsnipex/vaapi && \
add-apt-repository -y ppa:jlbarriere68/ppa && \
apt-get -y update

RUN apt-get purge kodi-pvr-mythtv*

RUN apt-get -y install \
pulseaudio \
strace \
kodi \
kodi-pvr-mythtv \
kodi-visualization* \
dbus-x11 \
vainfo \
x11-apps \
libcurl4-openssl-dev \
x11-xserver-utils \
coreutils \
nodejs \
npm

#####
# Install and configure 'kodi'
#####

#may need to add screensaver stop/start files to /usr/local/bin

ADD kodi_config_files.tar.gz /

# visualization.goom, visualization.projectm and visualization.spectrum are installed to the wrong location
RUN mv /usr/lib/x86_64-linux-gnu/addons/* /usr/lib/kodi/addons/

RUN ln /usr/bin/nodejs /usr/bin/node

EXPOSE 8080
EXPOSE 9090
EXPOSE 1900
EXPOSE 9777

COPY plugin.video.youtube-5.2.24-BETA.zip /plugin.video.youtube-5.2.24-BETA.zip

RUN apt-get install kodi-inputstream-mpd

CMD ["/usr/local/bin/launchKodi.sh"]

#####
# Clean up
#####

RUN apt-get -y clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*