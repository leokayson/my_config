if status is-interactive
    # Commands to run in interactive sessions can go here
    set PATH $PATH ~/env
    set PATH $PATH /env/usr/bin
    set PATH $PATH ~/.cargo/bin
    set PATH $PATH ~/tool/scripts/bin
    set PATH $PATH ~/env/rust/.cargo/bin
    set PATH $PATH ~/.local/bin


    alias bashrc 'code ~/.bashrc'
    alias fcfg   'code ~/.config/fish/config.fish'
    alias scfg   'code ~/.config/starship.toml'
    alias cls    'clear'
    alias py     'python'
    alias y      'yazi'
    alias fd     'fd -I -H'
    alias ls     'lsd -T --icon-theme unicode'
    alias ll     'ls --header --git -Al --date relative'
    alias lld    'fd -l -d 1'
    alias llt    'll --total-size'
    alias cd1    'cd ../'
    alias cd2    'cd ../../'
    alias cd3    'cd ../../../'
    alias pc     '~/tool/scripts/bin/tool -pc'
    alias btm    'btm --theme=gruvbox --config_Location ~/.config/btm.toml'

    alias ga_cnm 'git add . && git cnm'
    alias gc_cmd 'git commit -m "[{(date +"%m/%d %H:%M")}] sync"'
    alias grd    'git rh && git clean -fd'

    source ~/.uv_venv/bin/activate.fish
end

starship init fish | source
zoxide init fish | source

function vscode_crash
    set -gx VSCODE_IPC_HOOK_CLI (lsof | grep $UID/vscode-ipc | awk '{print $(NF-1)}' | head -n 1)
end

function winpath
    echo (realpath $argv | string replace -a '/local/mnt/workspace/' 'Z:/')
end