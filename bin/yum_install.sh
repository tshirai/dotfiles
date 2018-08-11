#! /bin/bash
set -ex

sudo yum install -y openssh zsh git
sudo yum install -y telnet wget bind-utils nc tcpdump ngrep traceroute
sudo yum install -y patchutils gcc gcc-c++ automake autoconf zlib zlib-devel
sudo yum install -y readline readline-devel openssl openssl-devel libffi libffi-devel
sudo yum install -y kernel-headers glibc-headers rpm-build libtool doxygen
sudo yum install -y sysstat
sudo yum install -y epel-release
sudo yum install -y lv man tree
sudo yum install -y tmux subversion
