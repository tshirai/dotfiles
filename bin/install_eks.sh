#! /bin/bash

# see https://docs.aws.amazon.com/ja_jp/eks/latest/userguide/getting-started.html

cat <<EOF > ~/tmp/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

sudo cp ~/tmp/kubernetes.repo /etc/yum.repos.d/
yum install -y kubectl

wget curl -O ~/local/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/aws-iam-authenticator
chmod +x ~/local/bin/aws-iam-authenticator
