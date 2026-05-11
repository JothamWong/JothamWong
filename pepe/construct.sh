#!/bin/bash

make_gif () {
  input_pattern=$1
  output=$2

  # Temporary palette
  ffmpeg -y -framerate 6 -pattern_type glob -i "$input_pattern" \
    -vf "palettegen" palette.png

  ffmpeg -y -framerate 6 -pattern_type glob -i "$input_pattern" -i palette.png \
    -filter_complex "paletteuse=dither=bayer:bayer_scale=5" \
    -loop 0 "$output"

  rm palette.png
}

FRAME_W=192
FRAME_H=208

extract_row () {
  row=$1
  width=$2
  name=$3

  y_offset=$((row * FRAME_H))

  magick spritesheet.webp \
    -crop ${width}x${FRAME_H}+0+${y_offset} +repage \
    -crop ${FRAME_W}x${FRAME_H} +repage \
    ${name}_%02d.png

  make_gif "${name}_*.png" "${name}.gif"
  rm ${name}_*.png
}

extract_row 0 1152 idle
extract_row 1 1536 running_right
extract_row 2 1536 running_left
extract_row 3 768  waving
extract_row 4 960  jumping
extract_row 5 1536 sad
extract_row 6 1152 waiting
extract_row 7 1152 running
extract_row 8 1152 review