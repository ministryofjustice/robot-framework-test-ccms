import os
import sys
import shutil
import getopt
from robot.libdoc import libdoc
from robot.libraries.BuiltIn import BuiltIn

argv = sys.argv[1:]

try:
    opts, args = getopt.getopt(argv,"i:o:",["ifolder=","ofolder="])
except getopt.GetoptError:
    BuiltIn().log_to_console('generate_library_documentation.py -i <inputfile> -o <outputfile>')
    sys.exit(2)

for opt, arg in opts:
    if opt in ("-i", "--ifile"):
        in_path = os.path.realpath(arg)
    elif opt in ("-o", "--ofile"):
        out_path = os.path.realpath(arg)

if not os.path.exists(in_path):
    raise "The in path does not exist: " + in_path

shutil.rmtree(out_path, ignore_errors=True)
for root, dirs, files in os.walk(in_path):
    for file in files:
        splitext = os.path.splitext(file)
        if splitext[1] == '.robot' or splitext[1] == '.py':
            rel_path = os.path.relpath(root, in_path)
            in_file = os.path.join(root, file)
            out_dir = os.path.normpath(os.path.join(out_path, rel_path))
            out_file = os.path.join(out_dir, splitext[0] + '.html')
            directory = os.path.basename(os.path.dirname(out_file))

            if not os.path.exists(out_dir) and out_file:
                os.makedirs(out_dir)
                f = open(out_dir + '\\index.html', "a")
                f.write('<style> body { font-family: sans-serif; font-size: 0.9em; }</style><h1>' + directory + ' files with keywords</h1>')
                f.close()

            if out_file:
                f = open(out_dir + '\\index.html', "a")
                f.write('<p><a style="font-family: sans-serif; font-size: 0.9em" href="./' + splitext[0] + '.html">' + splitext[0] + '</a></p>')
                f.close()

            libdoc(in_file, out_file, docformat='ROBOT')
