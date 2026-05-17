#!/bin/bash

while true
do
  ffmpeg \
    -reconnect 1 \
    -reconnect_streamed 1 \
    -reconnect_at_eof 1 \
    -reconnect_delay_max 10 \
    -rw_timeout 15000000 \
    -thread_queue_size 8192 \
    -i "$RADIO_URL" \
    -loop 1 -framerate 30 -i bg.png \
    -map 1:v:0 -map 0:a:0 \
    -vf "scale=1080:1920:force_original_aspect_ratio=decrease,pad=1080:1920:(ow-iw)/2:(oh-ih)/2" \
    -c:v libx264 \
    -preset veryfast \
    -tune stillimage \
    -pix_fmt yuv420p \
    -r 30 \
    -g 60 \
    -keyint_min 60 \
    -sc_threshold 0 \
    -b:v 3500k \
    -maxrate 3500k \
    -bufsize 7000k \
    -c:a aac \
    -b:a 128k \
    -ar 44100 \
    -ac 2 \
    -af "aresample=async=1000:min_hard_comp=0.100:first_pts=0" \
    -fflags +genpts+discardcorrupt \
    -flags +global_header \
    -max_muxing_queue_size 4096 \
    -f flv \
    "$YOUTUBE_URL"

  echo "======================================"
  echo " Stream disconnected - reconnecting "
  echo "======================================"

  sleep 3
done
