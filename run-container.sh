#!/bin/sh

# XQuartz
xhost -
xhost + localhost

# PulseAudio
# pulseaudio --load=module-native-protocol-tcp --exit-idle-time=-1 --daemon
# pulseaudio --check -v

# Terminator
docker compose exec ros2-dev terminator
