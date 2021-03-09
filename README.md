# disco-servo

Beware all ye who enter here! This mod is very early alpha. It activates and sends commands to the CHUCK servo rails. We still don't know if using this mod may interfere with other servo functions such as flight controls. Please use with care.

Parrot Disco servo software mod to allow the additional PWM servo ports on the CHUCK to be controlled by Skycontroller 2

Since this mode uses TELNET as an interface for sending commands from the skycontroler to the disco, each time you start the disco and wish to use the servomod, you will have to quickly double press the start button in order the disco to start its TELNET server, else, the skycontroler will not be able to send servo commands.

Alternatively, you can automatically start 2 button press.
  To do so, process as followed:
  - First press the power button 2 times in order to activate the telnet session. Then telnet to it using
    $ telnet 192.168.42.1
  - Then mount and remount the drive to obtain write access to the files using
    $ mount -o remount,rw /
  - After that, change the /etc/boxinit.d/50-telnetd.rc file using:
    $ vi /etc/boxinit.d/50-telnetd.rc
    Go into write mode using :w + [Enter] and press i to go into insert mode. Change to disabled to enabled to automatically enable telnet.
    Write to the file using :w + [Enter] and quit by pressing [Esc] and type :x + [Enter]
