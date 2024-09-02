xsetwacom set 'Wacom Intuos S Pen stylus' MapToOutput HMDI-1
sh ~/.scripts/my-dbus-launch.sh &
xmodmap ~/.Xmodmap
sh ~/.scripts/screen-scale.sh

exec i3
