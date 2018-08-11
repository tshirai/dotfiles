#! /bin/bash

# curl -L git.io/nodebrew | perl - setup

wget git.io/nodebrew -O ~/tmp/nodebrew
perl ~/tmp/nodebrew setup

export PATH=~/.nodebrew/current/bin:$PATH

nodebrew install latest
nodebrew use latest
if [ ! "${http_proxy}" = "" ]; then
  npm config set proxy $http_proxy
  npm config set https-proxy $http_proxy
  npm config set registry http://registry.npmjs.org/
fi

# for emacs
npm install -g jshint
npm install -g jsonlint
npm install -g grunt-cli
