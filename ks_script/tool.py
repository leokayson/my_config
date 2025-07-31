import os, argparse, subprocess

parser = argparse.ArgumentParser()
parser.add_argument('-pc', '--path_convert', action='store', default='')
parser.add_argument('-a',  '--usb_attach',    action='store_true')
parser.add_argument('-d',  '--usb_detach',    action='store_true')
args = parser.parse_args()

if args.path_convert:
    print('1. -> \\')
    print('2. -> \\\\')
    print('3. -> /')
    choice = (int)(input('Input your convert:'))

    path = args.path_convert
    if choice >= 1 and choice <= 3:
        if choice == 1:
            print(str(path).replace('/', '\\').replace('\\\\', '\\'))
        elif choice == 2:
            print(str(path).replace('/', '\\').replace('\\', '\\\\'))
        elif choice == 3:
            print(str(path).replace('\\\\', '\\').replace('\\', '/'))
            
if args.usb_attach:
    if os.name == 'nt':
        ret = subprocess.run(['where', 'usbipd'], shell=False, capture_output=True, text=True, check=False)
        if ret.returncode:
            print('cannot find usbipd-win')
            print('Install usbipd here: https://github.com/dorssel/usbipd-win/releases')
            print('Or add it into $PATH')
            exit(ret.returncode)
        else:
            print(f'found winipd here: {ret.stdout}')
        subprocess.run(['usbipd', 'list'], shell=False, check=True)
        busid = input('Input BUSID wanna attach: ')
        try:
            subprocess.run(['usbipd', 'bind', '--force', '-b', busid], shell=False, check=True)
            subprocess.run(['usbipd', 'attach', '--wsl', '-b', busid], shell=False, check=True)
        except subprocess.SubprocessError as e:
            print(f'Error: {e}')
            exit(1)
        subprocess.run(['usbipd', 'list'], shell=False, check=True)
        
if args.usb_detach:
    if os.name == 'nt':
        ret = subprocess.run(['where', 'usbipd'], shell=False, capture_output=True, text=True, check=False)
        if ret.returncode:
            print('cannot find usbipd-win')
            print('Install usbipd here: https://github.com/dorssel/usbipd-win/releases')
            print('Or add it into $PATH')
            exit(ret.returncode)
        else:
            print(f'found winipd here: {ret.stdout}')
        subprocess.run(['usbipd', 'list'], shell=False, check=True)
        busid = input('Input BUSID wanna deattach: ')
        try:
            if busid == 'a' or busid == 'all':
                subprocess.run(['usbipd', 'detach', '-a'], shell=False, check=True)
                subprocess.run(['usbipd', 'unbind', '-a'], shell=False, check=True)
            else:
                subprocess.run(['usbipd', 'detach', '-b', busid], shell=False, check=True)
                subprocess.run(['usbipd', 'unbind', '-b', busid], shell=False, check=True)

        except subprocess.SubprocessError as e:
            print(f'Error: {e}')
            exit(1)
        subprocess.run(['usbipd', 'list'], shell=False, check=True)
        
            


