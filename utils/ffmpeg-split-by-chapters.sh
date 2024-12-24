#!/bin/sh -efu

# modified from this: https://stackoverflow.com/a/53553938

input="$1"

# Extract the file title and chapter information
metadata_info=$(ffprobe \
    -v error \
    -print_format json \
    -show_format \
    -show_chapters \
    "$input")

file_title=$(echo "$metadata_info" | jq -r '.format.tags.title // "Untitled File"')

track_number=1

# Process each chapter
echo "$metadata_info" | jq -c '.chapters[]' | while read -r chapter_data; do
    start=$(echo "$chapter_data" | jq -r '.start_time')
    end=$(echo "$chapter_data" | jq -r '.end_time')
    chapter_title=$(echo "$chapter_data" | jq -r '.tags.title // "Untitled Chapter"')

    # Combine file title and chapter title
    combined_title="${file_title} - ${chapter_title}"

    # Process each chapter with ffmpeg
    ffmpeg \
        -nostdin \
        -ss "$start" -to "$end" \
        -i "$input" \
        -c copy \
        -map 0 \
        -map_chapters -1 \
        -metadata title="$combined_title" \
        -metadata track="$track_number" \
        "${input%.*} - ${chapter_title}.${input##*.}"

    # Updating the track number
    track_number=$((track_number + 1))
done
