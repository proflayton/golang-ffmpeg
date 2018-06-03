# iron/go:dev is the alpine image with the go tools added
FROM golang:1.10.2-alpine

# Install dependancies
RUN apk update \
	&& apk add git \
	&& apk add alpine-sdk \
	&& apk add yasm

# Compile and install ffmpeg from source
RUN git clone https://github.com/FFmpeg/FFmpeg /root/ffmpeg && \
    cd /root/ffmpeg && \
    ./configure --enable-nonfree --disable-shared --extra-cflags=-I/usr/local/include && \
    make -j8 && make install -j8
