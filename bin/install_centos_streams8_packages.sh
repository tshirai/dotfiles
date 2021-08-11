#! /bin/bash

sudo dnf install -y openssh zsh git
sudo dnf install -y telnet wget bind-utils nc tcpdump traceroute
sudo dnf install -y patchutils gcc gcc-c++ automake autoconf zlib zlib-devel
sudo dnf install -y readline readline-devel openssl openssl-devel libffi libffi-devel
sudo dnf install -y kernel-headers glibc-headers rpm-build libtool 
sudo dnf install -y gnutls-devel gnutls-utils
sudo dnf install -y sysstat
sudo dnf install -y epel-release
sudo dnf install -y man tree
sudo dnf install -y tmux subversion
sudo dnf install -y podman-docker podman-compose
sudo dnf install -y bzip2 bzip2-devel sqlite sqlite-devel tk-devel xz-devel
# ngrep doxygen
