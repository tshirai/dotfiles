PATH=$PATH:~/local/bin:~/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
PATH=~/.rbenv/bin:$PATH

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
autoload -U compinit
compinit

autoload zed

setopt complete_aliases # aliased ls needs if file/dir completions work

# hosts in .ssh/config will be completion candidates.
hosts=( ${(@)${${(M)${(s:# :)${(zj:# :)${(Lf)"$([[ -f ~/.ssh/config ]] && < ~/.ssh/config)"}%%\#*}}##host(|name) *}#host(|name) }/\*} )
zstyle ':completion:*:hosts' hosts $hosts
## do not complete remote files at scp.
#zstyle ':completion:*:complete:scp:*:files' command command -



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

[[ -f ${DOTFILES}/alias ]] && source ${DOTFILES}/alias
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[[ -f ~/.proxyrc ]] && source ~/.proxyrc
