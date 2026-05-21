export PATH="/home/neil/.local/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="minimal"

zstyle ':omz:update' mode disabled
zmodload zsh/zprof

plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
	copypath
	copybuffer
  sudo
)

source $ZSH/oh-my-zsh.sh

autoload -Uz add-zsh-hook
_set_beam_cursor() { echo -ne '\e[5 q' }
add-zsh-hook precmd _set_beam_cursor
add-zsh-hook preexec _set_beam_cursor


if command -v tmux &> /dev/null && [ -n "$PS1" ] && [ -z "$TMUX" ] && [[ "$TERM" != screen* ]] && [[ "$TERM" != tmux* ]]; then
  # ensure sessions exist
  tmux has-session -t spine    2>/dev/null || tmux new-session -d -s spine
  tmux has-session -t research 2>/dev/null || tmux new-session -d -s research
  # attach to main (creates if missing)
  exec tmux new-session -A -s main
fi


alias ranger="cat /home/neil/dotfiles/wal/backup/sequences && ranger"
alias ls='eza --icons --git'
alias ll='eza -l --icons --git --group-directories-first'
alias la='eza -la --icons --git --group-directories-first'
alias tree='eza --tree --icons'
alias cat='bat --paging=never --style=plain'
alias py='python3'
alias icat="kitty +kitten icat --scale-up"
alias wmc="xprop | grep WM_CLASS"
alias grep='grep -i -P'
alias vim='nvim'
alias vi='nvim'
alias setbg="feh --bg-fill"
alias cpick="colorpicker --one-shot"
alias ytaudio="$HOME/scripts/ytaudio.sh"
alias xev='~/scripts/xev.sh'
alias fileman="pcmanfm > /dev/null 2>&1"
alias nc="ncmpcpp"
alias gdl="gallery-dl"
alias rm="rm -i"
alias yt="$HOME/scripts/ycmd.sh"
alias mwin="sudo mount /data/windows"
alias hgr="history | grep -i -P"
alias up="cd .."
alias gssh="ssh-add ~/.ssh/id_ed25519"
alias fd="fd -H"
alias mpr="~/scripts/mpr"
alias c="clear"
alias pr="prime-run mpv"

mkc() {
  mkdir $1 
  cd $1 
}

cpm() {
  mkdir $1
  cd $1
  touch main.cpp
  nvim main.cpp
}

yta() {
  nohup $HOME/scripts/ytarchive.sh $1 &!
}

rea() {
  nohup $HOME/scripts/rearchive.sh $1 &!
}

mpall() {
  mpv --shuffle --image-display-duration=5 --no-loop --loop-playlist *
}

fix() {
  ~/scripts/xautostart.sh
  xmodmap ~/.Xmodmap
}

(cat {{ wal }}/sequences &)

source {{ wal }}/colors-tty.sh

export RANGER_LOAD_DEFAULT_RC=false
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export VISUAL=/usr/bin/nvim
export GIT_EDITOR="$VISUAL"
export EDITOR="$VISUAL"
export XDG_CONFIG_HOME="$HOME/.config"




# dont make eof kill term
# i just lwk accidentally hit C-d a lot
setopt IGNORE_EOF

bindkey -s '^Z' 'fg\n'

if [[ -n $SSH_CONNECTION ]] ; then
    neofetch
fi


unalias gcp
export PATH="/home/neil/scripts:$PATH"


eval "$(direnv hook zsh)"
eval "$(zoxide init zsh --cmd cd)"
eval "$(starship init zsh)"
export BAT_THEME="base16"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/neil/google-cloud-sdk/path.zsh.inc' ]; then . '/home/neil/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/neil/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/neil/google-cloud-sdk/completion.zsh.inc'; fi
