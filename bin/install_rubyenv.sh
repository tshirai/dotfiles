#! /bin/bash


if [ -f /etc/redhat-release ]; then
    sudo yum install -y git gcc gcc-c++ openssl-devel readline-devel
elif [ -f /etc/debian_version ]; then
    # after install_python.py
    sudo apt install -y autoconf bison libyaml-dev
fi

if [ ! -f ~/.rbenv ]; then
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
fi

if [ ! -f ~/.rbenv/plugins/ruby-build ]; then
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

if [ ! -f ~/.rbenv/plugins/rbenv-update ]; then
    git clone https://github.com/rkh/rbenv-update.git ~/.rbenv/plugins/rbenv-update
fi
