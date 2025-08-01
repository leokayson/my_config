if status is-interactive
    # Commands to run in interactive sessions can go here
    set PATH -gx $PATH ~/.cargo/bin
    set PATH -gx $PATH ~/.local/bin
    set PATH -gx $PATH ~/env/bin
    set PATH -gx $PATH ~/env/script
    set PATH -gx $PATH ~/env/usr/bin
    set PATH -gx $PATH ~/.config/helix/lsp/bin

    set -gx LD_LIBRARY_PATH  $LD_LIBRARY_PATH ~/env/lib
    set -gx LD_LIBRARY_PATH  $LD_LIBRARY_PATH ~/env/lib

    set -gx EDITOR                 'hx'
    set -gx CLIPBOARD_EDITOR       'hx'
    set -gx CLIPBOARD_HISTORY      10
    set -gx VISUAL                 'hx'
    set -gx PAGER                  'bat'
    set -gx SHELL                  'fish'

    alias fcfg    'code ~/.config/fish/config.fish'
    alias scfg    'code ~/.config/starship.toml'

    alias py      'python'
    alias g       'git'
    alias z       'zoxide'
    alias rp      'realpath'
    alias du      'dust'
    alias vi      'nvim'
    alias vim     'nvim'
    alias cls     'clear'
    alias where   'which'
    alias tool    'python ~/env/ks_script/tool.py'
    alias where   'which'
    alias ga_cnm  'git add . && git cnm'
    alias grd     'git rh . && git clean -fd'
    alias sssh    'sudo systemctl start ssh'

    alias fd      'fd -I -H'
    alias bat     'bat -f'
    alias ls      'lsd --config-file ~/.config/lsd.yaml'
    alias ll      'ls -Al'
    alias lll     'll -L'
    alias llg     'll --git'
    alias lls     'll --total-size'
    alias llns    'll --no-symlink'
    alias lld     'fd -l -d 1'
    alias btm     'btm --config_location ~/.config/btm.toml'
    alias fzf     'fzf -e --style=full --preview "bat {}" --preview-window "up" --scheme=history'
    alias fzfa    'fzf --walker=dir,file,hidden,follow'
    alias fzfd    'fzf --walker=dir,hidden,follow'
    alias fzfp    'fzfe | path expand'

    alias cd1     'cd ../'
    alias cd2     'cd ../../'
    alias cd3     'cd ../../../'

    source ~/.venv/bin/activate.fish
    zoxide init fish | source
    starship init fish | source
end

function vscode_crash
    set -gx VSCODE_IPC_HOOK_CLI (lsof | grep $UID/vscode-ipc | awk '{print $(NF-1)}' | head -n 1)
end

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

function f
    cd "$argv[2]"
    set selected (fzfe --walker=dir,file,hidden,follow)
    
    if test $argv[1] = "cd" 
        if test "$selected" != ""
            if test -d $selected
                cd $selected
            else 
                cd (path dirname selected)
            end
            echo "enter: $pwd"
        else
            cd -
            echo "no enter"
        end
    else if test $argv[1] = "code"
        if test "$selected" != ""
            code $selected
        end
        cd -
    else if test $argv[1] = "nvim"
        if test "$selected" != ""
            nvim $selected
        end
        cd -
    else if test $argv[1] = "hx"
        if test "$selected" != ""
            hx $selected
        end
        cd -
    else
        echo "no this cmd: $argv[1]"
    end 
end

function wwget
    cd ~
    wget $argv[1]
    cd -
end

function add_apth
    set -gx PATH %PATH $argv[1]
end

function remove_apth
    set -gx PATH (string match -v /usr/local/bin $PATH)
end
