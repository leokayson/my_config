# /usr/bin/bash
export PATH=$PATH:~/.cargo/bin:~/env/bin:~/env/usr/bin
if [[ "$-" == *i* ]]; then
    fish
fi