import os, sys, time
import subprocess

"""
Match .mkv file its respective .ass ass file, then merge it using Mkvmerge library.
Match "filename".mkv with its respective "filename".ass

"""

watchdir = "."

def __execBashCmd__(cmd):

    p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, shell=True)

    while p.poll() is None:
        time.sleep(1)

    #untested
    if (p.returncode):
        print("Mkv merge exit with non-zero code: " + str(p.returncode))
        print("Stdout: " + str(p.stdout) + "Std error: " + str(p.stderr))
        

def main():
    for file in os.listdir(watchdir):
        if (".mkv" not in file):
            print(file)
            continue
        print(file + " detected")
        fsub = file.replace(".mkv", ".ass")
        if (not os.path.isfile(fsub)):
            continue
        bashCommand = "mkvmerge -o " + "'" + file.replace(".mkv", "_sub.mkv") + "' " + "'" +  file + "'" + " " + "'" + fsub + "'"
        print(bashCommand)
        __execBashCmd__(bashCommand)

main()