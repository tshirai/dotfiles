#! /bin/bash


if [ ! -d ~/.goenv ]; then
  git clone https://github.com/syndbg/goenv.git ~/.goenv
fi

# goenv install -l
# goenv install <version>
# goenv global <version>
# go get github.com/nsf/gocode
# go get github.com/rogpeppe/godef
# go get github.com/golang/lint/golint
# go get github.com/kisielk/errcheck
