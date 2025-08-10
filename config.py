import os, subprocess, shutil

my_cfg_home = os.path.dirname(__file__)
home = os.getenv('HOME')

def create_soft_link(file, link_file):
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

    if os.name == 'nt':
        if os.path.isdir(file):
            subprocess.run(f'mklink /D {link_file} {file}', shell=True, check=True)
        else:
            subprocess.run(f'mklink {link_file} {file}', shell=True, check=True)
    else:
        subprocess.run(f'ln -s {file} {link_file}', shell=True, check=True)
        print(f'soft link created: {link_file} => {file}')

def config_soft_link():
    if os.name == 'nt':
        cfg_cmn_dir = os.getenv('APPDATA')
        nvim_home = os.path.join(os.getenv('LOCALAPPDATA'), 'nvim')

        create_soft_link(os.path.join(my_cfg_home, 'yazi'), os.path.join(cfg_cmn_dir, 'yazi', 'config')) 
    else:
        cfg_cmn_dir = os.path.join(home, '.config')
        nvim_home = os.path.join(home, '.config', 'nvim')

        create_soft_link(os.path.join(my_cfg_home, '.bashrc'), os.path.join(home, '.bashrc'))
        create_soft_link(os.path.join(my_cfg_home, 'fish', 'config.fish'), os.path.join(cfg_cmn_dir, 'fish', 'config.fish'))
        create_soft_link(os.path.join(my_cfg_home, 'yazi'), os.path.join(cfg_cmn_dir, 'yazi'))
    
    # Normal config files in 
    create_soft_link(os.path.join(my_cfg_home, 'helix'), os.path.join(cfg_cmn_dir, 'helix'))
    create_soft_link(os.path.join(my_cfg_home, 'nushell'), os.path.join(cfg_cmn_dir, 'nushell'))

    # Nvim
    create_soft_link(os.path.join(my_cfg_home, 'nvim', 'keymaps.lua'), os.path.join(nvim_home, 'lua', 'config', 'keymaps.lua'))
    create_soft_link(os.path.join(my_cfg_home, 'nvim', 'init.lua'), os.path.join(nvim_home, 'init.lua'))
    create_soft_link(os.path.join(my_cfg_home, 'nvim', 'colorscheme.lua'), os.path.join(nvim_home, 'lua', 'plugins', 'colorscheme.lua'))

    # Common config files in ~
    create_soft_link(os.path.join(my_cfg_home, '.clang-format'), os.path.join(home, '.clang-format'))
    create_soft_link(os.path.join(my_cfg_home, '.gitconfig'), os.path.join(home, '.gitconfig'))
    
    # Common config files in ~/.config
    create_soft_link(os.path.join(my_cfg_home, '.config', 'starship.toml'), os.path.join(home, '.config', 'starship.toml'))
    create_soft_link(os.path.join(my_cfg_home, '.config', 'btm.toml'), os.path.join(home, '.config', 'btm.toml'))
    create_soft_link(os.path.join(my_cfg_home, '.config', 'lsd.yaml'), os.path.join(home, '.config', 'lsd.yaml'))
    create_soft_link(os.path.join(my_cfg_home, 'terminal', 'wezterm'), os.path.join(home, '.config', 'wezterm'))

    # Tool scripts
    create_soft_link(os.path.join(my_cfg_home, 'ks_script'), os.path.join(home, 'env', 'ks_script'))

def config_windows_wm_soft_link():
    # Deprecated
    # create_soft_link(os.path.join(my_cfg_home, 'win_wm', 'komorebi'), os.path.join(home, '.config', 'komorebi'))
    create_soft_link(os.path.join(my_cfg_home, 'wm', 'win', 'glazewm'), os.path.join(home, '.config', 'glazewm'))
    create_soft_link(os.path.join(my_cfg_home, 'wm', 'win', 'yasb'), os.path.join(home, '.config', 'yasb'))
def config_windows_wm_soft_link():
    create_soft_link(os.path.join(my_cfg_home, 'wm', 'linux', 'hyprland', 'Keybinds.conf'), os.path.join(home, '.config', 'hypr', 'configs', 'Keybinds.conf'))

if __name__ == "__main__":
    config_soft_link()
    if os.name == 'nt':
        config_windows_wm_soft_link()
