export PATH="/home/neil/.local/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"

#ZSH_THEME="powerlevel10k/powerlevel10k"
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


alias ranger="cat /home/neil/.cache/wal/sequences && ranger"
alias ls='exa --icons'
alias py='python3'
alias icat="kitty +kitten icat --scale-up"
alias wmc="xprop | grep WM_CLASS"
alias grep='grep -i'
alias vim='nvim'
alias vi='nvim'
alias setbg="feh --bg-fill"
alias cpick="colorpicker --one-shot"
# alias ytaudio="yt-dlp -f 'ba' -x --no-playlist"
alias ytaudio="$HOME/scripts/ytaudio.sh"
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias bonsai='cbonsai -liw 10 -m "こんばんは ニール！"'
alias xev='~/scripts/xev.sh'
alias configrm="config rm --cached -rf"
alias fileman="pcmanfm > /dev/null 2>&1"
alias nc="ncmpcpp"
alias gdl="gallery-dl"
alias rm="rm -i"
alias yt="$HOME/scripts/yt.sh"
alias mwin="sudo mount /data/windows"
alias hgr="history | grep"
alias up="cd .."

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

(cat $HOME/.cache/wal/sequences &)

source $HOME/.cache/wal/colors-tty.sh

export RANGER_LOAD_DEFAULT_RC=false
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export VISUAL=/usr/bin/nvim
export GIT_EDITOR="$VISUAL"
export EDITOR="$VISUAL"
export XDG_CONFIG_HOME="$HOME/.config"
export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolkit
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk"
export PATH=$JAVA_HOME/bin:$PATH
export OSU_SONG_FOLDER=/home/neil/games/osu/Songs

source $HOME/.rvm/scripts/rvm

bindkey -s '^Z' 'fg\n'

if [[ -n $SSH_CONNECTION ]] ; then
    neofetch
fi


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
