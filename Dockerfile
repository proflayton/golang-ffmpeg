# iron/go:dev is the alpine image with the go tools added
FROM golang:1.10.2-alpine

# Install dependancies
RUN apk update \
	&& apk add git \
	&& apk add alpine-sdk \
	&& apk add yasm \
	&& apk add diffutils \
	&& apk add perl \
	&& apk add bash

RUN git clone https://chromium.googlesource.com/webm/libvpx /root/libvpx && \
	cd /root/libvpx && \
	./configure && \
	make -j8 &&  make install -j8

RUN cd /root && \
	wget http://downloads.xiph.org/releases/ogg/libogg-1.3.0.tar.gz && \
	tar xzvf libogg-1.3.0.tar.gz && \
	cd /root/libogg-1.3.0 && \
	./configure --disable-shared && \
	make -j8 && make install -j8

RUN cd /root && \
	wget http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.3.tar.gz && \
	tar xzvf libvorbis-1.3.3.tar.gz && \
	cd /root/libvorbis-1.3.3 && \
	./configure --disable-shared && \
	make -j8 && make install -j8

RUN git clone --depth 1 https://git.videolan.org/git/x264 /root/x264 && \
	cd /root/x264 && \
	./configure --disable-asm --enable-static --enable-pic --disable-shared && \
	make -j8 &&  make install -j8

# Compile and install ffmpeg from source
RUN git clone https://github.com/FFmpeg/FFmpeg /root/ffmpeg && \
    cd /root/ffmpeg && \
    ./configure --enable-nonfree --enable-gpl --enable-libvorbis --enable-libvpx --enable-libx264 --disable-shared --extra-cflags=-I/usr/local/include && \
    make -j8 && make install -j8
