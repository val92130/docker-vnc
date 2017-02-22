# docker-vnc

A simple docker image that provides a VNC server

## Usage

```
docker build -t vnc .

docker run -p 5901:5901 vnc
```


Make sure to change the VNC password in the Dockerfile with the VNC_PW env variable.