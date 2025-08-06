import os, argparse, subprocess, yaml

HOME = os.getenv('HOME')
SHELL = os.getenv('SHELL')
CDH_FILE = f'{HOME}/.config/cd_history.yaml'
GC_REF_PARAM = 0.01
GC_REC_PARAM = 0.1

try:
    if not os.path.exists(CDH_FILE):
        with open(CDH_FILE, 'w'):
            pass # Create cd_history.yaml file
    with open(CDH_FILE, 'r') as f:
        cd_historys = yaml.load(f, Loader=yaml.FullLoader)
    if cd_historys == None:
        cd_historys = {}
except Exception as e:
    print(f'Error: {e}')
    exit(-1)

parser = argparse.ArgumentParser()
parser.add_argument('-C', '--cd_history', action='store_true')
parser.add_argument('-c', '--cd_path', action='store')
parser.add_argument('-l', '--list_cd_history', action='store_true')
parser.add_argument('-g', '--garbage_collection', action='store_true')
parser.add_argument('-cmd', '--cmd_history', action='store_true')
args = parser.parse_args()

if args.cd_path:
    # TODO: How to get link abs path instead of real abs path here?
    path = os.path.abspath(args.cd_path)
    if os.path.exists(path):
        if not os.path.isdir(path):
            path = os.path.dirname(path)
        if path not in cd_historys.keys():
            cd_historys[path] = 0
        cd_historys[path] += 1
        print(path)
    else:
        if path in cd_historys.keys():
            cd_historys.pop(path)
        print(f'{path} not exist')
    
if args.cd_history:
    proc = subprocess.Popen(
       ['fzf'],
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )

    history = list(cd_historys.keys())
    stdout, _ = proc.communicate(input='\n'.join(history).encode('utf-8'))
    chosen = stdout.decode('utf-8').strip()
    if chosen == '':
        print('no enter')
    else:
        if os.path.exists(chosen):
            cd_historys[chosen] += 1
            print(chosen)
        else:
            cd_historys.clear(path)
    proc.kill()

if args.garbage_collection:
    max_access = max(list(cd_historys.values()))
    gc_ref_value = int(max_access * GC_REF_PARAM)
    
    if gc_ref_value == 0:
        print('no need to do gc')
    else:
        for k, v in cd_historys.values():
            if v <= gc_ref_value:
                cd_historys.pop(k)
            else:
                cd_historys[k] = int(v * GC_REC_PARAM)

if args.list_cd_history:
    print(yaml.dump(cd_historys))

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
else:
    with open(CDH_FILE, 'w') as f:
        yaml.dump(cd_historys, f, default_flow_style=False, indent=4)