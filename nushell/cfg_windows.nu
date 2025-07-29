
export-env {
    load-env {
        HOME:           $env.USERPROFILE
        YAZI_FILE_ONE:  'C:/Program Files/Git/usr/bin/file.exe'
    }
}

$env.PATH = ($env.PATH | append $"($env.HOME)/env/script/win")
$env.PATH = ($env.PATH | append $"($env.LOCALAPPDATA)/Microsoft/WindowsApps")

source $"($nu.data-dir)/custom-completions/adb/adb-completions.nu"
source $"($nu.data-dir)/custom-completions/fastboot/fastboot-completions.nu"
source $"($nu.data-dir)/custom-completions/windows/windows-completions.nu"
source $"($nu.data-dir)/custom-completions/winget/winget-completions.nu"