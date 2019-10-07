#!/bin/bash

VNC_PORT=29
export DISPLAY=":${VNC_PORT}.0"

/usr/bin/Xvfb :${VNC_PORT} -screen 0 1024x768x8 -fbdir /var/tmp  &
XVFB_PID=$!

# waiting for XServer  established (or failure)
sleep 1

if test "${XVFB_PID}" != "$(jobs -p)" ;then
    echo "error, Xvfb failed"
    exit 1
fi

/usr/bin/wine 'z:\dude\dude.exe' --server
RET=$?
echo "wine returned '$RET'"

# waiting for shutdown all wine stuff completely
sleep 2

kill $XVFB_PID
exit $RET

