import os, argparse, subprocess, yaml

HOME = os.getenv('HOME')
SHELL = os.getenv('SHELL')
CDR_FILE = f'{HOME}/.config/cd_records.yaml'
GC_REF_PARAM = 0.01
GC_REC_PARAM = 0.1
IS_WRITE_TO = True

try:
    if not os.path.exists(CDR_FILE):
        with open(CDR_FILE, 'w'):
            pass # Create cd_record.yaml file
    with open(CDR_FILE, 'r') as f:
        cd_records = yaml.load(f, Loader=yaml.FullLoader)
    if cd_records == None:
        cd_records = {}
except Exception as e:
    print(f'Error: {e}')
    exit(-1)

parser = argparse.ArgumentParser()
parser.add_argument('-r', '--cd_record',          action='store_true', help='cd and then record')
parser.add_argument('-c', '--cd_in_record',       action='store_true', help='cd to a dir in record')
parser.add_argument('-l', '--list_cd_record',     action='store_true', help='list all cd records')
parser.add_argument('-g', '--garbage_collection', action='store_true', help='collect too old records')
args = parser.parse_args()

def get_cwd():
    ''' To get absolute path, also for link file'''
    if os.name == 'nt':
        return os.getcwd()
    else:
        ret = subprocess.run('pwd', executable=SHELL, capture_output=True, shell=True)
        return ret.stdout.decode('utf-8').strip()

if args.cd_record:
    cwd = get_cwd()
    if cwd not in cd_records.keys():
        cd_records[cwd] = 0
    cd_records[cwd] += 1
    
if args.cd_in_record:
    proc = subprocess.Popen(
        ['fzf'],
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )

    history = list(cd_records.keys())
    stdout, _ = proc.communicate(input='\n'.join(history).encode('utf-8'))
    chosen = stdout.decode('utf-8').strip()
    if chosen == '':
        print('no enter')
    else:
        if os.path.exists(chosen):
            cd_records[chosen] += 1
            print(chosen)
        else:
            cd_records.pop(chosen)
            print('chosen dir doesn\'t exist anymore')
    proc.kill()

if args.garbage_collection:
    max_access = max(list(cd_records.values()))
    gc_ref_value = int(max_access * GC_REF_PARAM)
    
    if gc_ref_value == 0:
        print('no need to do gc')
    else:
        for k, v in cd_records.values():
            if v <= gc_ref_value:
                cd_records.pop(k)
            else:
                cd_records[k] = int(v * GC_REC_PARAM)

if args.list_cd_record:
    print(yaml.dump(cd_records))
else:
    with open(CDR_FILE, 'w') as f:
        yaml.dump(cd_records, f, default_flow_style=False, indent=4)