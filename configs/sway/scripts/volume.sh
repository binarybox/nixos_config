#!/run/current-system/sw/bin/bash
# Volume notification: Pulseaudio and dunst
# inspired by gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a

notify_id=507

function get_volume_icon {
    if [ "$1" -lt 34 ]
    then
        echo "󰕿"
    elif [ "$1" -lt 67 ]
    then
        echo "󰖀"
    elif [ "$1" -le 100 ]
    then
        echo "󰕾"
    else
        echo "󱄡"
    fi
}

function notify_volume {
    dunstify -u low -r $notify_id -t 100 -h string:x-canonical-private-synchronous:audio -h int:value:"$1" "Volume: $2"
}

function volume_notification {
    volume=`ponymix get-volume`
    vol_icon=`get_volume_icon $volume`
    notify_volume $volume $vol_icon
}

function mute_notification {
    muted=$(pacmd list-sinks | awk '/muted/ { print $2 }')
    echo $muted
    if [ $muted == 'yes' ]
    then
        notify_volume 0 󰖁
    else
        volume=`ponymix get-volume`
        vol_icon=`get_volume_icon $volume`
        notify_volume $volume $vol_icon
    fi
}

case $1 in
    up)
        pactl set-sink-volume @DEFAULT_SINK@ +5%
        volume_notification
        ;;
    down)
        pactl set-sink-volume @DEFAULT_SINK@ -5%
        volume_notification
	    ;;
    mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        mute_notification
        ;;
    *)
        echo "Usage: $0 up | down | mute"
        ;;
esac