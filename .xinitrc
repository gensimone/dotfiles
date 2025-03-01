pipewire &
picom &
dunst -config $HOME/.dunstrc &
pidof batsignal >/dev/null || batsignal -b -m 3 -e
xautolock -time 5 -locker slock &
sxhkd -c $HOME/.sxhkdrc &
feh --bg-fill $HOME/Pictures/void-linux-wallpaper.png
$HOME/.dwm/status_bar_daemon.sh &
xsettingsd &
exec dwm
