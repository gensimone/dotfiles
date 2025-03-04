pipewire &
picom --config $HOME/.picomrc &
dunst -config $HOME/.dunstrc &
pidof batsignal >/dev/null || batsignal -b -m 3 -e
xautolock -time 5 -locker slock &
sxhkd -c $HOME/.sxhkdrc &
feh --bg-fill $HOME/.wallpapers/void-linux-wallpaper.png
dwm-status-bar-update-daemon &
xsettingsd &
exec dbus-run-session dwm
