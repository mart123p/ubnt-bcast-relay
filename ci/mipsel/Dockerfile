FROM ubuntu:20.04

RUN  export DEBIAN_FRONTEND=noninteractive && apt-get update \
&& apt-get -y install build-essential flex gawk help2man libncurses-dev file unzip texinfo libtool-bin wget git && \
cd /root/ && \
wget http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-1.24.0.tar.xz && \
tar -xf crosstool-ng-1.24.0.tar.xz && \
cd crosstool-ng-1.24.0 && \
./configure && \
make && \
make install && \
mkdir -p /root/toolchain-build/

COPY .config /root/toolchain-build

RUN cd /root/toolchain-build && ct-ng build && \
rm -rf /root/toolchain-build/.build && \
rm -rf /root/toolchain-build/build.log && \
rm -rf /root/crosstool-ng-* && \
rm -rf /var/lib/apt/lists/*