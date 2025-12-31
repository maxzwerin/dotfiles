autoload -U colors && colors
bindkey -e
PS1="%{$fg[magenta]%}%~%{$fg[red]%} %{$reset_color%}$%b "

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000

finder() {
    open .
}
zle -N finder
bindkey '^f' finder

# Basic auto/tab complete:
autoload -U compinit && compinit
autoload -U colors && colors
zmodload zsh/complist

_comp_options+=(globdots) # include hidden files

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

export EDITOR="nvim"

#alias ls="ls -lah"
alias ..='cd ..'
alias ...='cd ../../'

alias ta='tmux attach'

alias v='nvim'

alias blink='bash ~/.config/scripts/blink.sh'

MAILSYNC_MUTE=1
