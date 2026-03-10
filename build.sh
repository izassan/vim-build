#!/usr/bin/env bash

set -e

vim_version=$1
python_version=$2
python_directory=$3

pacman -S --noconfirm --needed base-devel mingw-w64-i686-toolchain \
  mingw-w64-x86_64-toolchain pactoys git unzip zip

if [ ! -d ./vim ]; then
    git clone --depth 1 https://github.com/vim/vim
fi

cd ./vim/src

make -f Make_ming.mak GUI=yes ARCH=x86-64 \
    STATIC_STDCPLUS=yes \
    PYTHON3=$python_directory \
    DYNAMIC_PYTHON3=yes PYTHON3_VER=$python_version
make -f Make_ming.mak GUI=no ARCH=x86-64 \
    STATIC_STDCPLUS=yes \
    PYTHON3=$python_directory \
    DYNAMIC_PYTHON3=yes PYTHON3_VER=$python_version

cd ..
if [ -d ./vim$vim_version ]; then
    rm -r ./vim$vim_version
fi
mkdir vim$vim_version
cp -r runtime/* vim$vim_version
cp src/*.exe vim$vim_version
cp src/tee/tee.exe vim$vim_version
cp src/xxd/xxd.exe vim$vim_version
mkdir vim$vim_version/GvimExt32
mkdir vim$vim_version/GvimExt64
cp src/GvimExt/gvimext.dll vim$vim_version/GvimExt32

curl -Lo gettext-iconv.zip https://github.com/mlocati/gettext-iconv-windows/releases/download/v0.21-v1.16/gettext0.21-iconv1.16-shared-64.zip
unzip -d gettext-iconv gettext-iconv.zip

cp gettext-iconv/bin/libintl-8.dll vim$vim_version
cp gettext-iconv/bin/libiconv-2.dll vim$vim_version

cp gettext-iconv/bin/libintl-8.dll vim$vim_version/GvimExt32
cp gettext-iconv/bin/libiconv-2.dll vim$vim_version/GvimExt32

cp gettext-iconv/bin/libintl-8.dll vim$vim_version/GvimExt64
cp gettext-iconv/bin/libiconv-2.dll vim$vim_version/GvimExt64

rm -rf gettext-iconv*
