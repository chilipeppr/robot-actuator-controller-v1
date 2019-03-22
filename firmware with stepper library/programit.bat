echo on
esptool.py --port COM7 write_flash 0x1000 bootloader.bin 0x10000 NodeMCU.bin 0x8000 partitions.bin
