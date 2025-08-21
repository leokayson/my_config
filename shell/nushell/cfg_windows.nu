export-env {
    load-env {
        HOME:                 $env.USERPROFILE
        YAZI_FILE_ONE:        $"($env.ProgramFiles)/Git/usr/bin/file.exe"
        KOMOREBI_CONFIG_HOME: $"($env.USERPROFILE)/.config/komorebi"
        WHKD_CONFIG_HOME:     $"($env.USERPROFILE)/.config/komorebi"
        GLAZEWM_CONFIG_PATH:  $"($env.USERPROFILE)/.config/glazewm/config.yaml"
    }
}

$env.PATH = ($env.PATH | append $"($env.USERPROFILE)/env/script/win")
$env.PATH = ($env.PATH | append $"($env.LOCALAPPDATA)/Microsoft/WindowsApps")
$env.PATH = ($env.PATH | append $"($env.LOCALAPPDATA)/Microsoft/WinGet/Links")
$env.PATH = ($env.PATH | append $"($env.ProgramFiles)/usbipd-win")
$env.PATH = ($env.PATH | append $"($env.ProgramFiles)/whkd/bin")
$env.PATH = ($env.PATH | append $"($env.ProgramFiles)/glzr.io/GlazeWM/cli")
$env.PATH = ($env.PATH | append $"($env.ProgramFiles)/glzr.io/Zebar")

alias ex = explorer