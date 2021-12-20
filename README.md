# opewrt-youtube-blocker
This is a little script I created for my opewrt router.

It helps to block the YouTube access in order to get my teenagers at home
focusing on their tasks.  A bit tyranic thing, but it works.

It accepts specific time ranges to be activated via parameter `TIMETABLE`.  
Format is `<time starts HH:MM>,<time stops HH:MM>`.

First you have to download it into your opewrt box.  You can just copy and
paste the content from here or use `curl` instead (if installed):

    root@OpenWrt:~# which curl
    /usr/bin/curl
    root@OpenWrt:~# cd /usr/lib/scripts/
    root@OpenWrt:/usr/lib/scripts# curl -LO https://raw.githubusercontent.com/helioloureiro/opewrt-youtube-blocker/main/firewall.sh
    % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
    100  3924  100  3924    0     0   4605      0 --:--:-- --:--:-- --:--:--  4850
    root@OpenWrt:/usr/lib/scripts# chmod +x firewall.sh


You can manually start and stop the firewall also.  But if you set to run by
crontab, it state will be ovewritten.

    root@OpenWrt:/usr/lib/scripts# ./firewall.sh
    Use: ./firewall.sh [start|stop|timetable|status]
    root@OpenWrt:/usr/lib/scripts# ./firewall.sh status
    firewall rules are disabled
    root@OpenWrt:/usr/lib/scripts# ./firewall.sh start
    Enabling firewall
    iptables -I INPUT 1 -p tcp -m string --algo bm --string youtubei.googleapis.com -j DROP
    iptables -I INPUT 2 -p tcp -m string --algo bm --string googlevideo.com -j DROP
    iptables -I INPUT 3 -p tcp -m string --algo bm --string ytimg-edge-static.l.google.com -j DROP
    iptables -I INPUT 4 -p tcp -m string --algo bm --string i.ytimg.com -j DROP
    iptables -I INPUT 5 -p tcp -m string --algo bm --string youtube-ui.l.google.com -j DROP
    iptables -I INPUT 6 -p tcp -m string --algo bm --string www.youtube.com -j DROP
    iptables -I INPUT 7 -p tcp -m string --algo bm --string googleapis.l.google.com -j DROP
    iptables -I INPUT 8 -p tcp -m string --algo bm --string youtubei.googleapis.com -j DROP
    iptables -I INPUT 9 -p tcp -m string --algo bm --string video-stats.l.google.com -j DROP
    iptables -I INPUT 10 -p tcp -m string --algo bm --string ytimg-edge-static.l.google.com -j DROP
    iptables -I INPUT 11 -p udp -m string --algo bm --string youtubei.googleapis.com -j DROP
    iptables -I INPUT 12 -p udp -m string --algo bm --string googlevideo.com -j DROP
    iptables -I INPUT 13 -p udp -m string --algo bm --string ytimg-edge-static.l.google.com -j DROP
    iptables -I INPUT 14 -p udp -m string --algo bm --string i.ytimg.com -j DROP
    iptables -I INPUT 15 -p udp -m string --algo bm --string youtube-ui.l.google.com -j DROP
    iptables -I INPUT 16 -p udp -m string --algo bm --string www.youtube.com -j DROP
    iptables -I INPUT 17 -p udp -m string --algo bm --string googleapis.l.google.com -j DROP
    iptables -I INPUT 18 -p udp -m string --algo bm --string youtubei.googleapis.com -j DROP
    iptables -I INPUT 19 -p udp -m string --algo bm --string video-stats.l.google.com -j DROP
    iptables -I INPUT 20 -p udp -m string --algo bm --string ytimg-edge-static.l.google.com -j DROP
    iptables -I INPUT 21 -p udp --sport 443 -j DROP
    iptables -I INPUT 22 -p udp --dport 443 -j DROP
    iptables -I FORWARD 1 -p tcp -m string --algo bm --string youtubei.googleapis.com -j DROP
    iptables -I FORWARD 2 -p tcp -m string --algo bm --string googlevideo.com -j DROP
    iptables -I FORWARD 3 -p tcp -m string --algo bm --string ytimg-edge-static.l.google.com -j DROP
    iptables -I FORWARD 4 -p tcp -m string --algo bm --string i.ytimg.com -j DROP
    iptables -I FORWARD 5 -p tcp -m string --algo bm --string youtube-ui.l.google.com -j DROP
    iptables -I FORWARD 6 -p tcp -m string --algo bm --string www.youtube.com -j DROP
    iptables -I FORWARD 7 -p tcp -m string --algo bm --string googleapis.l.google.com -j DROP
    iptables -I FORWARD 8 -p tcp -m string --algo bm --string youtubei.googleapis.com -j DROP
    iptables -I FORWARD 9 -p tcp -m string --algo bm --string video-stats.l.google.com -j DROP
    iptables -I FORWARD 10 -p tcp -m string --algo bm --string ytimg-edge-static.l.google.com -j DROP
    iptables -I FORWARD 11 -p udp -m string --algo bm --string youtubei.googleapis.com -j DROP
    iptables -I FORWARD 12 -p udp -m string --algo bm --string googlevideo.com -j DROP
    iptables -I FORWARD 13 -p udp -m string --algo bm --string ytimg-edge-static.l.google.com -j DROP
    iptables -I FORWARD 14 -p udp -m string --algo bm --string i.ytimg.com -j DROP
    iptables -I FORWARD 15 -p udp -m string --algo bm --string youtube-ui.l.google.com -j DROP
    iptables -I FORWARD 16 -p udp -m string --algo bm --string www.youtube.com -j DROP
    iptables -I FORWARD 17 -p udp -m string --algo bm --string googleapis.l.google.com -j DROP
    iptables -I FORWARD 18 -p udp -m string --algo bm --string youtubei.googleapis.com -j DROP
    iptables -I FORWARD 19 -p udp -m string --algo bm --string video-stats.l.google.com -j DROP
    iptables -I FORWARD 20 -p udp -m string --algo bm --string ytimg-edge-static.l.google.com -j DROP
    iptables -I FORWARD 21 -p udp --sport 443 -j DROP
    iptables -I FORWARD 22 -p udp --dport 443 -j DROP
    iptables -I OUTPUT 1 -p tcp -m string --algo bm --string youtubei.googleapis.com -j DROP
    iptables -I OUTPUT 2 -p tcp -m string --algo bm --string googlevideo.com -j DROP
    iptables -I OUTPUT 3 -p tcp -m string --algo bm --string ytimg-edge-static.l.google.com -j DROP
    iptables -I OUTPUT 4 -p tcp -m string --algo bm --string i.ytimg.com -j DROP
    iptables -I OUTPUT 5 -p tcp -m string --algo bm --string youtube-ui.l.google.com -j DROP
    iptables -I OUTPUT 6 -p tcp -m string --algo bm --string www.youtube.com -j DROP
    iptables -I OUTPUT 7 -p tcp -m string --algo bm --string googleapis.l.google.com -j DROP
    iptables -I OUTPUT 8 -p tcp -m string --algo bm --string youtubei.googleapis.com -j DROP
    iptables -I OUTPUT 9 -p tcp -m string --algo bm --string video-stats.l.google.com -j DROP
    iptables -I OUTPUT 10 -p tcp -m string --algo bm --string ytimg-edge-static.l.google.com -j DROP
    iptables -I OUTPUT 11 -p udp -m string --algo bm --string youtubei.googleapis.com -j DROP
    iptables -I OUTPUT 12 -p udp -m string --algo bm --string googlevideo.com -j DROP
    iptables -I OUTPUT 13 -p udp -m string --algo bm --string ytimg-edge-static.l.google.com -j DROP
    iptables -I OUTPUT 14 -p udp -m string --algo bm --string i.ytimg.com -j DROP
    iptables -I OUTPUT 15 -p udp -m string --algo bm --string youtube-ui.l.google.com -j DROP
    iptables -I OUTPUT 16 -p udp -m string --algo bm --string www.youtube.com -j DROP
    iptables -I OUTPUT 17 -p udp -m string --algo bm --string googleapis.l.google.com -j DROP
    iptables -I OUTPUT 18 -p udp -m string --algo bm --string youtubei.googleapis.com -j DROP
    iptables -I OUTPUT 19 -p udp -m string --algo bm --string video-stats.l.google.com -j DROP
    iptables -I OUTPUT 20 -p udp -m string --algo bm --string ytimg-edge-static.l.google.com -j DROP
    iptables -I OUTPUT 21 -p udp --sport 443 -j DROP
    iptables -I OUTPUT 22 -p udp --dport 443 -j DROP
    root@OpenWrt:/usr/lib/scripts# ./firewall.sh status
    firewall rules are enabled

In order to run based on time, just get into your openwrt box web interface,
go into system -> crontab and add the following entry:

  `*/5 * * * * /usr/lib/scripts/firewall.sh timetable`
