import os, argparse, subprocess

HOME = os.getenv('HOME')
SHELL = os.getenv('SHELL')
BM_FILE = f'{HOME}/.config/cb_bookmarks.log'

parser = argparse.ArgumentParser()
parser.add_argument('-a',  '--add_dir_bookmarks',        action='store_true')
parser.add_argument('-d',  '--delete_dir_bookmarks',     action='store_true')
parser.add_argument('-D',  '--delete_all_dir_bookmarks', action='store_true')
parser.add_argument('-l',  '--list_dir_bookmarks',       action='store_true')
parser.add_argument('-c',  '--cd_dir_bookmarks',         action='store_true')
parser.add_argument('-cmd', '--cmd_history',              action='store_true')
args = parser.parse_args()

def get_cwd():
    if os.name == 'nt':
        return os.getcwd()
    else:
        ret = subprocess.run('pwd', executable=SHELL, capture_output=True, shell=True)
        return ret.stdout.decode('utf-8').strip()

def fzf_sel():
    ret = subprocess.run(f'cat {BM_FILE} | fzf --preview-window=hidden', capture_output=True, shell=True)
    return ret.stdout.decode('utf-8').strip()

def delete_bookmark(dir:str):
    context = []
    try:
        with open(BM_FILE, 'r') as f:
            for line in f:
                if line.strip() != dir:
                    context += [ line ]
        with open(BM_FILE, 'w') as f:
            f.write(''.join(context))
    except Exception as e:
        print(f'error: {e}')
        exit(1)

if args.add_dir_bookmarks:
    cwd = get_cwd()
    is_exist = False
    context = [ cwd ]
    if not os.path.exists(BM_FILE):
        with open(BM_FILE, 'w') as f:
            pass
    try:
        with open(BM_FILE, 'r') as f:
            for line in f:
                is_exist = line.strip() == cwd
                if is_exist:
                    break
                context += [ line.strip() ]
        if not is_exist:
            context.sort()
            with open(BM_FILE, 'w') as f:
                f.write('\n'.join(context))
    except Exception as e:
        print(f'error: {e}')
        exit(1)
    print(f'Add {cwd} done')

if args.delete_dir_bookmarks:
    if os.path.exists(BM_FILE):
        dir = fzf_sel()
        if dir != "":
            delete_bookmark(dir)
        print(f'delete {dir} done')
    else:
        print("bookmark doesn't exist, add firstly")

if args.delete_all_dir_bookmarks:
    is_yes = input(f'confirm to delete {BM_FILE}, (y)es:')
    if is_yes.lower() in ['y', 'yes']:
        if os.path.exists(BM_FILE):
            os.remove(BM_FILE)
        print('delete all bookmarks done')
    print('cancel to delete all bookmarks')

if args.list_dir_bookmarks:
    if os.path.exists(BM_FILE):
        subprocess.run(['bat', BM_FILE], shell=False)
    else:
        print("bookmark doesn't exist, add firstly")

if args.cd_dir_bookmarks:
    if os.path.exists(BM_FILE):
        dir = fzf_sel()
        if dir != "":
            if os.path.exists(dir):
                print(dir)
            else:
                delete_bookmark(dir)
                print(f"dir {dir} doesn't exist anymore, delete it", )
        else:
            print('.')
    else:
        print("bookmark doesn't exist, add firstly")

if args.cmd_history:
    proc = subprocess.Popen(
       ['fzf'],
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    if SHELL == 'fish':
        history = subprocess.run('history', executable=SHELL, shell=True, capture_output=True).stdout
        stdout, _ = proc.communicate(input=history)
        print(stdout.decode('utf-8').strip())
    proc.kill()