#! /bin/bash


sudo yum install -y git gcc gcc-c++ openssl-devel readline-devel

if [ ! -f ~/.rbenv ]; then
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
fi

if [ ! -f ~/.rbenv/plugins/ruby-build ]; then
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi
