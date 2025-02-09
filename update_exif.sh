#!/bin/bash

# Set the directory containing the images
IMAGE_DIR="$1"

# Check if directory is provided
if [ -z "$IMAGE_DIR" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Ensure exiftool is installed
if ! command -v exiftool &> /dev/null; then
    echo "exiftool not found. Install it using 'brew install exiftool'"
    exit 1
fi

# Get the sorted list of files
FILES=($(ls "$IMAGE_DIR" | sort))

# Get the creation date of the first file
FIRST_FILE="${FILES[0]}"
FIRST_DATE=$(stat -f "%Sm" -t "%Y:%m:%d %H:%M:%S" "$IMAGE_DIR/$FIRST_FILE")

# Convert the date to epoch seconds
FIRST_EPOCH=$(date -j -f "%Y:%m:%d %H:%M:%S" "$FIRST_DATE" "+%s")

echo "First file: $FIRST_FILE"
echo "Base timestamp: $FIRST_DATE ($FIRST_EPOCH)"

# Loop through files and update metadata
INDEX=0
for FILE in "${FILES[@]}"; do
    CURRENT_EPOCH=$((FIRST_EPOCH + INDEX))
    NEW_DATE=$(date -r "$CURRENT_EPOCH" "+%Y:%m:%d %H:%M:%S")

    echo "Updating $FILE -> $NEW_DATE"

    # Set EXIF metadata
    exiftool -overwrite_original -DateTimeOriginal="$NEW_DATE" -CreateDate="$NEW_DATE" "$IMAGE_DIR/$FILE"

    ((INDEX++))
done

echo "Done!"