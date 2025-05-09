#!/bin/bash
set -e

file_path=$1
if [[ -z "$file_path" ]]; then
    exit 0
fi

now=$(date +"%Y_%m_%d_%H%M")
parent=$(dirname "$file_path")
extension=""
fname=$(basename "$file_path")

if [[ -z "$fname" ]]; then
    exit 0
fi

extension="$(rev <<< $fname | cut -f1 -d. | rev)"

if [[ "$extension" != "$fname" && ".$extension" != "$fname" ]]; then
    fname=$(basename "$fname" ".$extension")
else
    extension=""
fi

if [[ -z "$extension" ]]; then
    # echo "$file_path" "${parent}/${fname}_${now}"
    cp "$file_path" "${parent}/${fname}_${now}"
else
    # echo "$file_path" "${parent}/${fname}_${now}.${extension}"
    cp "$file_path" "${parent}/${fname}_${now}.${extension}"
fi
