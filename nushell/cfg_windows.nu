
export-env {
    load-env {
        HOME:                 $env.USERPROFILE
        YAZI_FILE_ONE:        $"($env.ProgramFiles)/Git/usr/bin/file.exe"
        KOMOREBI_CONFIG_HOME: $"($env.USERPROFILE)/.config/komorebi"
        WHKD_CONFIG_HOME:     $"($env.USERPROFILE)/.config/komorebi"
    }
}

$env.PATH = ($env.PATH | append $"($env.USERPROFILE)/env/script/win")
$env.PATH = ($env.PATH | append $"($env.LOCALAPPDATA)/Microsoft/WindowsApps")
$env.PATH = ($env.PATH | append $"($env.LOCALAPPDATA)/Microsoft/WinGet/Links")
$env.PATH = ($env.PATH | append $"($env.ProgramFiles)/usbipd-win")
$env.PATH = ($env.PATH | append $"($env.ProgramFiles)/whkd/bin")

source $"($nu.default-config-dir)/custom-completions/adb/adb-completions.nu"
source $"($nu.default-config-dir)/custom-completions/fastboot/fastboot-completions.nu"
source $"($nu.default-config-dir)/custom-completions/windows/windows-completions.nu"
source $"($nu.default-config-dir)/custom-completions/winget/winget-completions.nu"