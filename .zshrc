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
# alias ytaudio="yt-dlp -f 'ba' -x --no-playlist"
alias ytaudio="$HOME/scripts/ytaudio.sh"
alias ytplaylist="yt-dlp -f 'ba' -x"
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias bonsai='cbonsai -liw 10 -m "こんばんは ニール！"'
alias matrix='unimatrix -s 96 -l k -c magenta'
alias xev='~/scripts/xev.sh'
alias configrm="config rm --cached -rf"
alias osuskin="$HOME/scripts/osuskin.sh"
alias fileman="pcmanfm > /dev/null 2>&1"
alias hss="hugo server --noHTTPCache"
alias nc="ncmpcpp"
alias notes="nvim main.tex"
alias ys="yay -Q | grep"
alias ost="cosu-trainer auto"
alias gdl="gallery-dl"
alias rm="rm -i"
alias yt="$HOME/scripts/yt.sh"
alias ks="py $HOME/documents/projects/ksfancam-archiver/main.py"
alias svim="sudo -e"
alias dcx="py $HOME/scripts/dcx.py"
alias mwin="sudo mount /data/windows"
alias cddq="cd ~/documents/projects/deepquarry/backend/ && source ~/documents/projects/deepquarry/backend/.venv/bin/activate"
alias xauto="~/scripts/xautostart.sh"
alias resetswap="sudo swapoff -a && sudo swapon -a"
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

fay() {
	packages=$(awk {'print $1'} <<< $(yay -Ss $1 | awk 'NR%2 {printf "\033[1;32m%s \033[0;36m%s\033[0m — ",$1,$2;next;}{ print substr($0, 5, length($0) - 4); }' | fzf -m --ansi))
	[ "$packages" ] && yay -S $(echo "$packages" | tr "\n" " ")
}

pay()  {
  yay -Slq | fzf -m --preview $'(cat (yay -Si "{1}") (yay -Fl {1} | awk \"{print \$2}\" )' | xargs -ro yay -S
}

imgurdl() {
  nohup /home/neil/documents/projects/cache-archiver/.venv/bin/python3 main.py $1 > /home/neil/documents/projects/cache-archiver/app/scrapers/logfiles/$1 &
}

gdlsub() {
  gallery-dl --no-download -j https://www.reddit.com/r/$1 > $1
}

yt-cache-dl() {
  python3 $HOME/documents/projects/yt-cache-dl/main.py $1
}

nohup-audio() {
  nohup $HOME/scripts/ytaudio.sh $1 &!
}

nohupyt() {
  nohup $HOME/scripts/yt.sh $1 &!
}

yta() {
  nohup $HOME/scripts/ytarchive.sh $1 &!
}

rea() {
  nohup $HOME/scripts/rearchive.sh $1 &!
}

merge() {
  rsync -rhavzP --ignore-existing $1 $2
}

(cat $HOME/.cache/wal/sequences &)

source $HOME/.cache/wal/colors-tty.sh

export RANGER_LOAD_DEFAULT_RC=false
# export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
# export PATH="$PATH:$GEM_HOME/bin"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export VISUAL=/usr/bin/nvim
export GIT_EDITOR="$VISUAL"
export EDITOR="$VISUAL"
export PATH=$PATH:/opt/gradle/gradle-7.4.2/bin
export XDG_CONFIG_HOME="$HOME/.config"
export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolkit
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk"
export PATH=$JAVA_HOME/bin:$PATH
export OSU_SONG_FOLDER=/home/neil/games/osu/Songs

source $HOME/.rvm/scripts/rvm

bindkey -s '^Z' 'fg\n'

# sunglasses emoji (x2)
if [[ -n $SSH_CONNECTION ]] ; then
    neofetch
fi


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
