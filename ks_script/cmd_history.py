import os, argparse, subprocess

HOME = os.getenv('HOME')
SHELL = os.getenv('SHELL')

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