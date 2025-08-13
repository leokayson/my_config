# env.nu
#
# Installed by:
# version = "0.106.0"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.
source $"cfg_($nu.os-info.name).nu"

export-env {
    load-env {
        EDITOR:                 'hx'
        VISUAL:                 'hx'
        CLIPBOARD_EDITOR:       'hx'
        CLIPBOARD_HISTORY:      10
        SHELL:                  'nu'
        FZF_DEFAULT_COMMAND:    'fd -t f -t d -Lu -E .git'
        FZF_DEFAULT_OPTS:       '-e --style=full --preview-window "up" --scheme=history --bind=ctrl-j:jump --preview "
            if (({} | path type) == \"dir\") {
                lsd -Al --config-file ~/.config/lsd.yaml --tree --depth 1 {}
            } else {
                bat -f --style=full {}
            }"'
        CHEAT_USE_FZF:          true
    }
}

$env.PATH = ($env.PATH | append $"($env.HOME)/.cargo/bin")
$env.PATH = ($env.PATH | append $"($env.HOME)/.local/bin")
$env.PATH = ($env.PATH | append $"($env.HOME)/env")
$env.PATH = ($env.PATH | append $"($env.HOME)/env/bin")
$env.PATH = ($env.PATH | append $"($env.HOME)/env/script")
$env.PATH = ($env.PATH | append $"($env.HOME)/env/usr/bin")

$env.LD_LIBRARY_PATH = $"($env.HOME)/env/lib"
$env.LD_LIBRARY_PATH = ($env.LD_LIBRARY_PATH | append $"($env.HOME)/env/lib")