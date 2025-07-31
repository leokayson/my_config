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
        CLIPBOARD_EDITOR:       'hx'
        CLIPBOARD_HISTORY:      10
        VISUAL:                 'hx'
        PAGER:                  'bat'
        SHELL:                  'nu'
        HOSTNAME:               (hostname | split row '.' | first | str trim)
    }
}

$env.PATH = ($env.PATH | append $"($env.HOME)/.cargo/bin")
$env.PATH = ($env.PATH | append $"($env.HOME)/.local/bin")
$env.PATH = ($env.PATH | append $"($env.HOME)/env/bin")
$env.PATH = ($env.PATH | append $"($env.HOME)/env/script")
$env.PATH = ($env.PATH | append $"($env.HOME)/env/usr/bin")

$env.LD_LIBRARY_PATH = $"($env.HOME)/env/lib"
$env.LD_LIBRARY_PATH = ($env.LD_LIBRARY_PATH | append $"($env.HOME)/env/lib")