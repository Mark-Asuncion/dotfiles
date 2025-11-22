#!/bin/bash
set -e

file_path=""
use_move=0
for arg in "$@"; do
  case "$arg" in
    "-m")
      use_move=1
      ;;
    *)
        file_path="$arg"
      ;;
  esac
done

function usage {
    echo "USAGE:"
    echo "./bkp.sh [-m] <file_path>"
}

if [[ -z "$file_path" ]]; then
    usage
    exit 0
fi

now=$(date +"%Y-%m-%dT%H%M")
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

out_path=""
if [[ -z "$extension" ]]; then
    out_path="${parent}/${fname}_${now}"
else
    out_path="${parent}/${fname}_${now}.${extension}"
fi

if [[ $use_move -eq 1 ]]; then
    # echo "move $file_path  $out_path"
    mv "$file_path" "$out_path"
else
    # echo "copy $file_path  $out_path"
    cp "$file_path" "$out_path"
fi
