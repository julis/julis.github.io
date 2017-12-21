#!/bin/sh

#epiphany --display=:0 http://google.com
#mono /home/pi/ProteinConcentrator/PC.Server/bin/Debug/PC.Server.exe
chromium-browser  --display=:0 --app=http://localhost:9000 --start-fullscreen --kiosk --process-per-site
