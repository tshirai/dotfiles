#! /bin/bash

set -ex

if [ -f ~/.wgetrc ]; then
  cp ~/.wgetrc ~/tmp/.wgetrcbackup
fi
echo "check_certificate = off" >> ~/.wgetrc

if [ -f /etc/redhat-release ]; then
  sudo yum install bzip2 bzip2-libs bzip2-devel patch -y
elif [ -f /etc/debian_version ]; then
  sudo apt install build-essential libbz2-dev libdb-dev \
    libreadline-dev libffi-dev libgdbm-dev liblzma-dev \
    libncursesw5-dev libsqlite3-dev libssl-dev \
    zlib1g-dev uuid-dev tk-dev \
    libgnutls28-dev \
    -y
fi

cd ~
git clone git://github.com/yyuu/pyenv.git .pyenv

export PATH=~/.pyenv/bin:$PATH
eval "$(pyenv init -)"
cd .pyenv/plugins
git clone git://github.com/yyuu/pyenv-virtualenv.git

cd ~
mkdir .pyenv/cache
pyenv install 3.8.3
pyenv global 3.8.3

if [ -f ~/tmp/.wgetrc.backup ]; then
  mv ~/tmp/.wgetrcbackup ~/.wgetrc
else
  rm ~/.wgetrc
fi
