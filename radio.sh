#!/bin/bash

while true
do
  ffmpeg -re \
  -loop 1 -framerate 1 -i bg.jpeg \
  -user_agent "Mozilla/5.0" \
  -reconnect 1 -reconnect_streamed 1 -reconnect_on_network_error 1 \
  -reconnect_delay_max 5 \
  -i "$RADIO_URL" \
  -map 0:v:0 -map 1:a:0 \
  -c:v libx264 -preset veryfast -tune stillimage \
  -vf "scale=1280:720" \
  -c:a aac -b:a 128k \
  -pix_fmt yuv420p \
  -shortest \
  -f flv \
  "$YOUTUBE_URL"

  echo "Stream disconnected... restarting in 5s"
  sleep 5
done
