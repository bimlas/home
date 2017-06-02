import os
import glob
import sys

DATABASE = os.path.expanduser('~/.shdo/')
TAGS_PREFIX = '!'

if not os.path.exists(DATABASE):
    os.makedirs(DATABASE)

def _parse_arguments(args):
    args_copy = args[:]
    tags = []
    while len(args_copy) > 0 and args_copy[0][0] == TAGS_PREFIX:
        # Remove '@' form tag name.
        tags.append(args_copy.pop(0)[1:])
    return({'tags': tags, 'other': args_copy})

def _all_tags():
    return(os.listdir(DATABASE))

def _tag_targets(tag):
    if not os.path.exists(DATABASE + tag):
        print('TAG NOT EXISTS: ' + tag)
        return([])
    return([line.rstrip('\n') for line in open(DATABASE + tag)])

def add(args):
    tag = args[0]
    targets = args[1:]
    with open(DATABASE + tag, "a") as targets_file:
        targets_file.write('\n'.join([os.path.abspath(os.path.expanduser(target)) for target in targets]) + '\n')

def list(args):
    args = _parse_arguments(args)
    if len(args['other']) > 0:
        print('Nothing to do with "' + ' '.join(args['other']) + '"')
    if len(args['tags']) == 0:
        print('==== ALL TAGS\n' + '\n'.join(_all_tags()))
    else:
        for tag in args['tags']:
            print('\n==== ' + tag + '\n' + '\n'.join(_tag_targets(tag)))

def run(args):
    args = _parse_arguments(args)
    for tag in args['tags']:
        print("\n==== " + tag)
        dirs = _tag_targets(tag)
        for dir in dirs:
            print("\n---- " + dir)
            os.system('cd ' + dir + ' && ' + ' '.join(args['other']))
            # os.system('cd ' + dir + ' && git s')

if len(sys.argv) == 1:
    sys.exit('HELP')

if sys.argv[1] == 'list':
    list(sys.argv[2:])
elif sys.argv[1] == 'add':
    add(sys.argv[2:])
else:
    run(sys.argv[1:])
