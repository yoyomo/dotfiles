import subprocess
import os

playlists = [
    {"name": "gc | african", "id": "PL4xpJlmNQtFob3k85b9DVLYBA6rD9CrVS"},
    {"name": "gc | bachata", "id": "PL4xpJlmNQtFquh8apCSAxGBprZv21Vijk"},
    {"name": "gc | country", "id": "PL4xpJlmNQtFqjV1GrkM6xpzZ5UOzxG4Sq"},
    {"name": "gc | culture", "id": "PL4xpJlmNQtFoyerS9l1cpekZ0ah87R3zk"},
    {"name": "gc | cumbia", "id": "PL4xpJlmNQtFqbKnyWoudcIQQuhEUcV4Qm"},
    {"name": "gc | funk", "id": "PL4xpJlmNQtFo0stL7_zgn9x33DGVWmlko"},
    {"name": "gc | house", "id": "PL4xpJlmNQtFocm9Wy6zj-dGu98Nm560lq"},
    {"name": "gc | indian", "id": "PL4xpJlmNQtFpk5hSCtHaY6o6k-y-sTYA1"},
    {"name": "gc | jazz", "id": "PL4xpJlmNQtFr1-5lm_TOTtr2Qs4u86lr9"},
    {"name": "gc | latin", "id": "PL4xpJlmNQtFrhJd4zhdSKfID3ZkBcNpwx"},
    {"name": "gc | merengue", "id": "PL4xpJlmNQtFrXIh1BFsL3UIob-ym_FNcj"},
    {"name": "gc | salsa", "id": "PL4xpJlmNQtFrQCiLyZsAEvIbx1OyS9bgP"},
    {"name": "gc | trippy", "id": "PL4xpJlmNQtFpLeGggg2rozLP0YnXKZLDZ"},
    {"name": "hd | dancehall", "id": "PL4xpJlmNQtFrkoJrpZaRTb3vIORFA9V2-"},
    {"name": "hd | dembow", "id": "PL4xpJlmNQtFoRAXv2pWAn6lKh2B4nQfDl"},
    {"name": "hd | dnb", "id": "PL4xpJlmNQtFpSGDKoP4heY9OriZuzQoLo"},
    {"name": "hd | edm", "id": "PL4xpJlmNQtFrRyR1F52x2oLgFTsvLEH3M"},
    {"name": "hd | eurodance", "id": "PL4xpJlmNQtFqrDi7ym32tgQf1Ut5_eAAY"},
    {"name": "hd | reggaeton", "id": "PL4xpJlmNQtFrcpkpadJLUQrar9LuQgXtP"},
    {"name": "hd | tech house", "id": "PL4xpJlmNQtFpsHPbLQK6QYSDj_EQkOmic"},
    {"name": "ue | ambient", "id": "PL4xpJlmNQtFrNEBv6kt2IQMWxGl2rmP6I"},
    {"name": "ue | electronic", "id": "PL4xpJlmNQtFq2-wk85MLBdFmvfQwyqSZz"},
    {"name": "ue | techno", "id": "PL4xpJlmNQtFoyjmHYJzv3WozV3zi88HEG"},
    {"name": "wc | ballad", "id": "PL4xpJlmNQtFpaQ6TDa74dsM73f-nHa0Zt"},
    {"name": "wc | chillhop", "id": "PL4xpJlmNQtFoCx4NUyRAdXEvEoAiFsDKD"},
    {"name": "wc | alt cool", "id": "PL4xpJlmNQtFod5uq452L4MD_vGFoEQuFT"},
    {"name": "wc | reggae", "id": "PL4xpJlmNQtFqTylKy0nL6RKP469zA4R6v"},
    {"name": "wc | rnb", "id": "PL4xpJlmNQtFqFX1GIdej4QyI9NHcrM8Ev"},
    {"name": "x | hiphop", "id": "PL4xpJlmNQtFrcjjKlPTjDMuD7QQuoY1Ue"},
    {"name": "x | alt", "id": "PL4xpJlmNQtFpNYPZnuQsgNtfNPU6mPG6j"},
    {"name": "x | phonk", "id": "PL4xpJlmNQtFqpWGL-OApxT_ruOdybzoTb"},
    {"name": "x | pop", "id": "PL4xpJlmNQtFonC2Eq96pBBB-lSCnBX_FP"},
]

home_path = os.path.expanduser("~/iCloudDrive/Music/DJ/genres")


def go_to_dir(dir):
    if not os.path.exists(dir):
        os.makedirs(dir)
        print(f"{dir} directory created")
    os.chdir(dir)

updated_playlists = []
for playlist in playlists:
    os.chdir(home_path)
    [vibe_dir, genre_dir] = playlist["name"].split(" | ")
    go_to_dir(vibe_dir)
    go_to_dir(genre_dir)
    prev_file_count = len([file for file in os.listdir() if not file.startswith('.')])
    subprocess.run(["time", "yt-dlp" ,"--download-archive", "../../downloaded.txt",
    "--merge-output-format", "mp4", "-S", "vcodec:h264,res,acodec:aac",
    "--embed-thumbnail", "--add-metadata", "--compat-options", "embed-thumbnail-atomicparsley",
    "-x", "--audio-format", "m4a",
    "-i", playlist["id"]])
    cur_file_count = len([file for file in os.listdir() if not file.startswith('.')])
    if cur_file_count > prev_file_count:
        updated_playlists.append(playlist["name"])

updated_playlists_str = "\n".join(updated_playlists)
print(f"Updated Playlists: {len(updated_playlists)}\n{updated_playlists_str}")
