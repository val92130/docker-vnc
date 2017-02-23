# docker-vnc

A simple docker image that provides a VNC server and noVNC access

## Usage

```
docker build -t vnc .

docker run -p 5901:5901 -p 6080:6080 vnc
```

To access the noVNC page, go to `http://localhost:6080/vnc_auto.html`


Make sure to change the VNC password in the Dockerfile with the VNC_PW env variable.