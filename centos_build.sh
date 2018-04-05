#!/bin/sh -x

yum install -y gcc  gcc-c++ gdb bison flex byacc make file perl automake libtool
yum install -y wget bzip2 bzip2-devel zlib zlib-devel gettext-devel
yum install -y gnutls-devel libxml2-devel GeoIP-devel
yum install -y readline readline-devel centos-release-scl
yum install -y openssl-devel krb5-devel snappy-devel c-ares-devel 
yum install -y libnl-devel libnl3-devel libsmi-devel libssh-devel

wget https://sourceware.org/ftp/libffi/libffi-3.2.1.tar.gz
tar zxvf libffi-3.2.1.tar.gz
pushd libffi-3.2.1 || exit 1
./configure --prefix=/usr --libdir=/usr/lib64 --disable-static
make
make install
popd || exit 1
rm -rf ./libffi*

wget https://ftp.pcre.org/pub/pcre/pcre-8.41.tar.gz
tar -xzf pcre-8.41.tar.gz
pushd pcre-8.41 || exit 1
./configure --prefix=/usr                     \
            --libdir=/usr/lib64               \
            --docdir=/usr/share/doc/pcre-8.41 \
            --enable-unicode-properties       \
            --enable-pcre16                   \
            --enable-pcre32                   \
            --enable-pcregrep-libz            \
            --enable-pcregrep-libbz2          \
            --enable-pcretest-libreadline     \
            --disable-static                  \
            --enable-utf8
make
make install
popd || exit 1
rm -rf ./pcre*

wget http://ftp.gnome.org/pub/gnome/sources/glib/2.54/glib-2.54.0.tar.xz
xz -d glib-2.54.0.tar.xz
tar -xvf glib-2.54.0.tar
pushd glib-2.54.0 || exit 1
./configure --prefix=/usr --libdir=/usr/lib64 --enable-libmount=no
make
LD_LIBRARY_PATH=\$LD_LIBRARY_PATH make install
popd || exit 1
rm -rf ./glib*

wget https://www.python.org/ftp/python/2.7.14/Python-2.7.14.tgz 
tar zxvf Python-2.7.14.tgz 
pushd Python-2.7.14 || exit 1 
./configure --prefix=/usr/local 
make ;\
make install
popd
rm -fr ./Python-2.7.14*

wget http://www.tcpdump.org/release/libpcap-1.8.1.tar.gz
tar zxvf libpcap-1.8.1.tar.gz
pushd libpcap-1.8.1 || exit 1
./configure --prefix=/usr --libdir=/usr/lib64
make
make install
popd || exit 1
rm -rf ./libpcap*

wget ftp://ftp.gnupg.org/gcrypt/libgpg-error/libgpg-error-1.27.tar.gz
tar zxvf libgpg-error-1.27.tar.gz
pushd libgpg-error-1.27 || exit 1
./configure --prefix=/usr --libdir=/usr/lib64
make
make install
popd || exit 1
rm -rf libgpg*

wget ftp://ftp.gnupg.org/gcrypt/libgcrypt/libgcrypt-1.8.1.tar.bz2
tar -jxvf libgcrypt-1.8.1.tar.bz2
pushd libgcrypt-1.8.1 || exit 1
./configure --prefix=/usr --libdir=/usr/lib64
make
make install
popd || exit 1
rm -rf ./libgcrypt*

wget https://github.com/lz4/lz4/archive/v1.8.1.2.tar.gz
tar zxvf v1.8.1.2.tar.gz
pushd lz4-1.8.1.2 || exit 1
make
make install
cp lib/liblz4.a /usr/lib64
cp lib/liblz4.so /usr/lib64
pushd /usr/lib64 || exit 1
ln -s liblz4.so liblz4.so.1
ln -s liblz4.so liblz4.so.1.8.1
popd || exit 1
popd || exit 1
rm -rf ./*1.8.1.2*

wget https://github.com/nghttp2/nghttp2/archive/v1.31.0.tar.gz
tar zvxf v1.31.0.tar.gz
pushd nghttp2-1.31.0 || exit 1
autoreconf -i
automake
autoconf
./configure --prefix=/usr --libdir=/usr/lib64
make
make install
popd || exit 1
rm -fr ./*1.31.0*

wget https://www.wireshark.org/download/src/all-versions/wireshark-2.4.5.tar.xz
xz -d wireshark-2.4.5.tar.xz
tar -xvf wireshark-2.4.5.tar
pushd wireshark-2.4.5 || exit 1
./configure --prefix=/usr \
            --libdir=/usr/lib64 \
            --with-ssl=/usr/lib64 \
            --with-gtk=no \
            --with-qt=no \
            --disable-wireshark \
            --sysconfdir=/etc \
            --enable-tfshark 
make -j 8
make install
popd || exit 1
rm -rf ./wireshark*