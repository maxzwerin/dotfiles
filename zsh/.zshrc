autoload -U colors && colors
bindkey -e
PS1="%{$fg[magenta]%}%~%{$fg[red]%} %{$reset_color%}$%b "

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
source <(fzf --zsh)

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

export PATH="/Users/maxzwerin/.local/share/bob/nvim-bin/:$PATH"
export PATH="/Users/maxzwerin/Library/Python/3.9/bin/:$PATH"

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

export EDITOR="nvim"

alias love="/Applications/love.app/Contents/MacOS/love"
alias venv="source .venv/bin/activate"

alias ll="ls -lah"
alias ..='cd ..'
alias ...='cd ../../'

alias v='nvim'
export NVIM_NIGHTLY_DIR="$HOME/.local/share/nvim/nightly"
alias nvn="$NVIM_NIGHTLY_DIR/nvim-nightly.sh"

export MANPAGER="nvim +Man!"
alias rip="yt-dlp -x --audio-format=\"mp3\""

# edit command line
autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line


MAILSYNC_MUTE=1
