#! /bin/bash

set -ex

easy_install Pygments
cd ~/local/bin

ln -s ${DOTFILES}/bin/lessfilter
