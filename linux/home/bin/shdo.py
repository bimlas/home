import os
import glob
import sys

DATABASE = os.path.expanduser('~/.shdo/')
if not os.path.exists(DATABASE):
    os.makedirs(DATABASE)

def _tag_list():
    return(os.listdir(DATABASE))

def _tag_targets(tag):
    return([line.rstrip('\n') for line in open(DATABASE + tag)])

def add(args):
    tag = args[0]
    targets = args[1:]
    with open(DATABASE + '/' + tag, "a") as targets_file:
        targets_file.write('\n'.join([os.path.abspath(os.path.expanduser(target)) for target in targets]) + '\n')

def list(args):
    if len(args) == 0:
        for tag in _tag_list():
            print(tag)
    else:
        for tag in args:
            print('\n==== ' + tag + '\n' + '\n'.join(_tag_targets(tag)))

def run(args):
    for tag in _tag_list():
        print("\n==== " + tag)
        dirs = _tag_targets(tag)
        for dir in dirs:
            print("\n---- " + dir)
            os.system('cd ' + dir + ' && git s')

if len(sys.argv) == 1:
    sys.exit('HELP')

if sys.argv[1] == 'list':
    list(sys.argv[2:])
elif sys.argv[1] == 'add':
    add(sys.argv[2:])
else:
    run(sys.argv)
