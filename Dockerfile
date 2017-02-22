FROM ubuntu:14.04

MAINTAINER Valentin Chatelain <v.chatelain@sysdream.com>

# xvnc / xfce installation
RUN apt-get update && apt-get upgrade -y && DEBIAN_FRONTEND=noninteractive apt-get install -y firefox xfce4 vnc4server && rm -rf /var/lib/apt/

# VNC related environment var
# Password for VNC must be changed

ENV DISPLAY :1
ENV VNC_COL_DEPTH 16
ENV VNC_RESOLUTION 1024x768
ENV VNC_PW vncpassword
ENV VNC_PORT="5901"

EXPOSE 5901

ADD .vnc /root/.vnc
ADD startup.sh /root/
RUN chmod +x /root/.vnc/xstartup /etc/X11/xinit/xinitrc /root/startup.sh

ENTRYPOINT ["bash", "/root/startup.sh"]
CMD ["--tail-log"]