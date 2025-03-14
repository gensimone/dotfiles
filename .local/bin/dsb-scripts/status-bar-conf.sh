#!/bin/bash
#
# check the configuration file
# priorities:
# 1) DWM_STATUS_BAR_CONFIG
# 2) XDG_CONFIG_HOME/dwm-status-bar/config
# 3) $HOME/.dwm-status-bar.config
#
if [ -n "$DWM_STATUS_BAR_CONFIG" ]; then
  CONFIG="$DWM_STATUS_BAR_CONFIG"
elif [ -f "$XDG_CONFIG_HOME/dwm-status-bar/dwm-status-bar.conf" ]; then
  CONFIG="$XDG_CONFIG_HOME/dwm-status-bar/dwm-status-bar.conf"
else
  CONFIG="$HOME/.dwm-status-bar.conf"
fi

if ! [ -f "$CONFIG" ]; then
  CONFIG="$(dirname "$0")/dwm-status-bar.conf"
fi

echo "$CONFIG"
