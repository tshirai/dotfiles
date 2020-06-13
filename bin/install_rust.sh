#! /bin/bash

# https://www.rust-lang.org/tools/install
if [ ! -d ~/.cargo ]; then
  curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
fi

export PATH=~/.cargo/bin:$PATH

cargo install ripgrep bat exa fd-find
