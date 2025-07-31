local platform = require("utils.platform")()

local options = {
  default_prog = {},
  launch_menu = {},
}

if platform.is_win then
  options.default_prog = { "ssh", "kswu@172.30.100.155", "-p", "22" }
  options.launch_menu = {
    {
      label = " Ubuntu",
      args = { "ssh", "kswu@172.30.100.155", "-p", "22" },
    },
    { label = " PowerShell v1", args = { "powershell" } },
    { label = " PowerShell v7", args = { "pwsh" } },
    { label = " Cmd", args = { "cmd" } },
    { label = " Nushell", args = { "nu" } },
    {
      label = " GitBash",
      args = { "C:\\Program Files\\Git\\bin\\bash.exe" },
    },
  }
elseif platform.is_linux then
  options.default_prog = { "bash", "--login" }
  options.launch_menu = {
    { label = " Bash", args = { "bash", "--login" } },
    { label = " Nushell", args = { "/opt/homebrew/bin/nu", "--login" } },
  }
end

return options
