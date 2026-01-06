#! /bin/bash

# https://www.rust-lang.org/tools/install
if [ ! -d ~/.cargo ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

export PATH=~/.cargo/bin:$PATH

# To update, cargo install-update --all
cargo install cargo-update
cargo install ripgrep bat exa fd-find lsd git-delta
cargo install ht pastel gitui onefetch du-dust bottom mcfly
cargo install grex
