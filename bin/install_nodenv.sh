#! /bin/bash

set -ex

if [ ! -d ~/.nodenv ]; then
    git clone https://github.com/nodenv/nodenv.git ~/.nodenv
    cd ~/.nodenv
    src/configure
    make -C src
fi
cd ~/
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

# nodenv-update
mkdir -p "$(nodenv root)"/plugins

if [ ! -d "$(nodenv root)"/plugins/nodenv-update ]; then
    git clone https://github.com/nodenv/nodenv-update.git "$(nodenv root)"/plugins/nodenv-update
fi
if [ ! -d "$(nodenv root)"/plugins/node-build ]; then
    git clone https://github.com/nodenv/node-build.git "$(nodenv root)"/plugins/node-build
fi
