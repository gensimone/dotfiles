#!/bin/bash

HERE="$(dirname "$0")"

script="$1"
if [ -z "$script" ]; then
  echo "Provide a script" >&2
  exit 1
fi

script="$HERE/modules/$script"

if ! [ -f "$script" ]; then
  echo "$script doesn't exist" >&2
  exit 1
fi

if $script > "$HERE/results/$1"; then
  "$HERE/dwm-sb-set.sh"
fi
