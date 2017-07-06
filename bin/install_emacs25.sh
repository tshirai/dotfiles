#! /bin/bash

set -ex 

cd ~/local/src/

# sudo yum install xz -y
ver=25.2

[ -f emacs-${ver}.tar.xz ] && rm emacs-${ver}.tar.xz
wget http://ftp.jaist.ac.jp/pub/GNU/emacs/emacs-${ver}.tar.xz
# tar Jxf emacs-${ver}.tar.xz
xz -df emacs-${ver}.tar.xz
tar xf emacs-${ver}.tar

cd emacs-${ver}/
./configure --prefix=${HOME}/local/emacs --without-x
make
make install
