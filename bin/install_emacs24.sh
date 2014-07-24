#! /bin/bash

set -ex 

cd ~/local/src/

# sudo yum install xz -y

[ -f emacs-24.3.tar.xz ] && rm emacs-24.3.tar.xz
wget http://ftp.jaist.ac.jp/pub/GNU/emacs/emacs-24.3.tar.xz
# tar Jxf emacs-24.3.tar.xz
xz -df emacs-24.3.tar.xz
tar xf emacs-24.3.tar

cd emacs-24.3/
./configure --prefix=${HOME}/local/emacs --without-x
make
make install
