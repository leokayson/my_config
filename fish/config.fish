if status is-interactive
    # Commands to run in interactive sessions can go here
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

    # source ~/.uv_venv/bin/activate.fish
end

starship init fish | source
# zoxide init fish | source

function vscode_crash
    set -gx VSCODE_IPC_HOOK_CLI (lsof | grep $UID/vscode-ipc | awk '{print $(NF-1)}' | head -n 1)
end

function winpath
    echo (realpath $argv | string replace -a '/local/mnt/workspace/' 'Z:/')
end

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

function cdh
    cd ~
    set selected (fzf --walker=dir,hidden) 
    
    if [ -n "$selected" ] 
        cd "$selected" 
        echo "enter: $PWD" 
    else
        cd - 
        echo "no enter" 
    end 
end 

function cdc
    set selected (fzf --walker=dir,hidden) 
    
    if [ -n "$selected" ] 
        cd "$selected" 
        echo "enter: $PWD" 
    else 
        echo "no enter" 
    end 
end 

function codeh 
    cd ~
    set selected (fzf --walker=file,dir,hidden) 
    if [ -n "$selected" ] 
        code "$selected" 
    else
        cd -
    end 
end

function codec 
    set selected (fzf --walker=file,dir,hidden) 
    if [ -n "$selected" ] 
        code "$selected" 
    end 
end

function coder
    cd ~
    set selected (fzf --walker=file,dir,hidden) 
    if [ -n "$selected" ] 
        code -r "$selected" 
    else
        cd -
    end 
end

function nvimf 
    cd ~
    set selected (fzf --walker=file,dir,hidden) 
    if [ -n "$selected" ] 
        nvim "$selected" 
    else
        cd -
    end 
end

function nvimc
    set selected (fzf --walker=file,dir,hidden) 
    if [ -n "$selected" ] 
        nvim "$selected" 
    end 
end
