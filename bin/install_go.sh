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

# install peco
if [ -x "$GOPATH" ]; then
    dir=~/go/src/github.com/peco/peco
    if [ ! -d ${dir} ]; then
       git clone https://github.com/peco/peco  ${dir}
    fi
    cd ${dir}
    make build
    go build cmd/peco/peco.go
    cp ${dir}/peco ~/local/bin/
    # copy peco config
    mkdir -p ~/.config/peco/
    cp ~/dotfiles/peco_config.json ~/.config/peco/config.json
fi
