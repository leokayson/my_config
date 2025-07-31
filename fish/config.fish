if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_add_path '~/.cargo/bin'
    fish_add_path '~/.local/bin'
    fish_add_path '~/env/bin'
    fish_add_path '~/env/script'
    fish_add_path '~/env/usr/bin'

    set LD_LIBRARY_PATH  '$LD_LIBRARY_PATH ~/env/lib'
    set LD_LIBRARY_PATH  '$LD_LIBRARY_PATH ~/env/lib'

    set EDITOR                 'hx'
    set CLIPBOARD_EDITOR       'hx'
    set CLIPBOARD_HISTORY      10
    set VISUAL                 'hx'
    set PAGER                  'bat'
    set SHELL                  'fish'

    alias fcfg    'code ~/.config/fish/config.fish'
    alias scfg    'code ~/.config/starship.toml'

    alias py      'python'
    alias g       'git'
    alias vi      'nvim'
    alias vim     'nvim'
    alias tool    'python ~/env/script/tool.py'
    alias where   'which'
    alias ga_cnm  'git add . && git cnm'
    alias grd     'git rh . && git clean -fd'

    alias fd      'fd -I -H'
    alias ls      'lsd --config-file ~/.config/lsd.yaml'
    alias ll      'ls -Al'
    alias llt     'll --total-size'
    alias llns    'll --no-symlink'
    alias lld     'fd -l -d 1'
    alias btm     'btm --config_location ~/.config/btm.toml'
    alias fzff    'fzf --style=full --preview "bat --color=always {}"" --preview-window "up"'
    alias fzf     'fzff -e'
    alias fzfp    'fzf | path expand'

    alias cd1     'cd ../'
    alias cd2     'cd ../../'
    alias cd3     'cd ../../../'
        
    source ~/.venv/bin/activate.fish
end

starship init fish | source

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

function z
    cd "$argv[2]"
    set selected (fzf --walker=dir,file,hidden)
    
    if test $argv[1] = "cd" 
        if $selected != ""
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
        if $selected != ""
            code $selected
        else
            cd -
        end
    else if test $argv[1] = "nvim"
        if $selected != ""
            nvim $selected
        else
            cd -
        end
    else
        echo "no this cmd: $argv[1]"
    end 
end

function wwget
    cd ~
    wget $argv[1]
    cd -
end