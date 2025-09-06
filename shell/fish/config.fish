if status is-interactive
    # Commands to run in interactive sessions can go here
    set -gx PATH $PATH ~/.cargo/bin
    set -gx PATH $PATH ~/.local/bin
    set -gx PATH $PATH ~/env/bin
    set -gx PATH $PATH ~/env/ks_script
    set -gx PATH $PATH ~/env/usr/bin
    set -gx PATH $PATH ~/.config/helix/lsp/bin

    set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH ~/env/lib
    set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH ~/env/usr/lib

    set -gx EDITOR              micro
    set -gx CLIPBOARD_EDITOR    micro
    set -gx VISUAL              micro
    set -gx CLIPBOARD_HISTORY   10
    set -gx MICRO_TRUECOLOR     1
    set -gx SHELL               fish
    set -gx PAGER               bat -p -f
    set -gx FZF_DEFAULT_COMMAND 'fd -t f -t d -Lu -E .git'
    set -gx FZF_DEFAULT_OPTS    '-e --style=full --scheme=history --bind=ctrl-j:jump'
    # set -gx FZF_DEFAULT_OPTS    '-e --style=full --preview-window "up" --scheme=history --bind=ctrl-j:jump --preview "
    #     if test -d {};
    #         lsd -Al --config-file ~/.config/lsd.yaml --tree --depth 1 {};
    #     else
    #         bat -f --style=full {};
    #     end
    # "'
    set -gx CHEAT_USE_FZF       true

    alias fcfg   '$EDITOR ~/.config/fish/config.fish'
    alias scfg   '$EDITOR ~/.config/starship.toml'
    alias bashrc '$EDITOR ~/.bashrc'

    alias z      'cdr'
    alias mi     'micro'
    alias ff     'fastfetch'
    alias g      'git'
    alias py     'python'
    alias rp     'realpath'
    alias du     'dust'
    alias vi     'nvim'
    alias vim    'nvim'
    alias cls    'clear'
    alias where  'which'
    alias tool   'python ~/env/ks_script/tool.py'
    alias where  'which'
    alias ga_cnm 'git add . && git cnm'
    alias grd    'git rh && git clean -fd'
    alias sssh   'sudo systemctl start ssh'

    alias fd     'fd -Lu -E .git'
    alias bat    'bat -f --style=full'
    alias ls     'lsd --config-file ~/.config/lsd.yaml'
    alias ll     'ls -Al'
    alias lll    'll -L'
    alias llg    'll --git'
    alias lls    'll --total-size'
    alias llns   'll --no-symlink'
    alias lld    'fd -l -d 1'
    alias btm    'btm --config_location ~/.config/btm.toml'
    alias fzff   'realpath (fd -t f | fzf --preview-window "up" --preview "bat -f --style=full {}")'
    alias fzfd   'realpath (fd -t d | fzf --preview-window "up" --preview "lsd -Al --config-file ~/.config/lsd.yaml --tree --depth 1 {}")'
    alias fzfp   'realpath (fzf)'

    alias cd1    'cd ../'
    alias cd2    'cd ../../'
    alias cd3    'cd ../../../'

    starship init fish | source
    source ~/.venv/bin/activate.fish
end

function vscode_crash
    set -gx VSCODE_IPC_HOOK_CLI (lsof | grep $UID/vscode-ipc | awk '{print $(NF-1)}' | head -n 1)
end

alias y 'yazi'
# function y
#     set tmp (mktemp -t "yazi-cwd.XXXXXX")
#     yazi $argv --cwd-file="$tmp"
#     if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
#         builtin cd -- "$cwd"
#     end
#     rm -f -- "$tmp"
# end

function f
    set CDR_script ~/env/ks_script/cd_record.py
    # -m means multi
    if test "$argv[2]" = "z" -o "$argv[2]" = "r"
        set selected (python $CDR_script -c)
    else
        cd "$argv[2]"
        set selected (fzf -m)
    end

    if test "$argv[1]" = "cd"
        if test "$selected" != ""
            if test -d $selected
                cd $selected
            else
                cd (path dirname selected)
            end
            python $CDR_script -r
            echo "enter: $pwd"
        else
            cd -
            echo "no enter"
        end
    else
        $argv[1] $selected

        if test "$argv[2]" != "."
            cd -
        end
    end
end

function wwget
    cd ~
    wget $argv[1]
    cd -
end

function add_path
    set -gx PATH $PATH $argv[1]
end

function cdr
    set CDR_script ~/env/ks_script/cd_record.py
    set CDR_file ~/.config/cd_record.yaml

    switch $argv[1]
        case h
            echo 'Usage:'
            echo ' cdr(z)           Cd to a cd record or interactive select'
            echo ' cdr(z) $path     Normal cd && record'
            echo ' cdr(z) r         Record cwd'
            echo ' cdr(z) i         Interactive cd via fzf'
            echo ' cdr(z) gc        Do gc to cd record'
            echo ' cdr(z) l         List cd record'
            echo ' cdr(z) e         Edit cd record'
        case ""
            set dir (python $CDR_script -c)
            if test -d $dir
                cd $dir
            else
                echo $dir
            end
        case "i"
            echo -n 'Input base dir (default is cwd): '
            sleep 0.1
            set dir (python $CDR_script -i)
            if test -d $dir
                cd $dir
            else
                echo $dir
            end
        case "r"
            python $CDR_script -r
        case "gc"
            python $CDR_script -gc
        case "l"
            bat $CDR_file
        case "e"
            $EDITOR $CDR_file
        case "*"
            cd $argv[1]
            if test $status -eq 0 -a -n "$argv[1]" -a "$argv[1]" != "."
                python $CDR_script -r
            end
    end
end

function cmdh
    set CMDH_script ~/env/ks_script/cmd_history.py

    switch $argv[1]
        case "h"
            echo 'Usage:'
            echo ' cmdh       Run a history cmd'
        case "*"
            set cmd (python $CDR_script -r)
            if test $status -eq 0
                eval $cmd
            end
    end
end

function proxy_on
    set PROXY 'http://127.0.0.1:12688'
    set -gx http_proxy $PROXY
    set -gx https_proxy $PROXY
    echo "proxy on {$PROXY}"
end

function proxy_off
    set -gx http_proxy
    set -gx https_proxy
end
