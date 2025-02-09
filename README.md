# Overview
## The Problem
My wife and I have received family photos from a photograper a couple of times.
When I download the photos, no exif data is included and date taken on all the photos just default to the downloaded date.
Then when I upload to google photos the photos do not sort in the order that they were taken and they are all jumbled based on an unknown sort order in google photos.

## The Solution
This script sorts that the files in order and then adds 1 second to the timestamp based on the sort index of file.
Then when the files are uploaded to google photos they are in the correct sort order.

# How to Run from Mac Command Line:
- Install exiftool if not already installed: ```brew install exiftool```   _*home brew required_
- Save the script as ```update_exif.sh```
- Make it executable: ```chmod +x update_exif.sh```
- Run it with the folder path: ```./update_exif.sh "/path/to/photos"```
This will set the EXIF metadata for each file, increasing the time by one second per file, based on the first file's creation date. 🚀
