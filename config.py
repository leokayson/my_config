# Mainly use python to write script, which can be used in all platform
import os, subprocess, shutil

my_cfg_home = os.path.dirname(__file__)

if os.name == "nt":
    home = os.getenv("USERPROFILE")
    cfg_cmn_dir = os.getenv("APPDATA")
    nvim_home = os.path.join(os.getenv("LOCALAPPDATA"), "nvim")
else:
    home = os.getenv("HOME")
    cfg_cmn_dir = os.path.join(home, ".config")
    nvim_home = os.path.join(home, ".config", "nvim")


def establish_soft_link(file, link_file):
    if os.path.lexists(link_file):
        try:
            if os.path.islink(link_file) or os.path.isfile(link_file):
                os.remove(link_file)
            else:
                shutil.rmtree(link_file)
        except Exception as e:
            print(f"Error removing existing link or file: {e}")
            exit(1)

    if not os.path.exists(os.path.dirname(link_file)):
        os.makedirs(os.path.dirname(link_file))

    if os.name == "nt":
        ln_cmd = "mklink /D" if os.path.isdir(file) else "mklink"
        subprocess.run(f"{ln_cmd} {link_file} {file}", shell=True, check=True)
    else:
        subprocess.run(f"ln -s {file} {link_file}", shell=True, check=True)
        print(f"soft link created: {link_file} => {file}")


def set_normal_config():
    if os.name == "nt":
        establish_soft_link(
            os.path.join(my_cfg_home, "yazi"),
            os.path.join(cfg_cmn_dir, "yazi", "config"),
        )
    else:
        establish_soft_link(
            os.path.join(my_cfg_home, ".bashrc"), os.path.join(home, ".bashrc")
        )
        establish_soft_link(
            os.path.join(my_cfg_home, "yazi"), os.path.join(cfg_cmn_dir, "yazi")
        )

    # Common config files in ~
    establish_soft_link(
        os.path.join(my_cfg_home, ".clang-format"), os.path.join(home, ".clang-format")
    )
    establish_soft_link(
        os.path.join(my_cfg_home, ".gitconfig"), os.path.join(home, ".gitconfig")
    )

    # Common config files in ~/.config
    establish_soft_link(
        os.path.join(my_cfg_home, ".config", "starship.toml"),
        os.path.join(home, ".config", "starship.toml"),
    )
    establish_soft_link(
        os.path.join(my_cfg_home, ".config", "btm.toml"),
        os.path.join(home, ".config", "btm.toml"),
    )
    establish_soft_link(
        os.path.join(my_cfg_home, ".config", "lsd.yaml"),
        os.path.join(home, ".config", "lsd.yaml"),
    )


def set_editor_config():
    # Nvim (Temp no longer in use, slow to open in a not good computer)
    establish_soft_link(
        os.path.join(my_cfg_home, "editor", "nvim", "keymaps.lua"),
        os.path.join(nvim_home, "lua", "config", "keymaps.lua"),
    )
    establish_soft_link(
        os.path.join(my_cfg_home, "editor", "nvim", "init.lua"),
        os.path.join(nvim_home, "init.lua"),
    )
    establish_soft_link(
        os.path.join(my_cfg_home, "editor", "nvim", "colorscheme.lua"),
        os.path.join(nvim_home, "lua", "plugins", "colorscheme.lua"),
    )

    # Helix (Temp no longer in use, a little ugly)
    establish_soft_link(
        os.path.join(my_cfg_home, "editor", "helix"), os.path.join(cfg_cmn_dir, "helix")
    )

    # micro
    establish_soft_link(
        os.path.join(my_cfg_home, "editor", "micro"),
        os.path.join(home, ".config", "micro"),
    )


def set_shell_config():
    # wanna also use nushell in linux, but fish is too good while nushell is hard to run some shell cmd in bash
    if os.name == "nt":
        establish_soft_link(
            os.path.join(my_cfg_home, "shell", "nushell"),
            os.path.join(cfg_cmn_dir, "nushell"),
        )
        establish_soft_link(
            os.path.join(my_cfg_home, "shell", "PowerShell"),
            os.path.join(home, "Documents", "PowerShell"),
        )
    else:
        establish_soft_link(
            os.path.join(my_cfg_home, "shell", "fish", "config.fish"),
            os.path.join(cfg_cmn_dir, "fish", "config.fish"),
        )
        establish_soft_link(
            os.path.join(my_cfg_home, "terminal", "kitty"),
            os.path.join(home, ".config", "kitty"),
        )

    # Use nightly version, but still has some bugs bringing ugly window bar that I cannot bear. Temp no in use
    # establish_soft_link(
    #     os.path.join(my_cfg_home, "terminal", "wezterm"),
    #     os.path.join(home, ".config", "wezterm"),
    # )


def set_wm_config():
    if os.name == "nt":
        establish_soft_link(
            os.path.join(my_cfg_home, "wm", "win", "glazewm"),
            os.path.join(home, ".config", "glazewm"),
        )
        establish_soft_link(
            os.path.join(my_cfg_home, "wm", "win", "yasb"),
            os.path.join(home, ".config", "yasb"),
        )
    else:
        establish_soft_link(
            os.path.join(my_cfg_home, "wm", "linux", "hypr"),
            os.path.join(home, ".config", "hypr"),
        )


def set_script():
    # Tool scripts with many useful cmd
    establish_soft_link(
        os.path.join(my_cfg_home, "ks_script"), os.path.join(home, "env", "ks_script")
    )


if __name__ == "__main__":
    set_normal_config()
    set_editor_config()
    set_shell_config()
    set_wm_config()
    set_script()
