import sys, os, subprocess

def create_soft_link(file, link_file):
    if os.path.exists(link_file):
        os.remove(link_file)
    if not os.path.exists(os.path.dirname(link_file)):
        os.makedirs(os.path.dirname(link_file))

    if os.name == 'nt':
        subprocess.run(f'mklink {link_file} {file}', shell=True, check=True)
    else:
        subprocess.run(f'ln -s {file} {link_file}', shell=True, check=True)

def config_soft_link():
    cwd = os.getcwd()
    
    if os.name == 'nt':
        home = os.getenv('USERPROFILE')
        cmder_home = os.getenv('CMDER_HOME')
        print(f"cmder_home: {cmder_home}")

        if cmder_home:
            create_soft_link(os.path.join(cwd, 'cmder', 'self_init.bat'), os.path.join(cmder_home, 'vendor', 'self_init.bat'))
            create_soft_link(os.path.join(cwd, 'cmder', 'user_aliases.cmd'), os.path.join(cmder_home, 'config', 'user_aliases.cmd'))

    else:
        home = os.getenv('HOME')

    create_soft_link(os.path.join(cwd, '.config', 'starship.toml'), os.path.join(home, '.config', 'starship.toml'))
    create_soft_link(os.path.join(cwd, '.config', 'btm.toml'), os.path.join(home, '.config', 'btm.toml'))

    create_soft_link(os.path.join(cwd, '.clang-format'), os.path.join(home, '.clang-format'))
    create_soft_link(os.path.join(cwd, '.gitconfig'), os.path.join(home, '.gitconfig'))


if __name__ == "__main__":
    config_soft_link()