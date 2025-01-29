import subprocess
import os

playlists = [
    {"name": "gc | african", "id": "PL4Zt7C5F2p1L3y9QJ1Z6s3Zl4Z2K1b1J9"},
]

home_path = os.path.expanduser('~/iCloudDrive/Music/DJ/genres')

def go_to_dir(dir):
    if not os.path.exists(dir):
        os.makedirs(dir)
        print(f"{dir} directory created")
    os.chdir(dir)

for playlist in playlists:
    os.chdir(home_path)
    [vibe_dir, genre_dir] = playlist['name'].split(' | ')
    go_to_dir(vibe_dir)
    go_to_dir(genre_dir)
    subprocess.run(['/bin/bash', '-i', '-c', f"yt -i {playlist['id']}"])
