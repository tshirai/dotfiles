#! /bin/bash

set -ex

if [ -f ~/.wgetrc ]; then
  cp ~/.wgetrc ~/tmp/.wgetrc.backup
fi
echo "check_certificate = off" >> ~/.wgetrc

# Run the package installation script.
# When additional packages are required, add them to it.

curl https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
# git clone git://github.com/yyuu/pyenv.git .pyenv
# cd .pyenv/plugins
# git clone git://github.com/yyuu/pyenv-virtualenv.git

export PATH=~/.pyenv/bin:$PATH
eval "$(pyenv init --path)"

cd ~
# mkdir .pyenv/cache
pyenv install 3.8.11
pyenv global 3.8.11

if [ -f ~/tmp/.wgetrc.backup ]; then
  mv ~/tmp/.wgetrc.backup ~/.wgetrc
else
  rm ~/.wgetrc
fi
