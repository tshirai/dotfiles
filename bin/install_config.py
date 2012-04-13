#! /usr/bin/env python
#encoding=utf8

import sys, os, os.path

HOME = os.environ["HOME"]
USER = os.environ["USER"]
DEFAULT_PATH = os.environ["PATH"]

def ws(message):
    sys.stdout.write("%s\n" % message)

def es(message):
    sys.stderr.write("! %s\n" % message)

def cd(path):
    if not os.path.exists(path):
        es("%s is not exists." % path)
        sys.exit(-1)

    if not os.path.isdir(path):
        es("%s is not directory." % path)
        sys.exit(-1)

    os.chdir(path)
    ws("cd %s" % path)

def sh(command, validation = True):
    ws(command)
    ret = os.system("%s" % command)
    if ret != 0 and validation:
        es("%s returns %d" % (command, ret))
        sys.exit(-1)

def mksshdir():
    if not os.path.exists("%s/.ssh" % HOME):
        sh("ssh localhost hostname", False)

def mkdir(path):
    ws("mkdir %s" % path)
    try:
        os.makedirs(path)
    except OSError:
        ws("-- %s exists" % path)


def ln(src, dest = ""):
    if dest == "":
        dest = os.path.basename(src)
    if os.path.exists(dest):
        if not os.path.islink(dest):
            es("%s already exists and is a real file" % dest)
            sys.exit(-1)
        else:
            sh("rm %s" % dest)
    sh("ln -s %s %s" %(src, dest))

def write_f(path, content):
    ws("write to %s" % path)
    try:
        f = file(path, "w")
        f.write(content)
        f.close()
    except IOError, (errno, strerror):
        es("I/O error(%s): %s" % (errno, strerror))
        sys.exit(-1)
        

def bash_profile():
    content = \
"""
export DOTFILES=$HOME/dotfiles
if [ -f $DOTFILES/bash_profile ]; then
  source $DOTFILES/bash_profile
  fi
  unset USERNAME
"""
    return content

def bashrc():
    content = \
"""
# export PATH=%s

export DOTFILES=$HOME/dotfiles
if [ -f $DOTFILES/bashrc ]; then
\tsource $DOTFILES/bashrc
fi

""" %(DEFAULT_PATH)
    return content

def zshrc():
    content = \
"""
export LANG=ja_JP.UTF-8
# export PATH=%s
export DOTFILES=$HOME/dotfiles
if [ -f ${DOTFILES}/zshrc ]
then
    source ${DOTFILES}/zshrc
fi
export PATH

# scpのリモートファイルを補完しない。パスワード聞かれるので。
zstyle ':completion:*:complete:scp:*:files' command command -
""" %(DEFAULT_PATH)
    return content

def dot_emacs():
    content = \
"""
(load "~/dotfiles/emacs.el")
"""
    return content


def main():
    cd(HOME)
    if len(sys.argv) == 2 and sys.argv[1] == "-a":
        # write_f(".bash_profile", bash_profile())
        # write_f(".bashrc", bashrc())
        write_f(".zshrc", zshrc())
        write_f(".emacs", dot_emacs())
        mksshdir()
        sh("cp dotfiles/ssh/config .ssh/")
        sh("cp dotfiles/ssh/authorized_keys .ssh/")
        sh("chmod 600 .ssh/config .ssh/authorized_keys")
        ln("%s/dotfiles/subversion/config" % HOME, ".subversion/config")
    else:
        ws("only update related files.")
        ws("try %s -a to install all" % sys.argv[0])
    sh("chmod -x `find %s/dotfiles -type f`" % HOME)
    sh("chmod +x %s/dotfiles/bin/*" % HOME)

    ln("%s/dotfiles/.gitignore" % HOME, ".gitignore")
    ln("%s/dotfiles/gitconfig" % HOME, ".gitconfig")
    ln("%s/dotfiles/gemrc" % HOME, ".gemrc")
    ln("%s/dotfiles/screenrc" % HOME, ".screenrc")
    ln("%s/dotfiles/tmux.conf" % HOME, ".tmux.conf")
    ln("%s/dotfiles/inputrc" % HOME, ".inputrc")

    mkdir("tmp")
    mkdir("proj")
    mkdir("local/src")
    mkdir("local/bin")
    mkdir("archives")
    return 0


if __name__ == "__main__":
    sys.exit(main())
