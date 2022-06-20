#!C:\Users\Me\AppData\Local\Programs\Python\Python310\python.exe

import sys
import subprocess
def main():
    """
    print("Number of arguments: %d", len(sys.argv))
    print("Argument list: %s" % str(sys.argv))
    print(sys.argv[1])
    sys.exit(1)
    """
    subprocess.run(["pip", "freeze", ">", "python_requirements.txt"], shell=True)
    subprocess.run(["git", "add", "python_requirements.txt"], shell=True)


if __name__=="__main__":
    main()
