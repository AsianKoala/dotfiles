import os
import json

colors_file = '~/.cache/wal/colors.jso'
f = open(colors_file)
data = json.load(f)

for color in data['colors']:
    print(color)
