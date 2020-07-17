#! /bin/bash

set -ex

if [ -f /etc/redhat-release ]; then
    sudo yum install libevent libevent-devel -y
fi

cd ~/local/src
[ -f tmux-3.1.tar.gz ] || wget https://github.com/tmux/tmux/releases/download/3.1/tmux-3.1.tar.gz
[ -d tmux-3.1 ] || tar zxf tmux-3.1.tar.gz
cd tmux-3.1
./configure --prefix=${HOME}/local/tmux-3.1
make
make install
cd ~/local
ln -s ${HOME}/local/tmux-3.1 tmux
