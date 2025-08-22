local platform = require("utils.platform")()

local options = {
    default_prog = {},
    launch_menu = {}
}

if platform.is_win then
    -- options.default_prog = { "ssh", "kswu@172.30.100.155", "-p", "22" }
    --   options.default_prog = { "wsl", "-d", "Ubuntu-24.04" }
    options.default_prog = {"nu"}
    options.launch_menu = {
        {
            label = " Nushell",
            args = {"nu"}
        }, {
            label = " Cmd",
            args = {"cmd"}
        }, {
            label = " PowerShell v1",
            args = {"powershell"}
        }, {
            label = " PowerShell v7",
            args = {"pwsh"}
        }
    }
elseif platform.is_linux then
    options.default_prog = {"bash", "--login"}
    options.launch_menu = {
        {
            label = " Fish",
            args = {"fish", "--login"}
        }, {
            label = " Bash",
            args = {"bash", "--login"}
        }, {
            label = " Nushell",
            args = {"nu", "--login"}
        }
    }
end

return options
