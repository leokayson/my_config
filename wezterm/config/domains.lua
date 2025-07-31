return {
    -- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
    ssh_domains = {
        {
            -- The connection is an ssh connection, don't use any multiplexing.
            multiplexing = "None",

            -- The name of this specific domain. Must be unique amongst
            name = "kswu-wsl-24.05",

            -- identifies the host:port pair of the remote server
            -- Can be a DNS name or an IP address with an optional
            -- ":port" on the end.
            remote_address = "172.30.100.155:22",

            -- Whether agent auth should be disabled.
            -- Set to true to disable it.
            -- no_agent_auth = false,

            -- The username to use for authenticating with the remote host
            username = "kswu",

            -- Specify a SSH connection authentication file
            -- Default authentication file is "~/.ssh/id_rsa"
            ssh_option = {
                -- identityfile = "C:\\Users\\11409\\.ssh\\id_rsa",
                identityfile = "~/.ssh/id_rsa"
            }
        }, {
            -- The connection is an ssh connection, don't use any multiplexing.
            multiplexing = "None",

            -- The name of this specific domain. Must be unique amongst
            name = "Alma-linux",

            -- identifies the host:port pair of the remote server
            -- Can be a DNS name or an IP address with an optional
            -- ":port" on the end.
            remote_address = "host.myalmalinux.com:22",

            -- Whether agent auth should be disabled.
            -- Set to true to disable it.
            -- no_agent_auth = false,

            -- The username to use for authenticating with the remote host
            username = "root",

            -- Specify a SSH connection authentication file
            -- Default authentication file is "~/.ssh/id_rsa"
            ssh_option = {
                identityfile = "~/.ssh/id_rsa"
            }
        }
    },

    -- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
    wsl_domains = {
        {
            name = "WSL:Ubuntu-24.04",
            distribution = "Ubuntu-24.04",
            username = "kswu",
            default_cwd = "/home/kswu",
            default_prog = {"fish"}
        }
    }
}
