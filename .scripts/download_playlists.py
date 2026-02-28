import subprocess
import os
import sys
import time
from constants import playlists

home_path = os.path.expanduser("~/iCloudDrive/Music/DJ")
start_index = int(sys.argv[1]) if len(sys.argv) > 1 else 0

YT_DLP_BASE = [
    "yt-dlp",
    "--cookies-from-browser", "safari",
    "--download-archive", "downloaded.txt",
    "--merge-output-format", "mp4",
    "-S", "vcodec:h264,res,acodec:aac",
    "--embed-thumbnail", "--add-metadata",
    "--compat-options", "embed-thumbnail-atomicparsley",
    "-x", "--audio-format", "m4a",
    "-i",
    "--retries", "10",
    "--retry-sleep", "http:30",
    "--extractor-retries", "5",
]

def go_to_dir(dir):
    if not os.path.exists(dir):
        os.makedirs(dir)
        print(f"{dir} directory created")
    os.chdir(dir)

updated_playlists = []
for i, playlist in enumerate(playlists):
    if i < start_index:
        continue
    [vibe_dir, genre_dir] = playlist["name"].split(" | ")
    if vibe_dir == "set":
        vibe_dir = "sets"
    else:
        vibe_dir = f"genres/{vibe_dir}"
    os.chdir(home_path)
    go_to_dir(vibe_dir)
    go_to_dir(genre_dir)
    prev_file_count = len([file for file in os.listdir() if not file.startswith('.')])

    print(f"\n[{i+1}/{len(playlists)}] Downloading: {playlist['name']}")
    start = time.time()
    subprocess.run(YT_DLP_BASE + [playlist["id"]])
    elapsed = time.time() - start
    print(f"  Done in {elapsed:.0f}s")

    cur_file_count = len([file for file in os.listdir() if not file.startswith('.')])
    if cur_file_count > prev_file_count:
        updated_playlists.append(playlist["name"])

    if i < len(playlists) - 1:
        time.sleep(2)

updated_playlists_str = "\n".join(updated_playlists)
print(f"\nUpdated Playlists: {len(updated_playlists)}\n{updated_playlists_str}")
