# disco-servo

Beware all ye who enter here! This mod is very early alpha. It activates and sends commands to the CHUCK servo rails. We still don't know if using this mod may interfere with other servo functions such as flight controls. Please use with care.

Parrot Disco servo software mod to allow the additional PWM servo ports on the CHUCK to be controlled by Skycontroller 2


**1) TELNET SERVER SHALL BE STARTED TO USE THE MOD

Since this mode uses TELNET as an interface for sending commands from the skycontroler to the disco, each time you start the disco and wish to use the servomod, you will have to quickly double press the start button on the DISCO in order the disco to start its TELNET server, else, the skycontroler will not be able to send servo commands.

Alternatively, you can automatically start TELNET server automaticaly on the disco without having to quickly double press the start button on the DISCO.
  To do so, process as followed:
  - First press the power button 2 times in order to activate the telnet session. Then telnet to it using
    $ telnet 192.168.42.1
  - Then mount and remount the drive to obtain write access to the files using
    $ mount -o remount,rw /
  - After that, change the /etc/boxinit.d/50-telnetd.rc file using:
    $ vi /etc/boxinit.d/50-telnetd.rc
    Go into write mode using :w + [Enter] and press i to go into insert mode. Change to disabled to enabled to automatically enable telnet.
    Write to the file using :w + [Enter] and quit by pressing [Esc] and type :x + [Enter]

**2) Login in the SkyControler from the DISCO

In order to have a shell prompt on the Skycontroler from the DISCO, you can benefit from creating a script that will log you on the SkyControler.
This can be useful for example if you want to quickly investigate the SkyControler or upload files through FTP from DISCO (which have a FTP server) to the SkyControler.

  a) first press the power button 2 times in order to activate the telnet session. Then telnet to it using
    $ telnet 192.168.42.1

  b) Now that you are logged in the DISCO type the following:

cat > logsc2.sh
#/bin/sh
/data/ftp/uavpal/bin/adb start-server
ip_sc2=`netstat -nu |grep 9988 | head -1 | awk '{ print $5 }' | cut -d ':' -f 1`
/data/ftp/uavpal/bin/adb connect ${ip_sc2}:9050
/data/ftp/uavpal/bin/adb shell
/data/ftp/uavpal/bin/adb kill-server

  c) then type Control and D (Ctrl+D) : this will save the file as logsc2.sh
  
  d) To make this file executable, type the following command:

chmod 777 ./logsc2.sh

  e) Now, to login to the SkyControler, once it is connected DISCO, you can open a shell on the DISCO (like you did at step (a)), and you can type the following command to log in the SkyControler:
  
./logsc2.sh

