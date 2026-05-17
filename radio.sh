#!/bin/bash

while true
do
  ffmpeg -re \
  -i "$RADIO_URL" \
  -f lavfi -i color=c=black:s=1280x720:r=1 \
  -c:v libx264 -preset ultrafast -tune stillimage \
  -c:a aac -b:a 128k \
  -shortest \
  -f flv \
  "$YOUTUBE_URL"

  sleep 5
done
