PATH=~/local/bin:~/bin:~/dotfiles/tools:$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# set PROMPT, RPROMPT
autoload -U colors
colors
setopt prompt_subst

case ${UID} in
0)
        PROMPT="%B%{${fg[red]}%}%n@%m %/#%{${reset_color}%}%b "
        PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
        SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
        ;;
*)
        # color is (exit code of previous command ? red : cyan)
        PROMPT="%{%(?.${fg[cyan]}.${fg[red]})%}[%n@%m]%{${reset_color}%}$ "
        RPROMPT="%{${fg[cyan]}%}%~%{${reset_color}%}"
        PROMPT2="%{${fg[cyan]}%}%_%%%{${reset_color}%} "
        SPROMPT="%{${fg[cyan]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
        ;;
esac

# terminal
unset LSCOLORS
case "${TERM}" in
dumb*|emacs*)
  PROMPT="[%n@%m %~]$ "
  PROMPT2="%_%% "
  SPROMPT="%r is correct? [n,y,a,e]: "
  ;;
# xterm)
  # export TERM=xterm-color
  # ;;
kterm)
  export TERM=kterm-color
  # set BackSpace control character
  stty erase
  ;;
cons25)
  unset LANG
  export LSCOLORS=ExFxCxdxBxegedabagacad
  export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30'
  zstyle ':completion:*' list-colors \
      'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
  ;;
esac

case "${TERM}" in
kterm*|xterm*)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
  }
  export LSCOLORS=exfxcxdxbxegedabagacad
  export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30'
  zstyle ':completion:*' list-colors \
    'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
  ;;
esac



# cd
setopt auto_cd
function chpwd(){ls -F --color=tty}
#by cd -[tab]
setopt auto_pushd

# autocorrect
setopt correct
setopt list_packed
setopt noautoremoveslash
setopt noautoremoveslash

# keybind emacs
bindkey -e
bindkey -e "^[h" backward-kill-word

#string binded to ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end


# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data

# completion
fpath=(~/.zsh/functions/Completion ${fpath})
autoload -U compinit && compinit

autoload -U +X bashcompinit && bashcompinit
[[ -f ~/local/lib/azure-cli/az.completion ]] && source ~/local/lib/azure-cli/az.completion

autoload zed

setopt complete_aliases # aliased ls needs if file/dir completions work

# hosts in .ssh/config will be completion candidates.
hosts=( ${(@)${${(M)${(s:# :)${(zj:# :)${(Lf)"$([[ -f ~/.ssh/config ]] && < ~/.ssh/config)"}%%\#*}}##host(|name) *}#host(|name) }/\*} )
zstyle ':completion:*:hosts' hosts $hosts
## do not complete remote files at scp.
zstyle ':completion:*:complete:scp:*:files' command command -

alias where="command -v"
alias j="jobs -l"

setopt NO_BEEP
setopt RC_EXPAND_PARAM


## keep background processes at full speed
#setopt NOBGNICE
## restart running processes on exit
#setopt HUP

## automatically decide when to page a list of completions
#LISTMAX=0

## disable mail checking
#MAILCHECK=0

# ssh agent
if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval "$(ssh-agent -s)"
    ssh-add -k ~/.ssh/id_rsa
fi


[[ -f ${DOTFILES}/alias ]] && source ${DOTFILES}/alias
[[ -f ${DOTFILES}/devrc ]] && source ${DOTFILES}/devrc
[[ -f /etc/proxyrc ]] && source /etc/proxyrc
[[ -f ~/.proxyrc ]] && source ~/.proxyrc

## mkfly is not for me.
# mcfly_sh_path=$(find ~/.cargo -name mcfly.zsh)
# [[ ! -z "${mcfly_sh_path}" ]] && source "${mcfly_sh_path}"

if which peco 1> /dev/null 2> /dev/null ; then
    alias peco="peco --layout=bottom-up"
    #############################
    # ctrl-r command history.
    function peco-history-selection() {
        BUFFER=`history -n 1 | tac  | awk '!a[$0]++' | peco`
        CURSOR=$#BUFFER
        zle reset-prompt
    }

    zle -N peco-history-selection
    bindkey '^R' peco-history-selection

    #############################
    # ctrl-u cdr with peco

    # cdr
    if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
        autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
        add-zsh-hook chpwd chpwd_recent_dirs
        zstyle ':completion:*' recent-dirs-insert both
        zstyle ':chpwd:*' recent-dirs-default true
        zstyle ':chpwd:*' recent-dirs-max 1000
        zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
    fi

    # search a destination from cdr list
    function peco-get-destination-from-cdr() {
        # cdr -l | sort -r | \
        cdr -l | \
            sed -e 's/^[[:digit:]]*[[:blank:]]*//' | \
            peco --layout=bottom-up --query "$LBUFFER"
    }

    function peco-cdr () {
        local destination="$(peco-get-destination-from-cdr)"
        if [ -n "$destination" ]; then
            BUFFER="cd $destination"
            zle accept-line
        else
            zle reset-prompt
        fi
    }
    zle -N peco-cdr
    bindkey '^u' peco-cdr

    #############################
    # others

    # docker exec /bin/bash
    alias de='docker exec -it $(docker ps | peco | cut -d " " -f 1) /bin/bash'
fi
