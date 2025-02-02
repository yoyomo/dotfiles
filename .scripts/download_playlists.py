import subprocess
import os
from constants import playlists

home_path = os.path.expanduser("~/iCloudDrive/Music/DJ")

def go_to_dir(dir):
    if not os.path.exists(dir):
        os.makedirs(dir)
        print(f"{dir} directory created")
    os.chdir(dir)

updated_playlists = []
for playlist in playlists:
    [vibe_dir, genre_dir] = playlist["name"].split(" | ")
    if vibe_dir == "set":
        vibe_dir = f"sets"
    else:
        vibe_dir = f"genres/{vibe_dir}"
    os.chdir(home_path)
    go_to_dir(vibe_dir)
    go_to_dir(genre_dir)
    prev_file_count = len([file for file in os.listdir() if not file.startswith('.')])
    subprocess.run(["time", "yt-dlp" , "--download-archive",
    *(["downloaded.txt"] if vibe_dir == "sets" else ["../../downloaded.txt"]),
    "--merge-output-format", "mp4", "-S", "vcodec:h264,res,acodec:aac",
    "--embed-thumbnail", "--add-metadata", "--compat-options", "embed-thumbnail-atomicparsley",
    "-x", "--audio-format", "m4a",
    "-i", playlist["id"]])
    cur_file_count = len([file for file in os.listdir() if not file.startswith('.')])
    if cur_file_count > prev_file_count:
        updated_playlists.append(playlist["name"])

updated_playlists_str = "\n".join(updated_playlists)
print(f"Updated Playlists: {len(updated_playlists)}\n{updated_playlists_str}")
