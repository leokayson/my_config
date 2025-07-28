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

source $"cfg_($nu.os-info.name).nu"

alias ncfg   = code $"($env.HOME)/.config/nushell/config.nu"
alias nenv   = code $"($env.HOME)/.config/nushell/env.nu"
alias scfg   = code $"($env.HOME)/.config/starship.toml"
alias py     = python

alias fd     = fd -I -H
alias ls     = lsd -T --icon-theme unicode
alias ll     = ls --header --git -Al --date relative
alias lld    = fd -l -d 1
alias llt    = ll --total-size
alias cd1    = cd ../
alias cd2    = cd ../../
alias cd3    = cd ../../../
alias btm    = btm --theme=gruvbox --config_Location ~/.config/btm.toml
alias gacnm  = git add . and git cnm
alias grd    = git rh and git clean -fd

$env.CLIPBOARD_EDITOR = "nvim"
$env.CLIPBOARD_HISTORY = 50

$env.PATH = ($env.PATH | append $"($env.HOME)/.cargo/bin")
$env.PATH = ($env.PATH | append $"($env.HOME)/.local/bin")
$env.PATH = ($env.PATH | append $"($env.HOME)/env/usr/bin")
$env.PATH = ($env.PATH | append $"($env.HOME)/env/script")

$env.LD_LIBRARY_PATH = $"($env.HOME)/env/usr/lib"

def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

def --env z [cmd: string, path: string] {
    if ( $cmd == "cd" ) {

        cd $"($path)"
        try {
            let selected = (fzf --walker=dir,hidden)
            if ( $selected != "" ) {
                cd $"($selected)"
                echo $"enter: (pwd)"
            } else {
                echo no enter
            }
        }

    } else if ( $cmd == "code" ) {

        cd $"($path)"
        let selected = (fzf --walker=dir,hidden)
        if ( $selected != "" ) {
            code $"($selected)"
        } else {
            cd -
        }

    } else if ( $cmd == "cd" ) {

        cd $"($path)"
        let selected = (fzf --walker=dir,hidden)
        if ( $selected != "" ) {
            nvim $"($selected)"
        } else {
            cd -
        }

    } else {
        echo $"no such cmd: ($cmd)"
    }
}

def tool [...args] {
    python ~\usr\env\script\tool.py $args
}