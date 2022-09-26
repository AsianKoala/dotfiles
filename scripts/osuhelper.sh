#!/bin/sh
# configure these two !!
osudir=$HOME/games/osu/
downloaddir=$HOME/downloads

songdir=$osudir/Songs
skindir=$osudir/Skins

song_count=`cd $downloaddir; ls | grep '\.osz' | wc -l`
skin_count=`cd $downloaddir; ls | grep '\.osk' | wc -l`

if [[ $song_count != '0' ]]; then
  echo 'Song(s) found!'
  for file in $downloaddir/*.osz; do
    mv "$file" $songdir
  done
fi

if [[ $skin_count != '0' ]]; then
  echo 'Skin(s) found!'
  for file in $downloaddir/*.osk; do
    filename=$(basename -- "$file")
    base="${filename%.*}"
    mkdir $downloaddir/"$base"
    mv $downloaddir/"$filename" $downloaddir/"$base"
    cd $downloaddir/"$base"
    7z x $downloaddir/"$filename" > /dev/null 2>&1
    rm $downloaddir/"$base"/"$filename"
    cd $downloaddir
    mv $downloaddir/"$base" $skindir
  done
fi

