#!/bin/bash

# Geek Mode Dad image converter
# Converts an original image into a 1200x675 WebP
# suitable for homepage thumbnails and featured images.

if [ -z "$1" ]; then
    echo ""
    echo "Usage:"
    echo "  ./tools/make-image.sh <image>"
    echo ""
    echo "Example:"
    echo "  ./tools/make-image.sh static/images/originals/my-photo.jpg"
    echo ""
    exit 1
fi

INPUT="$1"

if [ ! -f "$INPUT" ]; then
    echo ""
    echo "Error: File not found:"
    echo "$INPUT"
    echo ""
    exit 1
fi

BASENAME="$(basename "$INPUT")"
NAME="${BASENAME%.*}"
OUTPUT="static/images/posts/${NAME}.webp"

mkdir -p static/images/posts

echo ""
echo "Geek Mode Dad Image Converter"
echo "-----------------------------"
echo "Input:  $INPUT"
echo "Output: $OUTPUT"
echo ""

magick "$INPUT" \
    -auto-orient \
    -resize "1200x675^" \
    -gravity center \
    -extent 1200x675 \
    -quality 82 \
    "$OUTPUT"

if [ $? -ne 0 ]; then
    echo ""
    echo "Error: Image conversion failed."
    echo ""
    exit 1
fi

SIZE=$(du -h "$OUTPUT" | cut -f1)

echo "Done!"
echo ""
echo "Image:"
echo "  $OUTPUT"
echo ""
echo "Size:"
echo "  1200 x 675"
echo ""
echo "File size:"
echo "  $SIZE"
echo ""
echo "Add this to your post:"
echo ""
echo "coverImg = \"/images/posts/${NAME}.webp\""
echo ""