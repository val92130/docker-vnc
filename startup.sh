#!/bin/bash

# resolve ip
VNC_IP=$(ip addr show eth0 | grep -Po 'inet \K[\d.]+')

# set vncserver password
(echo $VNC_PW && echo $VNC_PW) | vncpasswd

# start vncserver
vncserver -kill :1 && rm -rfv /tmp/.X* ; echo "remove old vnc locks to be a reattachable container"
vncserver $DISPLAY -depth $VNC_COL_DEPTH -geometry $VNC_RESOLUTION
sleep 1
##log connect options
echo -e "\n------------------ VNC environment started ------------------"
echo -e "\nVNCSERVER started on DISPLAY= $DISPLAY \n\t=> connect via VNC viewer with $VNC_IP:$VNC_PORT"

mkdir /root/novnc
wget -O /root/novnc/master.zip "https://github.com/novnc/noVNC/archive/master.zip"
unzip /root/novnc/master.zip -d /root/novnc/
sleep 5

./root/novnc/noVNC-master/utils/launch.sh --vnc localhost:$VNC_PORT
echo -e "\n------------------ NOVNC started ------------------"

for i in "$@"
do
case $i in
    # if option `-t` or `--tail-log` block the execution and tail the VNC log
    -t|--tail-log)
    echo -e "\n------------------ /root/.vnc/*$DISPLAY.log ------------------"
    tail -f /root/.vnc/*$DISPLAY.log
    ;;
    *)
    # unknown option ==> call command
    exec $i
    ;;
esac
done