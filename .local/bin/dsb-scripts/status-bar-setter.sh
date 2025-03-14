#!/bin/bash

HERE="$(dirname "$0")"
STATUS_BAR_FILES="$HERE/status-bar-files"
DELIMITER="󰇝"

CONFIG="$("$HERE/status-bar-conf.sh")"

status_bar=""
# files=$(find "$STATUS_BAR_FILES" -type f)
# while IFS= read -r file; do
#   value="$(cat "$file")"
#   [ "$value" ] && status_bar="$status_bar $DELIMITER $value"
# done <<< "$files"

while IFS= read -r module; do
  module_name="$(echo "$module" | awk '{ print $1 }')"
  file="$STATUS_BAR_FILES/$module_name"
  value="$(cat "$file")"
  [ "$value" ] && status_bar="$status_bar $DELIMITER $value"
done < "$CONFIG"

xsetroot -name "$status_bar"
