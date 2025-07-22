# /usr/bin/bash
stty erase ^?
export HOME=/local/mnt/workspace/kayson
export P4CONFIG=.p4config
export PATH=$PATH:~/env/usr/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/env/usr/lib
alias f='fish'

source "~/.cargo/env"

if [[ "$-" == *i* && "$SHELL" != "/local/mnt/workspace/kayson/env/usr/bin/fish" ]]; then
    exec fish
fi