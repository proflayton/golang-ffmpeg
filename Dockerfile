# iron/go:dev is the alpine image with the go tools added
FROM golang:1.8

# Install dependancies
RUN apt-get -y update && apt-get install -y wget nano git build-essential yasm pkg-config

# Compile and install ffmpeg from source
RUN git clone https://github.com/FFmpeg/FFmpeg /root/ffmpeg && \
    cd /root/ffmpeg && \
    ./configure --enable-nonfree --disable-shared --extra-cflags=-I/usr/local/include && \
    make -j8 && make install -j8
