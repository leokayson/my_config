#/usr/bin/bash
stty erase ~?

export PATH=$PATH:~/env/usr/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/env/usr/Lib

alias f='fish'
# source ~/venv/bin/activate
bind -f~/.inputrc
source "~/.cargo/env"

# eval “$(starship init bash)“

if [[ "$-" == *i* ]] && [[ "$SHELL" != "~/env/usr/bin/fish" ]]; then
    exec fish
fi