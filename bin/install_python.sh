#! /bin/bash

set -ex

if [ -f ~/.wgetrc ]; then
  cp ~/.wgetrc ~/tmp/.wgetrcbackup
fi
echo "check_certificate = off" >> ~/.wgetrc

sudo yum install bzip2 bzip2-libs bzip2-devel -y

cd ~
git clone git://github.com/yyuu/pyenv.git .pyenv

export PATH=~/.pyenv/bin:$PATH
eval "$(pyenv init -)"
cd .pyenv/plugins
git clone git://github.com/yyuu/pyenv-virtualenv.git

cd ~
mkdir .pyenv/cache
pyenv install 2.7.8
pyenv global 2.7.8

if [ -f ~/tmp/.wgetrc.backup ]; then
  mv ~/tmp/.wgetrcbackup ~/.wgetrc
else
  rm ~/.wgetrc
fi
