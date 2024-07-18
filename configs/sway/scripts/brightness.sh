#!/run/current-system/sw/bin/bash

# Volume notification: Pulseaudio and dunst
# inspired by gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a

notify_id=507

function get_brightness_icon {
    if [ "$1" -lt 5 ]
    then
        echo "󰃞"
    elif [ "$1" -lt 10 ]
    then
        echo "󰃟"
    elif [ "$1" -le 15 ]
    then
        echo "󰃠"
    else
        echo "󱄡"
    fi
}

function brightness_notification {
    brightness=`brightnessctl | awk '/Current brightness:/ { print $3 }'`
    brightness_icon=`get_brightness_icon $brightness`
    dunstify -u low -r $notify_id -h string:x-canonical-private-synchronous:audio -h int:value:"$(( $brightness * 100 / 15 ))" "Brightness: $brightness_icon" -t 500
}

case $1 in
    up)
        brightnessctl s 1+
        brightness_notification
        ;;
    down)
        brightnessctl s 1-
        brightness_notification
	    ;;
    *)
        echo "Usage: $0 up | down | mute"
        ;;
esac
