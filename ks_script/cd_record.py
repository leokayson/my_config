import os, argparse, subprocess, yaml
from time import sleep

HOME = os.getenv('HOME')
SHELL = os.getenv('SHELL')
CDR_FILE = f'{HOME}/.config/cd_record.yaml'
GC_REF_PARAM = 0.02
GC_REC_PARAM = 0.1

try:
    if not os.path.exists(CDR_FILE):
        # Create CDR_FILE file
        with open(CDR_FILE, 'w'):
            pass 
    with open(CDR_FILE, 'r') as f:
        cd_record = yaml.load(f, Loader=yaml.FullLoader)
    if cd_record == None or cd_record == {}:
        cd_record = { HOME : 1 }
except Exception as e:
    print(f'Error: {e}')
    exit(-1)

parser = argparse.ArgumentParser()
parser.add_argument('-r', '--record',             action='store_true', help='cd and then record')
parser.add_argument('-c', '--cd_in_record',       action='store_true', help='cd to a dir in record')
parser.add_argument('-i', '--cd_interactive',     action='store_true', help='cd to a dir in record')
parser.add_argument('-gc', '--garbage_collection', action='store_true', help='collect too old records')
args = parser.parse_args()

def get_cwd():
    ''' To get absolute path, also for link file'''
    if os.name == 'nt':
        return os.getcwd()
    else:
        ret = subprocess.run('pwd', executable=SHELL, capture_output=True, shell=True)
        return ret.stdout.decode('utf-8').strip()

def record_path(abs_path: str):
    '''Record the abs path to CDR_FILE. Use abs path to avoid duplicate'''
    if os.name == 'nt':
        '''Since the server path starts with \\\\, so path should be contained in \\'''
        abs_path = abs_path.replace('/', '\\')
        if abs_path[-1] == '\\':
            abs_path = abs_path[:-1]
        if abs_path not in cd_record.keys():
            cd_record[abs_path] = 0
        cd_record[abs_path] += 1
    else:
        abs_path = abs_path.strip().replace('\\', '/')
        if abs_path[-1] == '/':
            abs_path = abs_path[:-1]
        if abs_path not in cd_record.keys():
            cd_record[abs_path] = 0
        cd_record[abs_path] += 1

if args.record:
    record_path(get_cwd())
    
if args.cd_in_record:
    proc = subprocess.Popen(
        'fzf',
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )

    record_items = list(cd_record.keys())
    stdout, _ = proc.communicate(input='\n'.join(record_items).encode('utf-8'))
    chosen = stdout.decode('utf-8').strip()
    if chosen == '':
        print('no enter')
    else:
        if os.path.exists(chosen):
            record_path(chosen)
            print(chosen)
        else:
            cd_record.pop(chosen)
            print('chosen dir doesn\'t exist anymore')
    proc.kill()

if args.cd_interactive:
    # Base is cwd, please use this script in shell
    base = input()
    if base == '~':
        base = HOME
    chosen = subprocess.run(f'fd -Lu -a -t d . {base} | fzf', shell=True, capture_output=True).stdout.decode('utf-8').strip()
    if chosen == '':
        print('no enter')
    else:
        record_path(chosen)
        print(chosen)

if args.garbage_collection:
    max_access = 0
    need_gc_k = []
    for k, v in cd_record.items():
        if not (os.path.exists(k) or os.path.lexists(k)):
            need_gc_k += [k]
        else:
            max_access = max(max_access, v)
    
    proc = subprocess.Popen(
        ['fzf', '-m'],
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )

    record_items = list(cd_record.keys())
    stdout, _ = proc.communicate(input='\n'.join(record_items).encode('utf-8'))
    chosen = stdout.decode('utf-8').strip()

    need_gc_k += chosen.split('\n')

    '''Don't remove old records anymore'''    
    # gc_ref_value = int(max_access * GC_REF_PARAM)
    # if gc_ref_value != 0:
    #     for k, v in cd_record.items():
    #         if v <= gc_ref_value:
    #             need_gc_k += [k]
    #         else:
    #             cd_record[k] = int(v * GC_REC_PARAM)
                
    for nk in need_gc_k:
        if nk in cd_record.keys():
            cd_record.pop(nk)

with open(CDR_FILE, 'w') as f:
    yaml.dump(cd_record, f, default_flow_style=False, indent=4)
