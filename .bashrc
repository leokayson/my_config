# /usr/bin/bash

if [[ "$-" == *i* && "$SHELL" != "nu" ]]; then
    export SHELL = nu
    exec ~/env/usr/bin/nu
fi