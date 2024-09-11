#!/usr/bin/env bash

# pacman -S --noconfirm base-devel mingw-w64-i686-toolchain \
#   mingw-w64-x86_64-toolchain pactoys git unzip zip

git clone --depth 1 https://github.com/vim/vim

cd vim

rm -rf vim91*
rm -rf src/objx86-64/*.o

cd ./src

make -f Make_ming.mak GUI=no FEATURES=HUGE ARCH=x86-64 \
    PYTHON3=C:/Users/$(whoami)/scoop/apps/python/current \
    DYNAMIC_PYTHON3=yes PYTHON3_VER=312
make -f Make_ming.mak GUI=yes FEATURES=HUGE ARCH=x86-64 \
    PYTHON3=C:/Users/$(whoami)/scoop/apps/python/current \
    DYNAMIC_PYTHON3=yes PYTHON3_VER=312

cd ..
mkdir vim91
cp -r runtime/* vim91
cp src/*.exe vim91
cp src/tee/tee.exe vim91
cp src/xxd/xxd.exe vim91
mkdir vim91/GvimExt32
mkdir vim91/GvimExt64
cp src/GvimExt/gvimext.dll vim91/GvimExt32

curl -Lo gettext-iconv.zip https://github.com/mlocati/gettext-iconv-windows/releases/download/v0.21-v1.16/gettext0.21-iconv1.16-shared-64.zip
unzip -d gettext-iconv gettext-iconv.zip

cp gettext-iconv/bin/libintl-8.dll vim91
cp gettext-iconv/bin/libiconv-2.dll vim91

cp gettext-iconv/bin/libintl-8.dll vim91/GvimExt32
cp gettext-iconv/bin/libiconv-2.dll vim91/GvimExt32

cp gettext-iconv/bin/libintl-8.dll vim91/GvimExt64
cp gettext-iconv/bin/libiconv-2.dll vim91/GvimExt64

rm -rf gettext-iconv*
