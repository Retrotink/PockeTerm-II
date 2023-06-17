
# **PockeTerm II**

![PT_final trimmed-smaller](https://user-images.githubusercontent.com/121696513/226185154-53f5fab6-533e-4c69-8979-7ae500887c44.jpg)

<br>
<br>

![vcfsw](https://user-images.githubusercontent.com/121696513/235480835-606152f9-d420-4610-b162-61d646eeeedf.jpg)

<br>
<br>

# Build a PockeTerm at the VCFSW
# June 24, 2023 University of Texas Richardson
<br>
Come out to the Vintage Computer Festival Southwest (http://vcfsw.org)  and build a PockeTerm II kit in a classroom setting. The cost for the kits are $50 (due at the start of the workshop) and the workshop is free with admission to the VCFSW event. 
The date of the workshop is Saturday June 24th at 10am. Space is limited so rsvp to vbriel@yahoo.com

<br>
<br>

## What is the PockeTerm? 
The PockeTerm is a VT-100 compatible terminal in a 3.5" X 2.5" small single board format that utilizes 640 x 480 VGA for Video display and a PS/2 port for the keyboard. Users have the ability to change text colors on a black background as well as other features. This board was produced and sold by Briel Computers from 2007 until production ended in 2016. Now, a newer version is open source to share my work. No more needing a laptop or computer with serial interface and a terminal program. Dedicate a 80x25 VT100 compatible terminal to your system. 

![image](https://user-images.githubusercontent.com/121696513/235483199-bffefcc8-7a4b-446e-bcb0-2f6c526d24f8.png)


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

## Building your own from the included files:

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

# Bill Of Materials

![bom](https://github.com/Retrotink/PockeTerm-II/assets/121696513/68e3075c-7a53-4e94-9146-bde8386f5e00)

[github_bom.xls](https://github.com/Retrotink/PockeTerm-II/files/11759871/github_bom.xls)



# Soldering the PockeTerm II

Step 1: The Resistors<br>
![resistor](https://github.com/Retrotink/PockeTerm-II/assets/121696513/01a7b73d-7fd2-4fa3-94ff-4ebca1492b9e)
<br>
Resistors are not polarized so they can be installed either direction. I like to start with the 100ohm resistors and work my way up to the 10K ohm resistors. The gold band is the percentage of accuracy. To read a resistor, start at the opposite side of the gold band.

100 ohm - brown black brown (QTY2)<br>
240 ohm – red yellow brown (QTY 6)<br>
470 ohm – yellow violet brown (QTY 3)<br>
1K ohm – brown black red (QTY 1)<br>
3.3K ohm – orange orange red (QTY 1)<br>
10K ohm – brown black orange (QTY 1)<br>

Bend the metal wires at a 90 degree angle on each side of the resistor body. Place the resistor into the resistor location until it is flush with the PCB. Turn the board over holding the resistor in its place and bend the wires outward just slightly so the resistor can not back out of the holes. While the bottom of the board is facing up flat on your workspace, solder each of the two wires on the resistor. Make sure your solder stays only on the resistor wire and the hole. Cut the excess lead off the resistor. Repeat this procedure for all of the resistors.

Step 2: The crystal<br>
![crystal](https://github.com/Retrotink/PockeTerm-II/assets/121696513/4f4d3fd7-b99a-4a5b-a0d3-b7fdda44819b)


The 5MHZ crystal is not polarized and can be installed in either direction. Install flush with the PCB, hold the crystal and bend the leads apart slightly to keep the crystal from falling out. Turn the board over and solder the leads. Cut the excess lead length off flush with the PCB.

Step 3: The IC sockets<br>

![socket](https://github.com/Retrotink/PockeTerm-II/assets/121696513/30c07d55-07e7-40dc-ac42-17c071c2a6b0)

On the shorter edge of the socket is a notch showing you the direction to install the socket. Place the 40 pin large socket flush onto the PCB. Holding the socket, flip the board over and set on your workspace. Solder 2 pins on opposite corners and turn the board over and make sure the socket is flush with the PCB. Heat and adjust if needed. Solder the other 38 pins. Check for completeness of all the pins. If you accidentally install the socket backwards, it will still work just correctly. Just remember when you go to install the chips that the notch is at the wrong end. Repeat for the other 2 sockets.

Step 4: The power switch<br>
![switch](https://github.com/Retrotink/PockeTerm-II/assets/121696513/642d63f3-f5c4-475c-b182-04beb929ad56)

Install switch into its location. Make sure the slide part of the switch faces away from the PCB. When flush with the PCB, turn over holding the switch from falling out and place on your workspace. Solder down all 6 posts making sure no solder flows across to the other tabs. Then solder the outter support posts.

Step 5: The USB PC Serial Power Connector <br>
![serial-usb](https://github.com/Retrotink/PockeTerm-II/assets/121696513/dded9457-0686-4fb2-b035-356d23ba6e5a)


The USB Power connector has 6 pins and when placed onto the PockeTerm II board will be slightly elevated on the front edge. Make sure the connector is completely inserted before beginning soldering

Step 6: The transistor <br>
![transistor](https://github.com/Retrotink/PockeTerm-II/assets/121696513/5f2d2f0a-00b0-4b07-baf8-7dfe22e6a85a)


The transistor is labeled 2N4401 and is black with 3 pins, a half circle shape with one flat side. On the PCB match the shape outline with the transistor and install the pins through the holes. You may need to spread the pins apart to make them line up correctly with the board. Bend the two outer pins a little so the transistor will not fall out and turn the board over. Solder the 3 pins of the transistor and cut the excess lead off.

Step 7: .1uF capacitors<br>

![cap 1](https://github.com/Retrotink/PockeTerm-II/assets/121696513/b4f1ca5c-9019-4a8d-b8e1-dcfbb06bebc8)

Install the two .1uF (C1-C2) caps into their locations. The caps are labeled 104 and are not polarized so they can be installed either way. Fit as flush as possible, bend the 2 wires apart a little so the capacitor does not fall out, turn the board over and set it on your workspace. Solder the leads onto the PCB and cut away the excess lead length.

Step 8: .01uF capacitor <br>
![cap 01](https://github.com/Retrotink/PockeTerm-II/assets/121696513/ffa5ab7a-6fa5-4246-9df7-4ea65dda23fc)


Install the .01uF capacitor C3 into its location. The capacitor is labeled 103 and is not polarized so it can be installed either direction. Fit as flush as possible, bend the 2 wires apart a little so the capacitor does not fall out, turn the board over and set it on your workspace. Solder the leads onto the PCB and cut the excess lead length.

NOTE: We will solder the C4-C8 later on, do not install them yet.

Step 9: Jumper connectors <br>

![jumper pins](https://github.com/Retrotink/PockeTerm-II/assets/121696513/d3626de5-c1de-4c55-9a23-ae6caffa0935)

Place the 4X2 cable select jumper posts into its location. Place into the PCB and while holding the jumper, turn the PCB over and place on your workspace. Solder into place.You may want to solder only one post and turn over and inspect that it is flush. You can heat the post and adjust to get it flush on the PCB. Install the jumpers into either the STD or NULL locations vertically. This determines what type of cable you have. You can always change them later.

Step 10: LED<br>
![led](https://github.com/Retrotink/PockeTerm-II/assets/121696513/ab6c087c-7701-4c61-ad71-2bfc178b55a5)


The LED is polarized and caution must be taken to install correctly. The easiest way to tell the + lead of an LED is that one lead is longer than the other. Place that lead into the + pad on the PCB (it is a square pad) and push the LED flush onto the PCB. Next, bend the tabs apart slightly so the LED will not fall out when you turn the board over. Turn over the PCB and solder the leads onto the PCB. Cut the excess leads flush with the board.

Step 11: DB-9 Serial connector<br>

![db9](https://github.com/Retrotink/PockeTerm-II/assets/121696513/88f96161-c46a-4f7f-b1a6-cd9a67900f27)

Place the 9 pin connector into position on the board. The 2 rows of pins should line up and the retaining tabs should fit snug. Solder the pin rows and the outer retaining tabs to hold the connector securely to the pcb.

Step 12: VGA connector<br>

![vga](https://github.com/Retrotink/PockeTerm-II/assets/121696513/09b62c6e-56cd-4fdc-ab0c-45e3034e3894)

The VGA is nearly the same as the DB9 serial port except it has 3 rows of pins. Insert flush with PCB, turn and solder the inside row first, followed by the outer 2 rows. Check your work, and then solder the support tabs down.

Step 13: 10uF electrolytic capacitors<br>

![cap10](https://github.com/Retrotink/PockeTerm-II/assets/121696513/c7e23a6e-7e4a-4e91-b1af-82b1a7c92350)

The capacitors C4-C8 are polarized and must be installed correctly. They are cylinder shaped and both leads protrude from the same side and are labeled 10uF. There are two ways to tell the + and - leads. First, looking at the leads, the + is longer than the – lead. Secondly, there is a large white arrow pointing to the - lead. Install flush with the PCB and bend the two leads slightly apart from one another. Turn the board over and solder onto the PCB. Cut the excess lead and repeat for the other 2 capacitors.

Step 14: PS/2 keyboard connector<br>

![ps2](https://github.com/Retrotink/PockeTerm-II/assets/121696513/4714c28a-69ef-4dac-a793-3360bb58dc8d)

Install this part slow and carefully. If the pins are not lined up, they will push back and not go through the pcb. Place connector flush onto the PCB and hold while turning over to keep it from falling out. Place on workspace and solder onto the board. You may wish to solder just the large tab first and check to make sure it is flush before soldering the other pins down.

Step 15: The cleanup

Before you power up your board, it is recommended that you wash off the excess flux and check for any missed solder connections. I like to clean with plain water and a soft tooth brush. Run under the tap water for a minute washing off excess flux. Dry immediately with a blow dryer on low heat. You can also use canned or compressed air in place of blow dryer.

Step 16: Initial power test

Plug in your USB cable to a USB power supply or PC port. Turn on the board and make sure that your power LED comes on. 

Step 17: Next Test

Install the IC chips; connect a keyboard and VGA monitor. Power on your PockeTerm and you should get text at the bottom of your screen. You can program your settings by pressing CTRL and Fx at the same time to cycle through all the options. Your settings are automatically saved for when you power off.

Step 18: Final Test

Place the Jumper shunts sideways under STD mode. This sets the terminal in loopback mode. Power up the PockeTerm II and anything you type on the PS/2 keyboard will display on the terminal.

You are now ready to attach the PockeTerm II to your Host computer and begin using your terminal. 

# WARNING: Create at your own risk

You understand and agree that I am not liable to you or any third party for any damage to equipment or harm that may happen as a result of making this project. Create at your own risk.
