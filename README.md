# Building
```
docker build . -t warpcode/chromium
```

# Usage
```
xhost local:root && \
docker run \
    --rm \
    --privileged \
    -it \
    -v /etc/localtime:/etc/localtime:ro \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=unix$DISPLAY \
    -v /dev/shm:/dev/shm \
    --device /dev/snd:/dev/snd \
    --device /dev/dri \
    --name chromium \
    warpcode/chromium
```
