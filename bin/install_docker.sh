#! /bin/bash

if [ -f /etc/redhat-release ]; then
    # https://docs.docker.jp/engine/installation/linux/docker-ce/centos.html#docker-ce
    echo "Not implemented. Use install_podman.sh. Or, see the above link."
    # sudo yum install -y docker
    # sudo systemctl start docker
    # sudo systemctl enable docker
elif [ -f /etc/debian_version ]; then
    # https://docs.docker.com/engine/install/ubuntu/#installation-methods
    sudo apt -y install apt-transport-https ca-certificates curl \
         gnupg-agent software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo apt-key fingerprint 0EBFCD88
    sudo add-apt-repository \
           "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
           $(lsb_release -cs) \
           stable"
    sudo apt -y install docker.io=17.12.1-0ubuntu1
    # I Cannot run docker-ce in WSL.
    # sudo apt -y install docker-ce docker-ce-cli containerd.io
fi
sudo usermod -aG docker ${USER}
