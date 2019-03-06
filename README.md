# robot-actuator-controller-v1
This is a controller for the WE-R2.4 robot on Thingiverse.

It has an ESP32 at the heart of the controller to enable control of the actuator via Wifi or Bluetooth. There is a DC to DC converter to step down the 24v driving the DRV8825 stepper motor driver to 5V for powering the ESP32. The DRV8825 has all ports connected into the ESP32 to send step and direction pulses for control of the stepper motor.

There is also a WS2812 LED connected for indicating status of the controller.

A switch has been added for when you're using the USB port for programming the ESP32. You need to switch off the 5V from the DC to DC converter to connect USB from your computer.

The wrist cap has been extended from Jeff Kerr's original design to fit this larger board.

# Eagle Board and Schematic

The .brd and .sch files are Eagle board and schematic files. You can download Eagle for free to view or edit the boards or just use the .zip file in the "pcb fabricator" folder to send to your board house like JLCPCB where it only costs $2 to get your boards made.

# ESP32 Firmware

You need to upload the firmware in this repo to your ESP32 using esptool.py which is available on the Espressif website. There's also a video on http://chilipeppr.com/esp32 on how to use the workspace. This video shows you how to upload the firmware and use the workspace to upload code.

To program your board with this firmware use the command on Windows:
esptool.py --port COM5 write_flash 0x1000 bootloader.bin 0x10000 NodeMCU.bin 0x8000 partitions.bin

You need to install esptool.py via Python's package manager or from downloading direct from Espressif's website.

An alternate path is to use the esp32tool.zip I provide in the workspace and swap out the NodeMCU.bin file in this repo to the one in that zip file. Then install. You do need 3 .bin files to program the firmware. 2 of them are standard (bootloader.bina nd partitions.bin), but the NodeMCU.bin is the new file you'd have to swap in.

This firmware is configured for 230,400 baud, so don't forget to change to that value in ChiliPeppr when you connect to the board. If you try the default 115,200 it will fail.

