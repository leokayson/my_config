# /usr/bin/bash

if [[ "$-" == *i* && "$SHELL" != "/local/mnt/workspace/kayson/env/usr/bin/fish" ]]; then
    exec ~/env/usr/bin/nu
fi