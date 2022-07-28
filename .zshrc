
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/home/neil/.local/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

#ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_THEME="minimal"

zstyle ':omz:update' mode disabled

plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
	copypath
	copybuffer
  sudo
)

source $ZSH/oh-my-zsh.sh




xset r rate 240 60

alias ranger="cat /home/neil/.cache/wal/sequences && ranger"
alias ls='exa --icons'
alias la='ls -a'
alias ld='ls -D'
alias lt='exa -T --icons'
alias py='python3'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias bonsai='cbonsai -liw 10 -m "こんばんは ニール！"'
alias matrix='unimatrix -s 96 -l k -c magenta'
alias ytaudio="yt-dlp -f 'ba' -x"
alias setbg="feh --no-fehbg --bg-fill"
alias cpick="colorpicker --one-shot"
alias icat="kitty +kitten icat --scale-up"
alias wmc="xprop | grep WM_CLASS"
alias grep='grep -i'

# sunglasses emoji
alias vim='nvim'
alias vi='nvim'

# useless since i fixed ranger but whatever
function jasmr() {
  jasmrpath='/home/neil/pictures/anime/nsfw/degen/dlsite rips/'$1'.mp3'
  mpv --no-video $jasmrpath
}

function mkc() {
  mkdir $1 
  cd $1 
}



(cat $HOME/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
#cat $HOME/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
source $HOME/.cache/wal/colors-tty.sh

export RANGER_LOAD_DEFAULT_RC=false
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export EDITOR=/usr/bin/nvim
export PATH=$PATH:/opt/gradle/gradle-7.4.2/bin
export XDG_CONFIG_HOME="$HOME/.config"
export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolkit


# sunglasses emoji (x2)
if [[ -n $SSH_CONNECTION ]] ; then
    neofetch
fi
