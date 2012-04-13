## PATH=$HOME/...:/usr/...:/sbin...
# export DOTFILES=$HOME/dotfiles
# if [ -f $DOTFILES/bashrc ]; then
#    source $DOTFILES/bashrc
# fi


PATH=$PATH:~/local/bin:~/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

if [ -f $DOTFILES/alias ]; then
    source $DOTFILES/alias
fi

export SVN_EDITOR='emacs -nw'

# emacs shell
if [[ $EMACS ]]; then
        PS1="[\u@\h \w]"
#       PS1="\[\033[0;36m\][\u@\h \w]\[\033[0m\]"
else
        PS1="\[\033[0;36m\][\u@\h \w]\[\033[0m\]"
fi

#PS1='\n'$PS1'\n`which gxpc >& /dev/null && gxpc prompt`% '
#PS1='\n'$PS1'\n`cat /tmp/gxp-$USER/gxpsession-* 2>/dev/null | head -1 `% '
#PS1="\n$PS1\n"'`which gxpc &> /dev/null && gxpc --verbosity 0 --daemon_bringup 0 count`\$ '
PS1='\n'$PS1'\n`which gxpc >& /dev/null && gxpc prompt 2> /dev/null`''$ '

#PS1='\n'$PS1'\n$ '
export PS1

