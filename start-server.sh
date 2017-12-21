#!/bin/sh

#mono /home/pi/ProteinConcentrator/PC.Server/bin/Debug/PC.Server.exe > /dev/null 2>&1
#mono /home/pi/ProteinConcentrator/PC.Server/bin/Debug/PC.Server.exe

cd /home/pi/ProteinConcentrator/PC.Server/bin/Debug/
mono PC.Server.exe -d dummyserial
