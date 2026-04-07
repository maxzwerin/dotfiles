autoload -U colors && colors
bindkey -e
PS1="%{$fg[magenta]%}%~%{$fg[red]%} %{$reset_color%}$%b "

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000

# Basic auto/tab complete:
autoload -U compinit && compinit
zmodload zsh/complist

_comp_options+=(globdots) # include hidden files

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

export EDITOR="nvim"
export SUDO_EDITOR="nvim"

alias ls="ls --color=auto"
alias ll="ls -la --color=auto"
alias ..='cd ..'
alias ...='cd ../../'

alias ta='tmux attach'
alias tn='tmux new -s '

alias v='nvim'
alias vi='vim'

alias startx='start-hyprland'

alias blink='bash ~/.config/scripts/blink.sh'
alias summon='bash ~/.config/scripts/tmux_summoner.sh'

MAILSYNC_MUTE=1
