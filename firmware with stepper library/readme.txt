You need to upload this firmware to your ESP32 using esptool.py which is available on the Espressif website. There's also a video on http://chilipeppr.com/esp32 on how to use the workspace. This video shows you how to upload the firmware and use the workspace to upload code.

To program your board with this firmware use the command on Windows:
esptool.py --port COM5 write_flash 0x1000 bootloader.bin 0x10000 NodeMCU.bin 0x8000 partitions.bin

You need to install esptool.py via Python's package manager or from downloading direct from Espressif's website.

An alternate path is to use the esp32tool.zip I provide in the workspace and swap out the NodeMCU.bin file in this repo to the one in that zip file. Then install. You do need 3 .bin files to program the firmware. 2 of them are standard (bootloader.bina nd partitions.bin), but the NodeMCU.bin is the new file you'd have to swap in.

This firmware is configured for 230,400 baud, so don't forget to change to that value in ChiliPeppr when you connect to the board. If you try the default 115,200 it will fail.

