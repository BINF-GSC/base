################# BASE IMAGE ######################
FROM alpine:latest

################## METADATA #######################
LABEL base.image="alpine:latest"
LABEL version="1"
LABEL software="alpine"
LABEL software.version="latest"
LABEL about.summary="A base image for running bioinformatic software"
LABEL about.documentation="https://wiki.alpinelinux.org/wiki/Main_Page"
LABEL about.license="BSD 2-Clause"
LABEL about.lincense.file="https://github.com/alpinelinux/alpine-wiki/blob/master/LICENSE"

################## MAINTAINER #####################
LABEL maintainer.name="William Hargreaves"
LABEL maintainer.email="whargrea@uoguelph.ca"

################# INSTALLATION ####################
# install the sudo package
RUN apk update && \
    apk add --no-cache sudo bash

# enable the wheel no password sudo group
RUN sed \
    -e 's/# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/g' \
    -i /etc/sudoers

# add the user hackerman, the direcotries /data, /config, & /opt and give
# hackerman ownership over them
RUN adduser hackerman -G wheel -D && \
    mkdir /data /config /opt && \
    chown hackerman /data && \
    chown hackerman /config && \
    chown hackerman /opt

# make /data and /config externally mountable directories for data from host
# or other containers
VOLUME ["/data", "/config"]

# change to user hackerman
USER hackerman

# set workdir
WORKDIR /data

# Overwrite this with 'CMD []' in a dependent Dockerfile
CMD ["/bin/ash"]