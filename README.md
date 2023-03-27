
# **PockeTerm II**

![PT_final trimmed-smaller](https://user-images.githubusercontent.com/121696513/226185154-53f5fab6-533e-4c69-8979-7ae500887c44.jpg)

<br>
<br>

# Build a PockeTerm at the VCFSW June 24
<br>
Come out to the Vintage Computer Festival Southwest (http://vcfsw.org)  and build a PockeTerm II kit in a classroom setting. The cost for the kits are $50 (due at the start of the workshop) and the workshop is free with admission to the VCFSW event. 
The date of the workshop is Saturday June 24th at 10am. Space is limited so rsvp to vbriel@yahoo.com
<br>

What is the PockeTerm? The PockeTerm is a VT-100 compatible terminal in a single board format that utilizes 640 x 480 VGA for Video display and a PS/2 port for the keyboard. Users have the ability to change text colors on a black background as well as other features. This board was produced and sold by Briel Computers from 2007 until production ended in 2016. Now, a newer version is open source to share my work. No more needing a laptop or computer with serial interface and a terminal program. Dedicate a 80x25 VT100 compatible terminal to your system. 

# 2023 The PockeTerm II Open Source Project

The PockeTerm II is a refreshed version of my original PockeTerm design from 2007. Using a low cost serial to USB interface in place of one of the serial ports, not only modernized the connection to a PC but gave a reliable power source as well.

# Tested on vintage hardware 
As well as testing on a modern computer system, I have also tested this on my personal Altair 8800. 

## Features included on the PockeTerm II

USB interface: Used for power and optionally a computer to pass information thru to the host machine. 
VGA Interface for a crisp clean display with several text color options
PS/2 Interface for using a low cost PC PS/2 keyboard
Jumpers to set standard or null interface. No more hunting for the right cable.
Compact size: Footprint is only 3.5" X 2.5" using standard through hole components.

## Programmable Options: 

Set and store options such as BAUD rate, color, bits without having to set at every power up.

## Building from the included files:

Gerber files are included so you can simply order your own boards. All layers, silkscreen are there.
A PDF showing the schematic is included if you wish to make your own layout or make changes.

## Propeller Source Code:

I've included all the Parallax Propeller source code to program the PockeTerm II. Simply download the free programming tool from Parallax and install on your PC.

With the software loaded, find the main file PockeTermV.905 and open it.
Do Not plug in the PockeTerm II to your computer yet.
Turn on your PockeTerm II. 
Plug in your PockeTerm II and wait for it to be found on your computer. 
If you run into any problems, visit Silicon Labs and look for CP210x drivers
To verify that the Propeller Tool software can communicate with your PockeTerm II board, press F7.
If the software did not find your PockeTerm, please visit Silicon Labs web site to trouble shoot drivers.
One you have connection to your PockeTerm II, and the PockeTermV.905 firmware ready, simply press F11 to program.

## Testing:
![image](https://user-images.githubusercontent.com/121696513/226185484-f4fb12a3-d28e-4ad2-b7be-2b2d9c5d2d3b.png)

<br>
You can test the PockeTerm II without connecting it to a host computer. Simply place the jumper shunts sideways across the jumpers in Standard Mode and that will act as a loop back for testing. The image above shows jumpers in null modem setting. 

Now anything that you type on the keyboard should appear on the VGA screen. 

Once testing is complete, you can configure the PockeTerm II settings to fit your host machine settings. Make sure you put your jumper shunts back to STD or NULL.

Attach the PockeTerm to your host computer with power off. Once the serial connector is on, you can apply power to the terminal then the host machine.

# WARNING: Create at your own risk

You understand and agree that I am not be liable to you or any third party for any damage to equipment or harm that may happen as a result of making this project. Create at your own risk.
