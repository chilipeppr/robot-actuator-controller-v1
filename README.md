# robot-actuator-controller-v1
This is a controller for the WE-R2.4 robot on Thingiverse.

It has an ESP32 at the heart of the controller to enable control of the actuator via Wifi or Bluetooth. There is a DC to DC converter to step down the 24v driving the DRV8825 stepper motor driver to 5V for powering the ESP32. The DRV8825 has all ports connected into the ESP32 to send step and direction pulses for control of the stepper motor.

There is also a WS2812 LED connected for indicating status of the controller.

A switch has been added for when you're using the USB port for programming the ESP32. You need to switch off the 5V from the DC to DC converter to connect USB from your computer.

The wrist cap has been extended from Jeff Kerr's original design to fit this larger board.
