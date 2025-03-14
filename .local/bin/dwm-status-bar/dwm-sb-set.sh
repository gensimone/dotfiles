#!/bin/bash

HERE="$(dirname "$0")"
RESULTS="$HERE/results"
DELIMITER="󰇝"

CONFIG="$("$HERE/dwm-sb-get-conf.sh")"

status_bar=""
while IFS= read -r module; do
  module_name="$(echo "$module" | awk '{ print $1 }')"
  file="$RESULTS/$module_name"
  value="$(cat "$file")"
  [ "$value" ] && status_bar="$status_bar $DELIMITER $value"
done < "$CONFIG"

xsetroot -name "$status_bar"
