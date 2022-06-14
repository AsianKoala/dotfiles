#!/usr/bin/env bash

# set path for local binaries
BINPATH=$HOME/.local/bin
mkdir -p "$BINPATH"

# make 'vis' executable
chmod u+x ./vis

# link the script to PATH
ln -s "$(pwd)/vis" "$BINPATH/vis"

# simple scripts to set 'pywal' colorscheme as new default
#   use 'c' in vis window to cycle between previous colorschemes
new_c_scheme() {
    old_c_scheme=$(grep "colors.scheme=" $1)
    echo "$old_c_scheme" | awk -F= '{printf "%s=pywal,", $1}' 
    echo "$old_c_scheme" | awk -F= '{printf "%s\n", $2}'
}
overwrite_old_config() {
    c=$(new_c_scheme "$1")
    sed -i "/colors.scheme=/c $c" $1 
}

[ -f $XDG_CONFIG_HOME/vis/config ] && overwrite_old_config "$XDG_CONFIG_HOME/vis/config" || \
    [ -f $HOME/.config/vis/config ] && overwrite_old_config "$HOME/.config/vis/config"

cat <<EOM
Installed to "$BINPATH"
Make sure "$BINPATH" is in your PATH
You can do this by adding the following line to your bashrc/zshrc
    export PATH="$BINPATH:\$PATH"
EOM
