if status is-interactive
    # Commands to run in interactive sessions can go here
    set PATH $PATH ~/env
    set PATH $PATH /env/usr/bin
    set PATH $PATH ~/.cargo/bin
    set PATH $PATH ~/scripts
    set PATH $PATH ~/env/rust/.cargo/bin
    set PATH $PATH ~/.local/bin
    set PATH $PATH /pkg/qct/software/andes/nds32le-elf-newLib-v5/bin

    alias bashrc 'code ~/.bashrc'
    alias cls 'clear'
    alias py 'python'
    alias fcfg 'code ~/.config/fish/config.fish'
    alias scfg 'code ~/.config/starship.toml'
    alias fd 'fd -I -H'
    alias ls 'lsd -T --icon-theme unicode'
    alias Ll 'ls --header --git -Al --date "+%m/%d/%Y %H:%M"'
    alias lld 'fd -l -d 1'
    alias llt 'll --total-size'
    alias cd1 'cd'
    alias cd2 'cd'
    alias cd3 'cd ../../../'
    alias pc 'python ~/scripts/tool.py -pc'
    alias btm 'btm --theme=gruvbox --config_Location ~/.config/btm.toml'

    alias ga_cnm 'git add . && git commit -m "cnm"'
    alias gc_cmd 'git commit -m "[{(date +"%m/%d %H:%M")}] sync"'
    alias grd 'git rh && git clean -fd'

    source ~/.uv_venv/bin/activate.fish
end

starship init fish | source

function vscode_crash
    set -gx VSCODE_IPC_HOOK_CLI (lsof | grep $UID/vscode-ipc | awk '{print $(NF-1)}' | head -n 1)
end

function winpath
    echo (realpath $argv | string replace -a '/local/mnt/workspace/' 'Z:/')
end