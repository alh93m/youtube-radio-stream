#!/bin/bash

while true
do
  ffmpeg -re \
  -loop 1 -framerate 1 -i bg.jpeg \
  -i "$RADIO_URL" \
  -map 0:v:0 -map 1:a:0 \
  -vf "scale=4800:2700" \
  -c:v libx264 -preset veryfast -tune stillimage \
  -c:a aac -b:a 128k \
  -pix_fmt yuv420p \
  -shortest \
  -fflags +genpts+discardcorrupt \
  -err_detect ignore_err \
  -reconnect 1 -reconnect_streamed 1 -reconnect_on_network_error 1 \
  -reconnect_delay_max 5 \
  -rw_timeout 15000000 \
  -f flv \
  "$YOUTUBE_URL"

  echo "Stream disconnected... reconnecting in 5s"
  sleep 5
done
