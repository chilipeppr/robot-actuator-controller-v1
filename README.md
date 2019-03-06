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

# CAD Design Fusion 360

The CAD design of the extended wrist cap with the electronics inside is available at https://gallery.autodesk.com/fusion360/projects/robot-arm-esp32-drv8825-actuator-controller

# How to Upload the Lua Code

The ChiliPeppr ESP32 for Lua Workspace was used to program the board and is available at http://chilipeppr.com/esp32

Video on how to use the ESP32 for Lua workspace to upload firmware and Lua code on your ESP32. https://www.youtube.com/watch?v=njAeHfoVIoY

# Thingiverse

Jeff Kerr's (LoboCNC) original 3D printed robot arm design is on Thingiverse at https://www.thingiverse.com/thing:3327968/

# PCB Components

ESP32 Wemos $8 (Many ESP32 devices are cheaper, but this is the smallest size broadly available to fit inside the small actuators)
https://www.aliexpress.com/item/ESP32-wemos-ESP32-WiFi-Modules-Bluetooth-Dual-ESP-32-ESP-32S-ESP8266/32815190965.html

DRV8825 Stepper Board $0.95
https://www.aliexpress.com/item/5pcs-lot-3D-Printer-Stepstick-Drv8825-Stepper-Motor-Driver-Reprap-4-PCB-Board-Free-shipping-replace/32514641632.html

DC to DC Converter $0.90 (Pick the 5V version, not 3.3V)
https://www.aliexpress.com/item/DC-DC-Power-Supply-Module-Step-Down-3A-output-24V-12V-to-5V-3-3V-Buck/32904709711.html

WS2812B LED $0.15 per (Choose white and WS2812B)
https://www.aliexpress.com/item/10-1000pcs-4-Pin-WS2812B-WS2812-LED-Chip-Heatsink-5V-5050-RGB-WS2811-IC-Built-in/32634454437.html

Slide Switch $0.29 for 20 pieces
https://www.aliexpress.com/item/20Pcs-Interruptor-on-off-mini-Slide-Switch-SS12D00-SS12D00G3-3pin-1P2T-2-Position-High-quality-toggle/32964400942.html

Screw Terminal
https://www.aliexpress.com/item/20-pcs-2-Pin-Screw-blue-green-PCB-Terminal-Block-Connector-5mm-Pitch/32814618602.html

26AWG Silicone Ultra Flexible Wire for 24v (Use 2 of the 4 wires)
https://www.aliexpress.com/item/2metre-26AWG-28AWG-30AWG-Silicone-Wire-Ultra-Flexiable-Test-Line-3P-4P-6P-0-08mm-Tinned/32870367030.html
