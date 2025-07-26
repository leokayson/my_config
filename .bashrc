# /usr/bin/bash
stty erase ^?
export HOME=/local/mnt/workspace/kayson
export P4CONFIG=.p4config
export PATH=$PATH:~/env/usr/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/env/usr/lib
export CLIPBOARD_THEME=help=r;g;b,info=r;g;b,error=r;g;b,success=r;g;b,progress=r;g;b
export CLIPBOARD_EDITOR=nvim
export CLIPBOARD_HISTORY=50
export PATH=$PATH:~/env
export PATH=$PATH:~/.cargo/bin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/tool/script

alias f='fish'

source "~/.cargo/env"

if [[ "$-" == *i* && "$SHELL" != "/local/mnt/workspace/kayson/env/usr/bin/fish" ]]; then
    exec fish
fi