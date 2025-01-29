import subprocess
import os

os.chdir(os.path.expanduser('iCloudDrive/Music/DJ/genres'))
dir_path = "gc"
if not os.path.exists(dir_path):
    os.makedirs(dir_path)
    print(f"{dir_path} directory created")


subprocess.run(['/bin/bash', '-i', '-c', "yt"])
subprocess.run(['/bin/bash', '-i', '-c', "echo \"done!\""])