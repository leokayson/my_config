import os, argparse

parser = argparse.ArgumentParser()
parser.add_argument('-pc', '--path_convert', action='store', default='')

args = parser.parse_args()

if args.pc:
    print('1. -> \\')
    print('2. -> \\\\')
    print('3. -> /')
    choice = (int)(input('Input your convert:'))

    path = args.pc
    if choice >= 1 and choice <= 3:
        if choice == 1:
            print(str(path).replace('/', '\\').replace('\\\\', '\\'))
        elif choice == 2:
            print(str(path).replace('/', '\\').replace('\\', '\\\\'))
        elif choice == 3:
            print(str(path).replace('\\\\', '\\').replace('\\', '/'))




