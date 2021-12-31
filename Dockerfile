FROM ubuntu:18.04
MAINTAINER senoo

USER root
RUN apt-get update -y && \
apt install -y tzdata && \
apt install -y git && \
apt install -y vim g++ pkg-config python3-minimal libboost-all-dev libssl-dev libsqlite3-dev libpcap-dev libsystemd-dev

#NDN-FC-plus
#ndn-cxx-FC
RUN git clone https://github.com/nakazatoh/NDN-FC-plus.git && \
cd NDN-FC-plus/ndn-cxx-FC && \
./waf configure && \
./waf && \
./waf install && \
ldconfig
#NFD-FC
RUN cd NDN-FC-plus/NFD-FC && \
./waf configure && \
./waf && \
./waf install && \
ldconfig
#NDN-FC-skeleton
RUN cd NDN-FC-plus/NDN-FC-skeleton && \
./waf configure && \
./waf


#minoeru
# ndn-cxx
RUN git clone https://github.com/named-data/ndn-cxx.git  && \
apt-get install -y build-essential libsqlite3-dev libboost-all-dev libssl-dev && \
cd ndn-cxx && \
./waf configure && \
./waf && \
./waf install && \
ldconfig
# NFD
RUN apt install -y software-properties-common && \
add-apt-repository ppa:named-data/ppa && \
apt update && \
apt install -y nfd && \
apt install -y libpcap-dev libsystemd-dev && \
apt install pkg-config && \
git clone --recursive https://github.com/named-data/NFD.git
ENV PKG_CONFIG_PATH /custom/lib/pkgconfig
RUN cd NFD && \
./waf configure && \
./waf && \
./waf install && \
cp /usr/local/etc/ndn/nfd.conf.sample /usr/local/etc/ndn/nfd.conf
# PSync library
RUN git clone https://github.com/named-data/PSync.git && \
cd PSync && \
./waf configure && \
./waf && \
./waf install
# ndn-tools
RUN git clone https://github.com/named-data/ndn-tools.git && \
cd ndn-tools && \
./waf configure && \
./waf && \
./waf install
# NLSR
RUN git clone https://github.com/named-data/NLSR.git && \
cd NLSR && \
./waf configure && \
./waf && \
./waf install
