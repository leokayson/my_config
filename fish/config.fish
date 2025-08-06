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

    set -gx EDITOR              nvim
    set -gx CLIPBOARD_EDITOR    nvim
    set -gx CLIPBOARD_HISTORY   10
    set -gx VISUAL              nvim
    set -gx SHELL               fish
    set -gx FZF_DEFAULT_COMMAND 'fd -t f -t d'
    set -gx FZF_DEFAULT_OPTS    '-e --style=full --preview "bat {}" --preview-window "up" --scheme=history --bind=ctrl-j:jump'
    set -gx CHEAT_USE_FZF       true

    alias fcfg   '$EDITOR ~/.config/fish/config.fish'
    alias scfg   '$EDITOR ~/.config/starship.toml'
    alias bashrc '$EDITOR ~/.bashrc'

    alias c      'cdr'
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

    alias fd     'fd -HIL --exclude .git'
    alias bat    'bat -f'
    alias ls     'lsd --config-file ~/.config/lsd.yaml'
    alias ll     'ls -Al'
    alias lll    'll -L'
    alias llg    'll --git'
    alias lls    'll --total-size'
    alias llns   'll --no-symlink'
    alias lld    'fd -l -d 1'
    alias btm    'btm --config_location ~/.config/btm.toml'
    alias fzff   'fd -t f | fzf'
    alias fzfd   'fd -t d | fzf'
    alias fzfp   'fzfd | path expand'

    alias cd1    'cd ../'
    alias cd2    'cd ../../'
    alias cd3    'cd ../../../'

    source ~/.venv/bin/activate.fish
    starship init fish | source
end

function vscode_crash
    set -gx VSCODE_IPC_HOOK_CLI (lsof | grep $UID/vscode-ipc | awk '{print $(NF-1)}' | head -n 1)
end

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

function f
    cd "$argv[2]"
    set selected (fzf)

    switch $argv[1]
        case cd
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
        case code
            if test "$selected" != ""
                code $selected
            end
            cd -
        case coder
            if test "$selected" != ""
                code -r $selected
            end
            cd -
        case nvim
            if test "$selected" != ""
                nvim $selected
            end
            cd -
        case hx
            if test "$selected" != ""
                hx $selected
            end
            cd -
        case "*"
            echo "no this cmd: $argv[1]"
    end
end

function wwget
    cd ~
    wget $argv[1]
    cd -
end

# Deprecated
function cdb
    set BK_script ~/env/ks_script/shell_bookmarks.py

    switch $argv[1]
        case h
            echo 'Usage:'
            echo ' cdb           Cd to a dir bookmark'
            echo ' cdb a         Add a dir bookmark'
            echo ' cdb d         Delete a dir bookmark'
            echo ' cdb D         Delete all dir bookmarkds'
            echo ' cdb l         List all dir bookmarkds'
            echo ' cdb e         Edit the dir bookmarkds'
        case a
            python $BK_script -a
        case d
            python $BK_script -d
        case D
            python $BK_script -D
        case l
            python $BK_script -l
        case e
            $EDITOR ~/.config/cb_bookmarks.log
        case "*"
            set dir (python $BK_script -c)
            if test -d $dir
                cd $dir
            else
                echo $dir
            end
    end
end

function cdr
    set CDR_script ~/env/ks_script/cd_record.py

    switch $argv[1]
        case h
            echo 'Usage:'
            echo ' cdr(c)           Normal cd && record'
            echo ' cdr(c) c         Cd to a cd record'
            echo ' cdr(c) gc        Do gc to cd record'
            echo ' cdr(c) l         List cd record'
        case l
            python $CDR_script -l
        case gc
            python $CDR_script -gc
        case c
            set dir (python $CDR_script -c)
            if test -d $dir
                cd $dir
            else
                echo $dir
            end
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
