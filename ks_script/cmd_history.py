import os, argparse, subprocess

HOME = os.getenv('HOME')
SHELL = os.getenv('SHELL')

if SHELL == 'fish':
    proc = subprocess.Popen(
        ['fzf'],
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    history = subprocess.run('history', executable=SHELL, shell=True, capture_output=True).stdout
    stdout, _ = proc.communicate(input=history)
    print(stdout.decode('utf-8').strip())
elif SHELL == 'nu':
    history = os.path.join(os.getenv('APPDATA'), 'nushell', 'history.txt')
    cmd = subprocess.run(f'bat -p {history} | fzf', shell=True, capture_output=True)
    print(cmd.stdout.decode('utf-8').strip())