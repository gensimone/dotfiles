#!/bin/bash
#
# check the configuration file
# priorities:
# 1) DWM_SB_CONF
# 2) XDG_CONFIG_HOME/dwm-sb/dwm-db.conf
# 3) $HOME/.dwm-sb.conf
#
if [ -n "$DWM_SB_CONF" ]; then
  CONFIG="$DWM_SB_CONF"
elif [ -f "$XDG_CONFIG_HOME/dwm-sb/dwm-sb.conf" ]; then
  CONFIG="$XDG_CONFIG_HOME/dwm-sb/dwm-sb.conf"
else
  CONFIG="$HOME/.dwm-sb.conf"
fi

if ! [ -f "$CONFIG" ]; then
  CONFIG="$(dirname "$0")/dwm-sb.conf"
fi

echo "$CONFIG"
