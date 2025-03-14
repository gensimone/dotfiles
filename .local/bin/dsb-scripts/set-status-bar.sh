#!/bin/sh

fsmon() {
	ROOTPART=$(df -h | awk '/\/$/ { print $4 }')
	echo "  $ROOTPART"
}

pkgs() {
  num_pkgs="$(xbps-install --sync --update --dry-run | wc -l)"
  echo " $num_pkgs"
}

bluetooth() {
  if [ "$(which bluetoothctl)" ]; then
    connected="$(bluetoothctl devices Connected)"
    if [ "$connected" = "No default controller available" ] || ! [ "$connected" ]; then
      echo ""
    else
      connected="$(echo "$connected" | head -1 | cut -d ' ' -f 3)"
      device_battery="$(bluetoothctl info | grep Battery | cut -d ' ' -f 4 | sed 's/[()]//g')%"
      echo "󰂯 $connected $device_battery"
    fi
  fi
}

network() {
	route=$(ip route | awk '/default/' | head -n 1)
	if [ -z "$route" ]; then
		echo "󱘖"
  else
    interface=$(echo "$route" | cut -d ' ' -f 5)
    ssid="$(iw dev "$interface" info | grep ssid | cut -d ' ' -f 2)"
    conntype=$(echo "$interface" | awk '{ print substr($1,1,1) }')
    ip=$(echo "$route" | cut -d ' ' -f 9)
    if [ "$conntype" = "e" ]; then
      echo "󰈀  [$ip]"
    else
      echo "󰖩  [$ip] [$ssid]"
    fi
	fi
}

volume_alsa() {
	mono=$(amixer -M sget Master | grep Mono: | awk '{ print $2 }')

	if [ -z "$mono" ]; then
		muted=$(amixer -M sget Master | awk 'FNR == 6 { print $7 }' | sed 's/[][]//g')
		vol=$(amixer -M sget Master | awk 'FNR == 6 { print $5 }' | sed 's/[][]//g; s/%//g')
	else
		muted=$(amixer -M sget Master | awk 'FNR == 5 { print $6 }' | sed 's/[][]//g')
		vol=$(amixer -M sget Master | awk 'FNR == 5 { print $4 }' | sed 's/[][]//g; s/%//g')
	fi

	if [ "$muted" = "off" ]; then
		echo " "
	else
		if [ "$vol" -ge 65 ]; then
			echo "  $vol%"
		elif [ "$vol" -ge 40 ]; then
			echo " $vol%"
		elif [ "$vol" -ge 0 ]; then
			echo " $vol%"
		fi
	fi
}

clock() {
	date=$(date +"%D")
	time=$(date +"%H:%M")

	echo "$date $time"
}

battery() {
	bat="$(ls /sys/class/power_supply | grep BAT)"
	if [ "$bat" ]; then
		capacity="$(cat "/sys/class/power_supply/$bat/capacity")"
		status="$(cat "/sys/class/power_supply/$bat/status")"
    remaining_time="$(acpi -b | cut -d ',' -f 3 | cut -c 2-)"
		if [ "$capacity" -lt 10 ]; then
			icon=$(if [ "$status" = "Charging" ]; then echo 󰢜; else echo 󰁺; fi)
		elif [ "$capacity" -lt 20 ]; then
			icon=$(if [ "$status" = "Charging" ]; then echo 󰂆; else echo 󰁻; fi)
		elif [ "$capacity" -lt 30 ]; then
			icon=$(if [ "$status" = "Charging" ]; then echo 󰂇; else echo 󰁼; fi)
		elif [ "$capacity" -lt 40 ]; then
			icon=$(if [ "$status" = "Charging" ]; then echo 󰂈; else echo 󰁽; fi)
		elif [ "$capacity" -lt 50 ]; then
			icon=$(if [ "$status" = "Charging" ]; then echo 󰢝; else echo 󰁾; fi)
		elif [ "$capacity" -lt 60 ]; then
			icon=$(if [ "$status" = "Charging" ]; then echo 󰂉; else echo 󰁿; fi)
		elif [ "$capacity" -lt 70 ]; then
			icon=$(if [ "$status" = "Charging" ]; then echo 󰢞; else echo 󰂀; fi)
		elif [ "$capacity" -lt 80 ]; then
			icon=$(if [ "$status" = "Charging" ]; then echo 󰂊; else echo 󰂁; fi)
		elif [ "$capacity" -lt 90 ]; then
			icon=$(if [ "$status" = "Charging" ]; then echo 󰂋; else echo 󰂂; fi)
		else
			icon=$(if [ "$status" = "Charging" ]; then echo 󰂅; else echo 󰁹; fi)
		fi

    echo "$icon $capacity% [$remaining_time]"

	else
		# echo "󱉝 No battery"
    echo ""
	fi
}

set_status_bar() {
  if [ "$1" ]; then
    status_bar="$status_bar $2 $1"
  fi
}

div="󰇝"
status_bar=""
set_status_bar "$(battery)" "$div"
set_status_bar "$(temperature)" "$div"
set_status_bar "$(fsmon)" "$div"
set_status_bar "$(ram)" "$div"
set_status_bar "$(cpu)" "$div"
set_status_bar "$(bluetooth)" "$div"
set_status_bar "$(network)" "$div"
set_status_bar "$(volume_alsa)" "$div"
set_status_bar "$(pkgs)" "$div"
set_status_bar "$(clock)" "$div"

xsetroot -name "$status_bar"
