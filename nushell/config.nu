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

# ========================= Alias =========================
alias ncfg   = code $"($env.HOME)/.config/nushell/config.nu"
alias nenv   = code $"($env.HOME)/.config/nushell/env.nu"
alias scfg   = code $"($env.HOME)/.config/starship.toml"

alias g      = git
alias py     = python
alias vi     = nvim
alias vim    = nvim
alias tool   = python ~/env/ks_script/tool.py
alias pc     = python ~/env/ks_script/tool.py -pc
alias where  = which

alias fd     = fd -I -H
alias ls     = lsd --config-file ~/.config/lsd.yaml
alias ll     = lsd --config-file ~/.config/lsd.yaml -Al
alias lll    = ll -L
alias llt    = ll --total-size
alias llns   = ll --no-symlink
alias lld    = fd -l -d 1
alias btm    = btm --config_location ~/.config/btm.toml
alias fzff   = fd -t f | fzf
alias fzfd   = fd -t d | fzf
alias fzfp   = fzfd | path expand

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
    let selected = (fzf)
    let CDR_script = $'($env.HOME)/env/ks_script/cd_record.py'
    
    if ( $cmd == "cd" ) {
        if ( $selected != "" ) {
            if ( (($selected) | path type) == 'dir') {
                cd $"($selected)"
            } else {
                cd $"(($selected) | path dirname)"
            }
            python $CDR_script -r
            print $"enter: (pwd)"
        } else {
            cd -
            print no enter
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
        print $"no such cmd: ($cmd)"
    }
}

def --env add_path [path: string] {
    $env.PATH = $env.PATH | append $path
}

# Deprecated
def --env cdb [cmd? : string] {
    let BK_script = $'($env.HOME)/env/ks_script/shell_bookmarks.py'

    if ( $cmd == null ) {
        let dir = (python $BK_script -c)
        if ( $dir | path exists ) {
            cd $dir
        } else {
            print $dir
        }
    } else if ( $cmd == "h" ) {
        print 'Usage:'
        print ' cdb           Cd to a dir bookmark'
        print ' cdb a         Add a dir bookmark'
        print ' cdb d         Delete a dir bookmark'
        print ' cdb D         Delete all dir bookmarkds'
        print ' cdb l         List all dir bookmarkds'
        print ' cdb e         Edit the dir bookmarkds'
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
    }
}

def --env cdr [cmd : string] {
    let CDR_script = $'($env.HOME)/env/ks_script/cd_record.py'

    if ( $cmd == "h" ) {
        print 'Usage:'
        print ' cdr(c)           Cd to a cd history'
        print ' cdr(c) c         Normal cd && record'
        print ' cdr(c) g         Do gc to cd history'
    } else if ( $cmd == "c") {
        let dir = (python $CDR_script -c) 
        if ( $dir | path exists ) {
            cd $dir
        } else {
            print $dir
        }
    } else if ( $cmd  == "g" ) {
        python $CDR_script -g
    } else if ( $cmd  == "l" ) {
        python $CDR_script -l
    } else {
        cd $cmd
        if ( $cmd != "." ) {
            python $CDR_script -r
        }
    } 
}

alias z = cdr

def --env cmdh [cmd? : string] {
    let CMDH_script = $'($env.HOME)/env/ks_script/cmd_history.py'
    let cmd = (python $CMDH_script)
    run-external $cmd
}

def --env wm1 [] {
    komorebic start --whkd
}

def --env wm0 [] {
    komorebic stop
}

def sd [ mins?: int ] {
    if ( $mins == null ) {
        shutdown -a
        print "cancel shutting down"
    } else {
        let seconds = $mins * 60
        shutdown -s -t $seconds
        
        print $"will shutdown after ($mins) mins"
    }
}