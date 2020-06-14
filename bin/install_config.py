#! /usr/bin/env python

import sys
import os
import os.path

HOME = os.environ["HOME"]
USER = os.environ["USER"]
DEFAULT_PATH = os.environ["PATH"]


def ws(message):
    sys.stdout.write(f"{message}\n")


def es(message):
    sys.stderr.write(f"! {message}\n")


def cd(path):
    if not os.path.exists(path):
        es(f"{path} is not exists.")
        sys.exit(-1)

    if not os.path.isdir(path):
        es(f"{path} is not directory.")
        sys.exit(-1)

    os.chdir(path)
    ws(f"cd {path}")


def sh(command, validation=True):
    ws(command)
    ret = os.system(command)
    if ret != 0 and validation:
        es(f"{command} returns {ret}")
        # sys.exit(-1)


def mksshdir():
    if not os.path.exists(f"{HOME}/.ssh"):
        sh("ssh localhost hostname", False)


def mkdir(path):
    ws(f"mkdir {path}")
    try:
        os.makedirs(path)
    except OSError:
        ws(f"-- {path} exists")


def ln(src, dest = ""):
    if dest == "":
        dest = os.path.basename(src)
    if os.path.exists(dest):
        if not os.path.islink(dest):
            es(f"{dest} already exists and is a real file")
            # sys.exit(-1)
        else:
            sh(f"rm {dest}")
    sh(f"ln -s {src} {dest}")


def write_f(path, content):
    ws(f"write to {path}")
    try:
        with open(path, "w") as f:
            f.write(content)
    except IOError as e:
        es("I/O error")
        print(e)
        sys.exit(-1)


def bash_profile():
    content = """
export DOTFILES=$HOME/dotfiles
if [ -f $DOTFILES/bash_profile ]; then
  source $DOTFILES/bash_profile
  fi
  unset USERNAME
"""
    return content


def bashrc():
    content = f"""
# export PATH={DEFAULT_PATH}

export DOTFILES=$HOME/dotfiles
if [ -f $DOTFILES/bashrc ]; then
\tsource $DOTFILES/bashrc
fi

    """
    return content


def zshrc():
    content = f"""
export LANG=ja_JP.UTF-8
# export PATH={DEFAULT_PATH}
export DOTFILES=$HOME/dotfiles
if [ -f $DOTFILES/zshrc ]
then
    source $DOTFILES/zshrc
fi
export PATH

# scpのリモートファイルを補完しない。パスワード聞かれるので。
zstyle ':completion:*:complete:scp:*:files' command command -
"""
    return content


def dot_emacs():
    content = """
(load "~/dotfiles/emacs.d/init.el")
"""
    return content


def main():
    cd(HOME)
    if len(sys.argv) == 2 and sys.argv[1] == "-a":
        # write_f(".bash_profile", bash_profile())
        # write_f(".bashrc", bashrc())
        write_f(".zshrc", zshrc())
        mkdir(".emacs.d")
        write_f(".emacs.d/init.el", dot_emacs())
        mksshdir()
        sh("cp dotfiles/ssh/config .ssh/")
        sh("cp dotfiles/ssh/authorized_keys .ssh/")
        sh("chmod 600 .ssh/config .ssh/authorized_keys")
        sh("cp dotfiles/gitconfig .gitconfig")
        # ln("%s/dotfiles/subversion/config" % HOME, ".subversion/config")
    else:
        ws("only update related files.")
        ws("try %s -a to install all" % sys.argv[0])
    sh("chmod -x `find %s/dotfiles -type f`" % HOME)
    sh("chmod +x %s/dotfiles/bin/*" % HOME)

    ln("%s/dotfiles/.gitignore" % HOME, ".gitignore")
    ln("%s/dotfiles/gemrc" % HOME, ".gemrc")
    ln("%s/dotfiles/screenrc" % HOME, ".screenrc")
    ln("%s/dotfiles/tmux.conf" % HOME, ".tmux.conf")
    ln("%s/dotfiles/inputrc" % HOME, ".inputrc")
    ln("%s/dotfiles/emacs.d/Cask" % HOME, ".emacs.d/Cask")

    mkdir("tmp")
    mkdir("proj")
    mkdir("local/src")
    mkdir("local/bin")
    mkdir("archives")

    sh("touch ~/.abbrev_defs")

    return 0


if __name__ == "__main__":
    sys.exit(main())
