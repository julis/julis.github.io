# Journey to create kiosk application in raspberry pi

Burn an image from Raspbian Jessie Lite, downloaded from :

```
https://downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-2017-07-05/
```

insert the sdcard, format the sdcard using **sd card formatter**,
write the image to sdcard using **win32diskimager**

* insert the sdcard to raspberry, turn on the device
* login with user:pi password:raspberry
* enable the ssh

```
sudo raspi-config
```

choose the boot options, enable the ssh server, reboot the device

install the xinit

```
sudo apt-get update && sudo apt-get install xinit
```

install chromium-browser

```
sudo apt-get install chromium-browser
```

### install mono

```
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb http://download.mono-project.com/repo/debian raspbianjessie main" | sudo tee /etc/apt/sources.list.d/mono-official.list
sudo apt-get update
sudo apt-get install mono-devel
```

test mono installation

```
nano hello.cs
```

write this to the file hello.cs

```
using System;

public class HelloWorld
{
    static public void Main ()
    {
        Console.WriteLine ("Hello Mono World");
    }
}
```

compile it using mcs

```
mcs hello.cs
```

run the compiled code using mono

```
mono hello.exe
```

it should run and output to console

```
Hello Mono World
```

### run the chromium-browser automatically after booting

first, install unclutter to hide cursor when idle

```
sudo apt-get install unclutter
```

edit /etc/rc.local add this line before exit 0

```
xinit ./home/pi/start-browser.sh
```

create file /home/pi/start-browser.sh write this to the file

```
#!/bin/sh
xset s off
xset -dpms
/usr/bin/chromium-browser --window-position=0,0 --window-size="1024,600" --display=:0 --app=http://localhost:9000 --start-fullscreen --kiosk --no-sandbox &
unclutter -idle 0.1
```

### cleaning up boot screen

modify the content of file /boot/cmdline.txt to this,
makesure it only one line

```
dwc_otg.lpm_enable=0 console=tty3 root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait quiet logo.nologo plymouth.enable=0
```

### add splash screen on boot

* install fbi

```
sudo apt-get install fbi
```

* bikin gambar splash.png
  ukuran 1024x600 (sesuaikan resolusi layar)

```
sudo cp splash.png /etc/
```

* bikin script

```
sudo nano /etc/init.d/asplashscreen
```

```
#! /bin/sh
### BEGIN INIT INFO
# Provides:          asplashscreen
# Required-Start:
# Required-Stop:
# Should-Start:
# Default-Start:     S
# Default-Stop:
# Short-Description: Show custom splashscreen
# Description:       Show custom splashscreen
### END INIT INFO


do_start () {

    /usr/bin/fbi -T 1 -noverbose -a /etc/splash.png
    exit 0
}

case "$1" in
  start|"")
    do_start
    ;;
  restart|reload|force-reload)
    echo "Error: argument '$1' not supported" >&2
    exit 3
    ;;
  stop)
    # No-op
    ;;
  status)
    exit 0
    ;;
  *)
    echo "Usage: asplashscreen [start|stop]" >&2
    exit 3
    ;;
esac

:
```

* buat script tersebut executable
  sudo chmod a+x /etc/init.d/asplashscreen
* install scriptnya sebagai service
  sudo insserv /etc/init.d/asplashscreen

### auto mount of flashdisk in raspi using udisks-glue

* install exfat-fuse

```
sudo apt-get install exfat-fuse
```

* install ntfs-3g

```
sudo apt-get install ntfs-3g
```

```
# install udisks-glue
apt-get install udisks-glue policykit-1

# edit config file to enable automount
sed -i '/^match disks /a\    automount = true' /etc/udisks-glue.conf

# startup using rc.local
sed -i "/^exit 0/isudo -u $(logname) udisks-glue\n" /etc/rc.local
```

* create file /etc/polkit-1/localauthority/50-local.d/50-mount-as-pi.pkla

```
[Media mounting by pi]
Identity=unix-user:pi
Action=org.freedesktop.udisks.filesystem-mount
ResultAny=yes
```

### turn off bluetooth

to turn of bluetooth you need to add these line to /boot/config.txt

```
dtoverlay=pi3-disable-bt
```

### Protein Concentrator

#### release the ttyAMA from console

#### install libtermioswrapper

#### run the application as a service
