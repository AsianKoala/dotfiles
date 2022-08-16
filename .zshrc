export PATH="/home/neil/.local/bin:$PATH"

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


alias ranger="cat /home/neil/.cache/wal/sequences && ranger"
alias ls='exa --icons'
alias la='ls -a'
alias ld='ls -D'
alias lt='exa -T --icons'
alias py='python3'
alias icat="kitty +kitten icat --scale-up"
alias wmc="xprop | grep WM_CLASS"
alias grep='grep -i'
alias vim='nvim'
alias vi='nvim'
alias setbg="feh --bg-fill"
alias cpick="colorpicker --one-shot"
alias ytaudio="yt-dlp -f 'ba' -x --no-playlist"
alias ytplaylist="yt-dlp -f 'ba' -x"
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias bonsai='cbonsai -liw 10 -m "こんばんは ニール！"'
alias matrix='unimatrix -s 96 -l k -c magenta'
alias xev='~/scripts/xev.sh'
alias configrm="config rm --cached -rf"

function mkc() {
  mkdir $1 
  cd $1 
}

(cat $HOME/.cache/wal/sequences &)

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
# export GTK_IM_MODULE=fcitx
# export QT_IM_MODULE=fcitx
# export XMODIFIERS=@im=fcitx
# export GTK_IM_MODULE=fcitx
# export XMODIFIERS=@im=fcitx
# export QT_IM_MODULE=fcitx

# sunglasses emoji (x2)
if [[ -n $SSH_CONNECTION ]] ; then
    neofetch
fi
