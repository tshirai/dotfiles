#! /bin/bash

set -ex

if [ -f /etc/redhat-release ]; then
    sudo yum install libevent libevent-devel -y
elif [ -f /etc/debian_version ]; then
    sudo apt install libevent-dev libncurses5-dev -y
fi

cd ~/local/src
[ -f tmux-3.2.tar.gz ] || wget https://github.com/tmux/tmux/releases/download/3.2/tmux-3.2.tar.gz
[ -d tmux-3.2 ] || tar zxf tmux-3.2.tar.gz
cd tmux-3.2
./configure --prefix=${HOME}/local/tmux-3.2
make
make install
cd ~/local
ln -s ${HOME}/local/tmux-3.2 tmux
