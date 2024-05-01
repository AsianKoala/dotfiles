#!/bin/sh

yt-dlp --format "ba" --verbose --force-ipv4 --ignore-errors --no-continue --no-overwrites --download-archive archive.log --add-metadata --parse-metadata "%(title)s:%(meta_title)s" --parse-metadata "%(uploader)s:%(meta_artist)s" --all-subs --embed-subs --check-formats --concurrent-fragments 5 --output "%(uploader)s - %(upload_date)s - %(title)s [%(id)s].%(ext)s" --merge-output-format "mkv" --throttled-rate 100K --max-filesize 300m --cookies-from-browser firefox $1 --extract-audio
