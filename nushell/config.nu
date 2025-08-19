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
source $"($nu.default-config-dir)/themes/catppuccin_frappe.nu"

# ========================= Alias =========================
alias ncfg   = ox $"($nu.default-config-dir)/config.nu"
alias nenv   = ox $"($nu.default-config-dir)/env.nu"
alias scfg   = ox $"($env.HOME)/.config/starship.toml"

alias g      = git
alias mi     = micro
alias ff     = fastfetch
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
alias fzff   = fd -t f | fzf --preview-window "up" --preview "bat -f --style=full {}"
alias fzfd   = fd -t d | fzf --preview-window "up" --preview "lsd -Al --config-file ~/.config/lsd.yaml --tree --depth 1 {}"
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

alias y = yazi
# def --env y [...args] {
# 	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
# 	yazi ...$args --cwd-file $tmp
# 	let cwd = (open $tmp)
# 	if $cwd != "" and $cwd != $env.PWD {
# 		cd $cwd
# 	}
# 	rm -fp $tmp
# }

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
    } else if ( $cmd == "coder" ) {
        if ( $selected != "" ) {
            code -r $"($selected)"
        } 
    } else if ( $cmd == "nvim" ) {
        if ( $selected != "" ) {
            nvim $"($selected)"
        }
    } else if ( $cmd == "hx" ) {
        if ( $selected != "" ) {
            hx $"($selected)"
        }
    } else if ( $cmd == "mi" ) {
        if ( $selected != "" ) {
            micro $"($selected)"
        }
    } else {
        print $"no such cmd: ($cmd)"
    }

    if ( $cmd != "cd" and $path != "." ) {
        cd -
    }
}

def --env add_path [path: string] {
    $env.PATH = $env.PATH | append $path
}

def --env cdr [cmd? : string] {
    let CDR_script = $'($env.HOME)/env/ks_script/cd_record.py'
    let CDR_file = $'($env.HOME)/.config/cd_record.yaml'

    if ($cmd == null) {
        let dir = (python $CDR_script -c)
        if ( $dir | path exists ) {
            cd $dir
        } else {
            print -n 'Input base dir (default is cwd): '
            let dir2 = (python $CDR_script -i) 
            if ( $dir2 | path exists ) {
                cd $dir2
            } else {
                print $dir2
            }
        }
    } else {
        if ( $cmd == "h" ) {
            print 'Usage:'
            print ' cdr(z)           Cd to a cd record or interactive select'
            print ' cdr(z) $path     Normal cd && record'
            print ' cdr(z) r         Record cwd'
            print ' cdr(z) i         Interactive cd via fzf'
            print ' cdr(z) gc        Do gc to cd record'
            print ' cdr(z) l         List cd record'
            print ' cdr(z) e         Edit cd record'
        } else if ( $cmd  == "i" ) {
            print -n 'Input base dir (default is cwd): '
            let dir = (python $CDR_script -i) 
            if ( $dir | path exists ) {
                cd $dir
            } else {
                print $dir
            }
        } else if ( $cmd  == "r" ) {
            python $CDR_script -r
        } else if ( $cmd  == "gc" ) {
            python $CDR_script -g
        } else if ( $cmd  == "l" ) {
            bat -f --style=full $CDR_file
        } else if ( $cmd  == "e" ) {
            nvim $CDR_file
        } else {
            cd $cmd
            if ( $cmd != "." ) {
                python $CDR_script -r
            }
        } 
    }
}

alias z = cdr

def --env cmdh [cmd? : string] {
    let CMDH_script = $'($env.HOME)/env/ks_script/cmd_history.py'
    let cmd = (python $CMDH_script)
    ^($cmd)
}

def --env wm1 [] {
    # komorebic start --whkd
    glazewm start
}

# def --env wm0 [] {
    # komorebic stop
# }

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