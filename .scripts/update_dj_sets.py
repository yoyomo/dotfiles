import subprocess
import os

os.chdir(os.path.expanduser('~/iCloudDrive/Music/DJ/genres'))
# TODO: get all playlists titles & ids into their dirs
dir_path = "gc"
if not os.path.exists(dir_path):
    os.makedirs(dir_path)
    print(f"{dir_path} directory created")

# TODO: download the playlists
subprocess.run(['/bin/bash', '-i', '-c', 'yt'])
