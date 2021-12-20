#! /bin/sh
# save it into /usr/lib/scripts/firewall.sh
# and add into scheduled tasks as
# */5 * * * * /usr/lib/scripts/firewall.sh timetable
# it requires modules iptables-mod-filter and bd

NOW=$(date +"%H:%M")
TIMETABLE="07:55,10:00 12:00,18:00 20:30,22:00"

status_file=/tmp/firewall_status

blocked_pattern="youtubei.googleapis.com"
blocked_pattern="$blocked_pattern googlevideo.com"
blocked_pattern="$blocked_pattern ytimg-edge-static.l.google.com"
blocked_pattern="$blocked_pattern i.ytimg.com"
blocked_pattern="$blocked_pattern youtube-ui.l.google.com"
blocked_pattern="$blocked_pattern www.youtube.com"
blocked_pattern="$blocked_pattern googleapis.l.google.com"
blocked_pattern="$blocked_pattern youtubei.googleapis.com"
blocked_pattern="$blocked_pattern video-stats.l.google.com"
blocked_pattern="$blocked_pattern ytimg-edge-static.l.google.com"

enable_firewall() {
    echo "Enabling firewall"
    for chain in INPUT FORWARD OUTPUT
        do
        count=1
        for proto in tcp udp
            do
                for blocked in $blocked_pattern
                    do
                    echo iptables -I $chain $count -p $proto -m string --algo bm --string "$blocked" -j DROP
                    iptables -I $chain $count -p $proto -m string --algo bm --string "$blocked" -j DROP
                    count=$(expr $count + 1)
                done
        done
        echo iptables -I $chain $count -p udp --sport 443 -j DROP
        iptables -I $chain $count -p udp --sport 443 -j DROP
        count=`expr $count + 1`
        echo iptables -I $chain $count -p udp --dport 443 -j DROP
        iptables -I $chain $count -p udp --dport 443 -j DROP
        count=$(expr $count + 1)
    done
    echo -n "enabled" > $status_file
}

disable_firewall() {
    echo "Disabling firewall"
    for chain in INPUT FORWARD OUTPUT
        do
        for proto in tcp udp
            do
                for blocked in $blocked_pattern
                    do
                    echo iptables -D $chain -p $proto -m string --algo bm --string "$blocked" -j DROP
                    iptables -D $chain -p $proto -m string --algo bm --string "$blocked" -j DROP
                done
        done
        echo iptables -D $chain -p udp --sport 443 -j DROP
        iptables -D $chain -p udp --sport 443 -j DROP
        echo iptables -D $chain -p udp --dport 443 -j DROP
        iptables -D $chain -p udp --dport 443 -j DROP
    done
    echo -n "disabled" > $status_file
}

_get_time_as_integer() {
  time=$1

  hour=$(echo $time | cut -d: -f 1)
  minute=$(echo $time | cut -d: -f 2)

  echo "$hour * 100 + $minute" | bc
}

_get_start_time(){
    # expected format: 07:00,10:00
    time_str=$1

    time_start=$(echo $time_str | cut -d, -f 1)
    _get_time_as_integer $time_start
}

_get_stop_time() {
    #expected format: 07:00,10:00
    time_str=$1

    time_stop=$(echo $time_str | cut -d, -f 2)
    _get_time_as_integer $time_stop
}

get_timetable() {

do_activate=0
for value in $TIMETABLE
    do
    start=$(_get_start_time $value)
    stop=$(_get_stop_time $value)
    cur_time=$(_get_time_as_integer $NOW)
    if [ $start -lt $cur_time ]; then
        if [ $cur_time -lt $stop ]; then
           do_activate=1
        fi
    fi
done

cur_status=$(cat $status_file)
if [ $do_activate ]; then
    if [ "$cur_status" = "enabled" ]; then
        echo "firewall already activated"
    else
       echo "activating firewall"
       enable_firewall
    fi
else
    if [ "$cur_status" = "enabled" ]; then
       echo "deactivating firewall"
       disable_firewall
    else
        echo "firewall already deactivated"
    fi
fi
}

case $1 in
    start) enable_firewall
           exit 0;;
    stop) disable_firewall
          exit 0;;
    timetable) get_timetable
               exit 0;;
    status) echo "firewall rules are $(cat $status_file)";;
    *) echo "Use: $0 [start|stop|timetable|status]"
       exit 0
esac

exit 0
