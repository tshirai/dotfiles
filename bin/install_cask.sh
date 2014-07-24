#! /bin/bash
# curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python

set -ex

cd ~
git clone https://github.com/cask/cask.git .cask
cd ~/.emacs.d
if [ "${http_proxy}" = "" ]; then
    cask
else
    cask --proxy $http_proxy
fi

