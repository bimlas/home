import os
import glob
import sys

DATABASE = os.path.expanduser('~/.shdo/')

def _tag_list():
    return(os.listdir(DATABASE))

def _tag_targets(tag):
    return([line.rstrip('\n') for line in open(DATABASE + tag)])

def add(args):
    pass

def list(args):
    if len(args) == 0:
        items = _tag_list()
    else:
        items = [['\n==== ' + tag] + _tag_targets(tag) for tag in args]
        # Flatten list
        items = [item for sublist in items for item in sublist]
    for item in items:
        print(item)

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
