# config.nu
# 
# Installed by:
# version = "0.106.0"
# 
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks. 
# See https://www.nushell.sh/book/configuration.html
# 
# Nushell sets "sensible defaults" for most configuration settings,
# so your `config.nu` only needs to override these defaults if desired.
# 
# You can open this file in your default editor using: 
#     config nu
# 
# You can also pretty-print and page through the documentation for configuration
# options using: 
#     config nu --doc | nu-highlight | less -R


# ========================= Env + PATH =========================
source $"($nu.default-config-dir)/starship.nu"
source $"($nu.default-config-dir)/custom-completions/apt/apt.nu"
source $"($nu.default-config-dir)/custom-completions/bat/bat-completions.nu"
source $"($nu.default-config-dir)/custom-completions/cargo/cargo-completions.nu"
source $"($nu.default-config-dir)/custom-completions/curl/curl-completions.nu"
source $"($nu.default-config-dir)/custom-completions/git/git-completions.nu"
source $"($nu.default-config-dir)/custom-completions/make/make-completions.nu"
source $"($nu.default-config-dir)/custom-completions/rg/rg-completions.nu"
source $"($nu.default-config-dir)/custom-completions/rustup/rustup-completions.nu"
source $"($nu.default-config-dir)/custom-completions/ssh/ssh-completions.nu"
source $"($nu.default-config-dir)/custom-completions/uv/uv-completions.nu"
source $"($nu.default-config-dir)/custom-completions/vscode/vscode-completions.nu"
source $"($nu.default-config-dir)/themes/catppuccin_latte.nu"

# ========================= Alias =========================
alias ncfg   = code $"($env.HOME)/.config/nushell/config.nu"
alias nenv   = code $"($env.HOME)/.config/nushell/env.nu"
alias scfg   = code $"($env.HOME)/.config/starship.toml"

alias py     = python
alias g      = git
alias vi     = nvim
alias vim    = nvim
alias tool   = python ~/env/ks_script/tool.py
alias pc     = python ~/env/ks_script/tool.py -pc
alias where  = which

alias fd     = fd -I -H
alias ls     = lsd --config-file ~/.config/lsd.yaml
alias ll     = ls -Al
alias lll    = ll -L
alias llt    = ll --total-size
alias llns   = ll --no-symlink
alias lld    = fd -l -d 1
alias btm    = btm --config_location ~/.config/btm.toml
alias fzff   = fzf --style=full --preview 'bat --color=always {}' --preview-window 'up'
alias fzf    = fzff -e
alias fzfp   = fzf | path expand

alias cd1    = cd ../
alias cd2    = cd ../../
alias cd3    = cd ../../../

def ga_cnm [] {
    git add .
    git cnm
}  
    
def grd [] {
    git rh
    git clean -fd
}

# ========================= Function  =========================
def ncd [path: string] {
    code ($path | path expand)
}

def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

def --env f [cmd: string, path: string] {
    cd $"($path)"
    let selected = (fzf --walker=dir,file,hidden)
    
    if ( $cmd == "cd" ) {
        if ( $selected != "" ) {
            if ( (($selected) | path type) == 'dir') {
                cd $"($selected)"
            } else {
                cd $"(($selected) | path dirname)"
            }
            echo $"enter: (pwd)"
        } else {
            cd -
            echo no enter
        }
    } else if ( $cmd == "code" ) {
        if ( $selected != "" ) {
            code $"($selected)"
        } 
        cd -
    } else if ( $cmd == "coder" ) {
        if ( $selected != "" ) {
            code -r $"($selected)"
        } 
        cd -
    } else if ( $cmd == "nvim" ) {
        if ( $selected != "" ) {
            nvim $"($selected)"
        }
        cd -
    } else if ( $cmd == "hx" ) {
        if ( $selected != "" ) {
            hx $"($selected)"
        }
        cd -
    } else {
        echo $"no such cmd: ($cmd)"
    }
}

def --env add_path [path: string] {
    $env.PATH = $env.PATH | append $path
}

def --env cdb [cmd : string] {
    let BK_script = $'($env.HOME)/env/ks_script/shell_bookmarks.py'

    if ( $cmd == "h" ) {
        echo 'Usage:'
        echo ' cdb           Cd to a dir bookmark'
        echo ' cdb a         Add a dir bookmark'
        echo ' cdb d         Delete a dir bookmark'
        echo ' cdb D         Delete all dir bookmarkds'
        echo ' cdb l         List all dir bookmarkds'
        echo ' cdb e         Edit the dir bookmarkds'
        echo ' cdb cmd       Run a history cmd'
    } else if ( $cmd == "a") {
        python $BK_script -a
    } else if ( $cmd  == "d" ) {
        python $BK_script -d
    } else if ( $cmd  == "D" ) {
        python $BK_script -D
    } else if ( $cmd  == "l" ) {
        python $BK_script -l
    } else if ( $cmd  == "e" ) {
        nvim $'($env.HOME)/.config/cb_bookmarks.log'
    } else if ( $cmd == "cmd") {
        let cmd = (python $BK_script -cmd)
        eval $cmd
    } else {
        let dir = (python $BK_script -c)
        if ( $dir | path exists ) {
            cd $dir
        } else {
            echo $dir
        }
    }
}

def --env wm1 [] {
    komorebic start --whkd --bar
}

def --env wm0 [] {
    komorebic stop
}
