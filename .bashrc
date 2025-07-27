# /usr/bin/bash

export PATH=$PATH:~/env/usr/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/env/usr/lib
export CLIPBOARD_EDITOR=nvim
export CLIPBOARD_HISTORY=50
export PATH=$PATH:~/env
export PATH=$PATH:~/.cargo/bin
export PATH=$PATH:~/.local/bin
# export PATH=$PATH:~/tool/script

alias f='fish'

if [[ "$-" == *i* && "$SHELL" != "/local/mnt/workspace/kayson/env/usr/bin/fish" ]]; then
    exec fish
fi