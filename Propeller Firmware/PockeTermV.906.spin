''''''''''''''''''''''''''''''
''   PockeTerm              ''
''   Author: Vince Briel    ''
''   2009 Briel Computers   ''
''                          ''
''''''''''''''''''''''''''''''
'
'' Big thanks to Jeff Ledger on the VT100 code
'
'
'  Start of RAW code for testing  December 19,2008
'  Jan 10th added INVERSE mode
'  Jan 13 revised code for .04 working duel serial ports
'  Jan 15 fixed so xmodem could work by allowing data 0 up to be sent not 1 and up
'  Jan 21 added PC port on/off 7 bit ascii on/off
'  V.71 cls to cursor fixed
'  V.72 clsfrom cursor down working
'  V.73 fixed EEPROM read/write issue and no serial port functioning
'  V.74 ESC D and ESC L commands added, only 2 commands remaining
'  V.80 VT100 majority codes finished
'  V.81 Fixed cursor home to 0,0 and CLS to leave cursor where it is at after CLS
'  V.82 Made Function control keys CTRL-Fx to avoid accidental changes
'  V.83 Added CTRL-G beep sound effect
'  V.84 Added ESC[c and ESC[0c terminal ID command
'  V.85 Fixed scroll issue if beyond 36th line
'  V.86 Fixed terminal ID, now working added 300 & 115200 Baud rates
'  V.90 Added CTRL-F6 option for Carriage return to add line feed YES or NO
'  V.901 Fixed ESC[A-D so they work if no value is added
'  V.902 Modified so CR just does a Carriage Return and LF just does a linefeed
'  V.903 More adjustments to CR adjusted command
'  V.905 Fixed clear from cursor up ESC[1J did not clear line above cursor
'  V.905 Also added ESC[val@ which inserts a space at cursor location shifting data right
'  V.905 Also added ESC[valP which deletes character at cursor location shifting line data left
'  V.906 2023 Refresh version, remove sound
''              Current VT-100 Code list
''
''      ESC[m                   Turn off character attributes
''      ESC[0m                  Turn off character attributes
''      ESC[1m                  Turn bold character on (reverse)
''      ESC[7m                  Turn reverse video on
''      ESC[nA                  Move cursor up n lines
''      ESC[nB                  Move cursor down n lines
''      ESC[nC                  Move cursor right n lines
''      ESC[nD                  Move cursor left n lines
''      ESC[H                   Move cursor to upper left corner
''      ESC[;H                  Move cursor to upper left corner
''      ESC[line;columnH        Move cursor to screen location v,h
''      ESC[f                   Move cursor to upper left corner
''      ESC[;f                  Move cursor to upper left corner
''      ESC[line;columnf        Move cursor to sceen location v,h
''      ESCD                    Move/scroll window up one line
''      ESC[D                   Move/scroll window up one line
''      ESCL                    Move/scroll window up one line (undocumented)
''      ESC[L                   Move/scroll window up one line (undocumented)
''      ESCM                    Move/scroll window down one line
''      ESCK                    Clear line from cursor right
''      ESC[0K                  Clear line from cursor right
''      ESC[1K                  Clear line from cursor left
''      ESC[2K                  Clear entire line
''      ESC[J                   Clear screen from cursor down
''      ESC[0J                  Clear screen from cursor down
''      ESC[1J                  Clear screen from cursor up
''      ESC[2J                  Clear entire screen
''      ESC[0c                  Terminal ID responds with [?1;0c for VT-100 no options
''      ESC[c                   Terminal ID responds with [?1;0c for VT-100 no options
''      Esc[value@              Insert one character
''      Esc[valueP              Delete one character
''
'' List of ignored codes
''
''      ESC[xxh                 All of the ESC[20h thru ESC[?9h commands
''      ESC[xxl                 All of the ESC[20i thru ESC[?9i commands
''      ESC=                    Alternate keypad mode
''      ESC<                    Enter/Exit ANSI mode
''      ESC>                    Exit Alternate keypad mode
''      Esc5n                   Device status report                            DSR
''      Esc0n                   Response: terminal is OK                        DSR
''      Esc3n                   Response: terminal is not OK                    DSR
''      Esc6n                   Get cursor position                             DSR
''      EscLine;ColumnR         Response: cursor is at v,h                      CPR
''      Esc#8                   Screen alignment display                        DECALN
''      Esc[2;1y                Confidence power up test                        DECTST
''      Esc[2;2y                Confidence loopback test                        DECTST
''      Esc[2;9y                Repeat power up test                            DECTST
''      Esc[2;10y               Repeat loopback test                            DECTST
''      Esc[0q                  Turn off all four leds                          DECLL0
''      Esc[1q                  Turn on LED #1                                  DECLL1
''      Esc[2q                  Turn on LED #2                                  DECLL2
''      Esc[3q                  Turn on LED #3                                  DECLL3
''      Esc[4q                  Turn on LED #4                                  DECLL4


'' IN DEVELOPMENT



'  Please report any bugs to vbriel@yahoo.com


CON

  _clkmode = xtal1 + pll16x
  _xinfreq = 5_000_000

  Cursor     = 95
  VideoCls   = 0
  NUM        = %100
  CAPS       = %010
  SCROLL     = %001
  RepeatRate = 40
  video      = 16
  backspace  = $C8
'  semi       = 59
'  rowsnow    = 36

'  VT-100 values

'' Terminal Colors
   DIMCYAN           = $29
   DIMGREEN          = $27
   DIMORANGE         = $92
   DIMPINK           = $95
   DIMRED            = $C1
   PURPLE            = $99
   CLASSICAMBER      = $A2
   CLASSICAMBERDARK  = $E2
   LIGHTAMBER        = $A5
   WHITE             = $FF
   HOTPINK           = $C9
   PINK              = $D9
   RED               = $C5
   CYAN              = $7F
   DARKBLUE          = $5F
   CLASSICGREEN      = $75
   CUSTOMCOLOR       = $22
   CUSTOM1           = $45


   r1 = 31          'PC serial port receive line
   t1 = 30          'PC serial port transmit line
   r2 = 25          'Host device receive line
   t2 = 24          'Host device transmit line

   EEPROMAddr        = %1010_0000
   EEPROM_Base       = $7FE0
   i2cSCL            = 28

'' Sound Variables

'   right = 10
'   left  = 11

OBJ

  text: "VGA_1024v.906"                                                              ' VGA Terminal Driver
  kb:   "keyboard"                                                              ' Keyboard driver
  ser:  "FullDuplexSerial256"                                                   ' Full Duplex Serial Controller
  ser2: "FullDuplexSerial2562"                                                  ' 2nd Full Duplex Serial Controller
  i2c:  "basic_i2c_driver"
VAR

  word key
  Byte Index
  Byte Rx
  Byte rxbyte
'  Long Stack[100]
  Byte temp
  Byte serdata
  Long Baud
  Byte termcolor
  Long BR[8]
  Long CLR[18]
  long  i2cAddress, i2cSlaveCounter
  Byte pcport
  Byte ascii
  Byte curset
  word eepromLocation
  Byte CR
  Byte LNM
PUB main | i,j,k,remote,remote2,record,vt100,byte2,byte3,byte1,byte4,byte5,byte6,byte7,loop,var1,col,row,temp2,tempbaud,source




'  CTRA:= %00110 << 26 + 0<<9 + right
'  CTRB:= %00110 << 26 + 0<<9 + left
 ' DIRA[right]~~                 'Set Right Pin to output
'  DIRA[left]~~                  'Set Left Pin to output
'  source:=@PIANO
  LNM := 0                      'CR only sent
  i2c.Initialize(i2cSCL)
  tempbaud:=4
  CR := 0  '0= OFF 1 = CR AND LF
  ascii := 0   '0=no 1=yes
  pcport := 1 '1=pc port off, 2=on
  termcolor:=10
  curset := 5
  BR[0]:=300
  BR[1]:=1200
  BR[2]:=2400
  BR[3]:=4800
  BR[4]:=9600
  BR[5]:=19200
  BR[6]:=38400
  BR[7]:=57600
  BR[8]:=115200
  CLR[1]:=DIMCYAN
  CLR[2]:=DIMGREEN
  CLR[3]:=DIMORANGE
  CLR[4]:=DIMPINK
  CLR[5]:=DIMRED
  CLR[6]:=PURPLE
  CLR[7]:=CLASSICAMBER
  CLR[8]:=CLASSICAMBERDARK
  CLR[9]:= LIGHTAMBER
  CLR[10]:=WHITE
  CLR[11]:=HOTPINK
  CLR[12]:=PINK
  CLR[13]:=RED
  CLR[14]:=CYAN
  CLR[15]:=DARKBLUE
  CLR[16]:=CLASSICGREEN
  CLR[17]:=CUSTOMCOLOR
  CLR[18]:=CUSTOM1

'' Determine if previous settings are stored in EEPROM, if so, retrive for user
  eepromLocation := EEPROM_Base                                                 'Point i2c to EEPROM storage
  temp2 := i2c.ReadByte(i2cSCL, EEPROMAddr, eepromLocation)                     'read test byte to see if data stored
  if temp2 == 55                                                                'we have previously recorded settings, so restore them
     eepromLocation +=4                                                         'increase to next location
     tempbaud := i2c.ReadLong(i2cSCL, EEPROMAddr, eepromLocation)               'read Baud as temp
     eepromLocation +=4
     termcolor := i2c.ReadLong(i2cSCL, EEPROMAddr, eepromLocation)              'read terminal color
     eepromLocation +=4
     pcport := i2c.ReadLong(i2cSCL, EEPROMAddr, eepromLocation)                 'read pcport on/off setting
     eepromLocation +=4
     ascii := i2c.ReadLong(i2cSCL, EEPROMAddr, eepromLocation)                  'read force 7bit setting
     eepromLocation +=4
     curset := i2c.ReadLong(i2cSCL, EEPROMAddr, eepromLocation)                 'read cursor type
     eepromLocation +=4
     CR := i2c.ReadLong(i2cSCL, EEPROMAddr, eepromLocation)                     'read CR W/LF ON/OFF
     waitcnt(clkfreq/200 + cnt)




  Baud:=BR[tempbaud]
  text.start(video)
  text.color(CLR[termcolor])
  kb.startx(26, 27, NUM, RepeatRate)                                            'Start Keyboard Driver
  ser.start(r1,t1,0,baud)                                                       'Start Port2 to PC
  ser2.start(r2,t2,0,baud)                                                      'Start Port1 to main device
  Baud:=tempbaud
  text.cls(Baud,termcolor,pcport,ascii,CR)
'  text.clsupdate(Baud,termcolor,pcport,ascii,CR)
  text.inv(0)
  text.cursorset(curset)
  vt100:=0

'here's where we will wait for serial byte input to start sending data to AVR



  repeat
    key := kb.key                                                               'Go get keystroke, then return here

    if key == 194 'up arrow
       ser2.str(string(27,"[A"))
    if key == 195 'down arrow
       ser2.str(string(27,"[B"))
       'ser2.out($0A)
    if key == 193 'right arrow
       ser2.str(string(27,"[C"))
    if key == 192 'left arrow
       ser2.str(string(27,"[D"))

    if key >576
       if key <603
          key:=key-576
    if key > 608  and key < 635                                                 'Is it a control character?
       key:=key-608
    'if key >0
    '   text.dec(key)
    if key == 200
       key:=08
    if key == 203                                                               'Is it upper code for ESC key?
       key:= 27                                                                 'Yes, convert to standard ASCII value
    if key == 720
      Baud++                                                                    'is ESC then + then increase baud or roll over
      if Baud > 8
         Baud:=0
      temp:=Baud
      Baud:=BR[temp]
      ser.stop
      ser2.stop
      ser.start(r1,t1,0,baud)                                                   'ready port for PC
      ser2.start(r2,t2,0,baud)                                                  'ready port for HOST
      Baud:=temp
      text.clsupdate(Baud,termcolor,pcport,ascii,CR)
      EEPROM
    if key == 721
       if ++termcolor > 18
          termcolor:=1
       text.color(CLR[termcolor])
       'text.clsupdate(Baud,termcolor,pcport,ascii)
       EEPROM
    if key == 722
       if pcport == 1
          pcport := 0
       else
          pcport := 1
       text.clsupdate(Baud,termcolor,pcport,ascii,CR)
       EEPROM
    if key == 723
       if ascii == 0
          ascii := 1
       else
          ascii :=0
       text.clsupdate(Baud,termcolor,pcport,ascii,CR)
       EEPROM
    if key == 724
       curset++
       if curset > 7
          curset := 1
       text.cursorset(curset)
       EEPROM
    if key == 725 'F6
       if CR == 1
          CR := 0
       else
          CR := 1
       text.clsupdate(Baud,termcolor,pcport,ascii,CR)
       EEPROM
    if key <128 and key > 0                                                     'Is the keystroke PocketTerm compatible?    was 96
       ser2.tx(key)                                                             'Yes, so send it
       if key == 13
       'this probably needs to be if CR == 1
         if LNM == 1 or CR == 1'send both CR and LF?
           ser2.tx(10)          'yes, set by LNM ESC command, send LF also



'' END keyboard console routine



'LOOK FOR SERIAL INPUT HERE
    if pcport == 0                                                              'Is PC turned on at console for checking?
       remote2 := ser.rxcheck                                                   'Yes, look at the port for data
       if (remote2 > -1)                                                        'remote = -1 if no data
          ser2.tx(remote2)                                                      'Send the data out to the host device
          waitcnt(clkfreq/200 + cnt)                                            'Added to attempt eliminate dropped characters
    remote := ser2.rxcheck                                                      'Look at host device port for data
    if (remote > -1)
       if ascii == 1 'yes force 7 bit ascii
          if (remote > 127)
             remote := remote -128
       if pcport == 0
          ser.tx(remote)
'Start of VT100 code
      if remote == 27                                                                                   'vt100 ESC code is being sent
         vt100:=1
         byte1:=0
         byte2:=0
         byte3:=0
         byte4:=0
         byte5:=0
         byte6:=0
         byte7:=0
         remote:=0
         temp2:=0                                                                                       'Don't display the ESC code
      if remote == 99 and vt100 == 1                                                                    'ESC c
         remote:=0
         vt100:=0
         text.inv(0)
         text.cls(Baud,termcolor,pcport,ascii,CR)
         text.home

      if remote == 61 and vt100 == 1                                                                              'lool for ESC=
         vt100:= remote := 0


      'put ESC D and ESC M here
      if remote == 77 and vt100 == 1 'AKA ESC M
         text.scrollM
         vt100 := 0
      if remote == 68 and vt100 == 1 'AKA ESC D
         if byte2 <> 91 and byte3 <> 91 and byte4 <> 91  'not esc[D
            'text.scrollD
            vt100 := 0
      if remote == 76 and vt100 == 1 'AKA ESC L
      if remote == 91 and vt100 == 1                                                                    'look for open bracket [
         vt100:=2                                                                                       'start recording code
      if remote == 62 and vt100 == 1 or remote == 60 and vt100 == 1                                     'look for < & >
         vt100:=0 ' not sure why this is coming up, can't find in spec.
      if vt100==2 ''Check checking for VT100 emulation codes
         if remote > 10
           byte7:=byte6
           byte6:=byte5                                                                                 ' My VTCode Mini Buffer
           byte5:=byte4
           byte4:=byte3
           byte3:=byte2                                                                                 'Record the last 7 bytes
           byte2:=byte1
           byte1:=remote

         if remote == 109                                                                               'look for lowercase m
            if byte2 == 91                                                                              'if [m turn off to normal set
               text.inv(0)
               vt100:=0
            if byte2 == 49 and vt100 > 0                                                                              'is it ESC[1m BOLD
               'text.inv(1)
               vt100 := 0
            if byte2  == 55 and vt100 > 0                                                                             'is it ESC[7m?
               text.inv(1)
               vt100 := 0
            if byte2  == 48 and vt100 > 0                                                                             '0 is back to normal
               text.inv(0)
               vt100:=0
            if byte2 == 52 and vt100 > 0                                                                'is it ESC[4m underline?
               vt100:=0                                                                                 'yes ignore
            if byte2 == 50 and vt100 >0                                                                 'is it ESC[2m dim text
               vt100:=0                                                                                 'yes ignore
         if remote == 64                                                                                'look for ESC[value@ @=64   insert value spaces
            if byte4 == 91 'two digit value
               byte3:=byte3-48                                                                         'Grab 10's
               byte2:=byte2-48                                                                         'Grab 1's
               byte3:=byte3*10                                                                         'Multiply 10's
               byte3:=byte3+byte2                                                                      'Add 1's
               text.insertat(byte3)
            if byte3 == 91 'single digit value
               byte2:=byte2-48
               text.insertat(byte2)
            vt100 :=0
         if remote == 80                                                                                'look for ESC[valueP P=64   delete value spaces
            if byte4 == 91 'two digit value
               byte3:=byte3-48                                                                         'Grab 10's
               byte2:=byte2-48                                                                         'Grab 1's
               byte3:=byte3*10                                                                         'Multiply 10's
               byte3:=byte3+byte2                                                                      'Add 1's
               text.delp(byte3)
            if byte3 == 91 'single digit value
               byte2:=byte2-48
               text.delp(byte2)
            vt100 :=0
         if remote == 104                                                                               'look for lowercase h set CR/LF mode
            if byte2 == 48 'if character before h is 0 maybe command is 20h
               if byte3 == 50 'if byte3 then it is for sure 20h
                 LNM := 0
            vt100:=0

         if remote == 61                                                                                'lool for =
            vt100:=0

         if remote == 114                                                                               'look for lowercase r
            vt100:=0

         if remote == 108                                                                               'look for lowercase l
            if byte2 == 48 'if character before l is 0 maybe command is 20l
               if byte3 == 50 'if byte3 then it is for sure 20l
                 LNM := 1  '0 means CR/LF in CR mode only
            vt100:=0

         if remote == 62  'look for >
            vt100:=0
         if remote == 77                                                                                'ESC M look for obscure scroll window code
            text.scrollM
            vt100:=0
         if remote == 68 or remote == 76 ' look for ESC D  or ESC L
            text.scrollD
            vt100:=0
         if remote == 72 or remote == 102                                                               ' HOME CURSOR (uppercase H or lowercase f)
            if byte2==91 or byte2==59                                                                   'look for [H or [;f
               text.home
               vt100:=0
            '' Check for X & Y with [H or ;f   -   Esc[Line;ColumnH

            else                                                                                        'here remote is either H or f
              if byte4 == 59                                                                            'is col is greater than 9     ; ALWAYS if byte4=59
                byte3:=byte3-48                                                                         'Grab 10's
                byte2:=byte2-48                                                                         'Grab 1's
                byte3:=byte3*10                                                                         'Multiply 10's
                byte3:=byte3+byte2                                                                      'Add 1's
                col:=byte3                                                                              'Set cols

                if byte7 == 91                                                                          'Assume row number is greater than 9  if ; at byte 4 and [ at byte 7 greater than 9
                   byte6:=byte6-48                                                                      'Grab 10's
                   byte5:=byte5-48                                                                      'Grab 1's
                   byte6:=byte6*10                                                                      'Multiply 10's
                   byte6:=byte6+byte5                                                                   'Add 1's
                   row:=byte6

                if byte6 == 91                                                                          'Assume row number is less than 10
                   byte5:=byte5 - 48                                                                    'Grab 1's
                   row:=byte5

              if byte3 == 59                                                                            ' Assume that col is less an 10
                byte2:=byte2-48                                                                         'Grab 1's
                col:=byte2                                                                              'set cols

                if byte6 == 91                                                                          'Assume row number is greater than 9
                   byte5:=byte5-48                                                                      'Grab 10's
                   byte4:=byte4-48                                                                      'Grab 1's
                   byte5:=byte5*10                                                                      'Multiply 10's
                   byte5:=byte5+byte4                                                                   'Add 1's
                   row:=byte5
                if byte5 == 91                                                                          'Assume that col is greater than 10
                   byte4:=byte4-48                                                                       'Grab 1's
                   row:=byte4

              col:=col-1
              if row == -459
                 row:=1
              if col == -40    ' Patches a bug I havn't found.  *yet*
                 col := 58     ' A Microsoft approach to the problem. :)
              if row == -449
                 row := 2      ' Appears to be an issue with reading
              if row == -439   ' single digit rows.
                 row := 3
              if row == -429   ' This patch checks for the bug and replaces
                 row := 4      ' the faulty calculation.
              if row == -419
                 row := 5      ' Add to list to find the source of bug later.
              if row == -409
                 row := 6
              if row == -399
                 row := 7
              if row == -389
                 row := 8
              if row == -379
                 row := 9
              row--


              if row < 0
                 row:=0
              if col < 0
                 col:=0
              if row > 35
                 row :=35
              if col > 79
                 col := 79
              text.cursloc(col,row)
            vt100:=0
         if remote == 114       'ESCr

               text.out(126)
         if remote == 74    '' CLEAR SCREEN
            if byte2==91    '' look for [J  '' clear screen from cursor to 25
               text.clsfromcursordown
            'vt100:=0
            if byte2==50    '' look for [2J '' clear screen
               text.cls(Baud,termcolor,pcport,ascii,CR)
            if byte2==49     'look for [1J
               text.clstocursor
            if byte2==48     'look for [0J
               text.clsfromcursordown
            vt100:=0
         if remote == 66    '' CURSOR DOWN    Esc[ValueB
            if byte4 == 91 '' Assume number over 10
              byte3:=byte3-48
              byte2:=byte2-48
              byte3:=byte3*10
              byte3:=byte3+byte2
              var1:=byte3
            if byte3 == 91 '' Assume number is less 10
              byte2:=byte2-48
              var1:=byte2
            if byte2 == 91 ''ESC[B no numbers move down one
              'text.out($C3)
              var1 := 1
            loop:=0
            repeat until loop == var1
               loop++
               text.out($C3)

            vt100:=0


         if remote == 65    '' CURSOR UP   Esc[ValueA
            if byte4 == 91 '' Assume number over 10
              byte3:=byte3-48
              byte2:=byte2-48
              byte3:=byte3*10
              byte3:=byte3+byte2
              var1:=byte3
            if byte3 == 91 '' Assume number is less 10
              byte2:=byte2-48
              var1:=byte2
            if byte2 == 91 ''ESC[A no numbers move down one

              var1 := 1
            loop:=0
            repeat until loop == var1
               text.out($C2)
               loop++
            vt100:=0


         if remote == 67    '' CURSOR RIGHT   Esc[ValueC
            if byte4 == 91 '' Assume number over 10
              byte3:=byte3-48
              byte2:=byte2-48
              byte3:=byte3*10
              byte3:=byte3+byte2
              var1:=byte3
            if byte3 == 91 '' Assume number is less 10
              byte2:=byte2-48
              var1:=byte2
            if byte2 == 91 ''ESC[C no numbers move RIGHT one

              var1 := 1
            loop:=0
            repeat until loop == var1
               text.out($C1)
               loop++
            vt100:=0

         if remote == 68    '' CURSOR LEFT   Esc[ValueD  OR ESC[D
            if byte4 == 91 '' Assume number over 10
              byte3:=byte3-48
              byte2:=byte2-48
              byte3:=byte3*10
              byte3:=byte3+byte2
              var1:=byte3
            if byte3 == 91 '' Assume number is less 10
              byte2:=byte2-48
              var1:=byte2
            if byte2 == 91 ''ESC[D no numbers move LEFT one

              var1 := 1
            loop:=0
            repeat until loop == var1
               text.out($C0)   'was $C0
               loop++
            vt100:=0

         if remote == 75   '' Clear line  Esc[K
           if byte2 == 91 '' Look for [
             text.clearlinefromcursor

             vt100:=0
           if byte2  == 48 ' look for [0K
              if byte3 == 91
                 text.clearlinefromcursor

                 vt100:=0
           if byte2 == 49  ' look for [1K
              if byte3 == 91
                 text.clearlinetocursor
                 vt100 := 0
           if byte2 == 50 ' look for [2K
              if byte3 == 91
                 text.clearline

                 vt100 := 0

         if remote == 99 ' look for [0c or [c           ESC [ ? 1 ; Ps c Ps=0 for VT-100 no options
           if byte2 == 91 '' Look for [
                ser2.str(string(27,"[?1;0c"))
                vt100 := 0
           if byte2 == 48
                if byte3 == 91
                     ser2.str(string(27,"[?1;0c"))
                     vt100 := 0
         remote:=0 '' hide all codes from the VGA output.

      if record == 13 and remote == 13  ''LF CHECK
         if CR == 1
           text.out(remote)
         remote :=0
      if remote == 08
         remote := $C0    'now backspace just moves cursor, doesn't clear character
      if remote == 7
         sound(source, 4500)
     ' if remote == 10
     '    text.out($0A)
      if remote > 8
         text.out(remote)
      record:=remote ''record last byte


PUB EEPROM | eepromData
        eepromLocation := EEPROM_Base

        i2c.WriteLong(i2cSCL, EEPROMAddr, eepromLocation, 55)
        eepromLocation +=4
        i2c.WriteLong(i2cSCL, EEPROMAddr, eepromLocation, Baud)
        eepromLocation +=4
        i2c.WriteLong(i2cSCL, EEPROMAddr, eepromLocation, termcolor)
        eepromLocation +=4
        i2c.WriteLong(i2cSCL, EEPROMAddr, eepromLocation, pcport)
        eepromLocation +=4
        i2c.WriteLong(i2cSCL, EEPROMAddr, eepromLocation, ascii)
        eepromLocation +=4
        i2c.WriteLong(i2cSCL, EEPROMAddr, eepromLocation, curset)
        eepromLocation +=4
        i2c.WriteLong(i2cSCL, EEPROMAddr, eepromLocation, CR)
        waitcnt(clkfreq/200 + cnt)



PUB Sound (pWav,speed):bOK|n,i,nextCnt,rate,dcnt,wait

  pWav+=44

  i:=0
  NextCnt:=cnt  '+15000

  'Play loop
  repeat i from 0 to 1200
    NextCnt+=speed
    waitcnt(NextCnt)
    FRQA:=(byte[pWav+i])<<24
    FRQB:=FRQA

PUB forever  | i
  repeat i from 0 to 1000
     waitcnt(i*32767)
'DAT

'PIANO
'File "piano.wav"      '   <---  put your 8-bit PCM mono 8000 sample/second WAV