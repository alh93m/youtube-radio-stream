#!/bin/bash

while true
do
  ffmpeg -re \
  -i "$RADIO_URL" \
  -loop 1 -i bg.png
  -c:v libx264 -preset ultrafast -tune stillimage \
  -c:a aac -b:a 128k \
  -shortest \
  -f flv \
  "$YOUTUBE_URL"

  sleep 5
done
