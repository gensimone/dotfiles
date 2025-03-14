#!/bin/bash

HERE="$(dirname "$0")"

script="$1"
if [ -z "$script" ]; then
  echo "Provide a script"
  exit 1
fi

script="$HERE/status-bar-scripts/$script"

if ! [ -f "$script" ]; then
  echo "$script doesn't exist"
  exit 1
fi

$script > "$HERE/status-bar-files/$1"
