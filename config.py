import os, subprocess, shutil

cfg_home = os.path.dirname(__file__)

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
        home = os.getenv('USERPROFILE')
        app_data = os.getenv('APPDATA')
        local_app_data = os.getenv('LOCALAPPDATA')

        create_soft_link(os.path.join(cfg_home, 'yazi'), os.path.join(app_data, 'yazi', 'config')) 
        create_soft_link(os.path.join(cfg_home, 'nvim', 'keymaps.lua'), os.path.join(local_app_data, 'nvim', 'lua', 'config', 'keymaps.lua'))
        create_soft_link(os.path.join(cfg_home, 'nushell'), os.path.join(app_data, 'nushell'))
    else:
        home = os.getenv('HOME')
        create_soft_link(os.path.join(cfg_home, '.bashrc'), os.path.join(home, '.bashrc'))
        create_soft_link(os.path.join(cfg_home, 'yazi'), os.path.join(home, '.config', 'yazi'))
        create_soft_link(os.path.join(cfg_home, 'nvim', 'keymaps.lua'), os.path.join(home, '.config', 'nvim', 'lua', 'config', 'keymaps.lua'))
        create_soft_link(os.path.join(cfg_home, 'nushell'), os.path.join(home, '.config', 'nushell'))

    create_soft_link(os.path.join(cfg_home, '.config', 'starship.toml'), os.path.join(home, '.config', 'starship.toml'))
    create_soft_link(os.path.join(cfg_home, '.config', 'btm.toml'), os.path.join(home, '.config', 'btm.toml'))
    create_soft_link(os.path.join(cfg_home, '.config', 'lsd.yaml'), os.path.join(home, '.config', 'lsd.yaml'))
    create_soft_link(os.path.join(cfg_home, 'wezterm'), os.path.join(home, '.config', 'wezterm'))

    create_soft_link(os.path.join(cfg_home, 'script'), os.path.join(home, 'env', 'script'))
    create_soft_link(os.path.join(cfg_home, '.clang-format'), os.path.join(home, '.clang-format'))
    create_soft_link(os.path.join(cfg_home, '.gitconfig'), os.path.join(home, '.gitconfig'))


if __name__ == "__main__":
    config_soft_link()