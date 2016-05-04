Pete's D3D driver for PSX emus 
------------------------------
 
Mmm... what to say?     
If my OpenGL driver doesn't work well with your gfx card, try
this D3D port :)

Enjoy!

----------------------------------------------------------------------------

Requirements:

DirectX 7 or better installed. Without DX7/DX8 you will prolly not 
even see my plugin in the emu plugin selection window.
Note: replace 'DirectX 7' with 'DirectX 6' in case you are using my
D3DDX6 plugin :)
The plugin needs a card with hardware 3d acceleration. The D3D software 
mode is not supported.
Only 16/32 bit desktop color depths are supported.
The plugin can use secondary devices (add-on cards like the Voodoo2... 
mmm... but prolly the DX6 plugin will be working better with V2 cards :P).

----------------------------------------------------------------------------

Configuration:

As with my OpenGL plugin, take yourself some time to test different 
settings, you can use my PSSwitch/ePSXeCutor configuration tool to 
store game configurations for PSEmu Pro/ePSXe. 
Here is the list of the available settings and their baddies and 
gooddies...

0) Rendering device
--------------------
If you have more than one gfx card installed (I have for example
a GeForce and Voodoo3 PCI), you can select the card you want to use
with the "Select device" button.

Some add-on cards (V2) will only work with 'Fullscreen flipping' 
enabled, but be aware, that this option can cause flickering with some
games.
FSAA is also only supported with activated 'Fullscreen flipping'
with some cards.

1) Resolution & Colors
-----------------------
Well, that section should be self-explaining.
Please note: some cards (like the 3dfx V2/V3) can't do a 32 bit
color depth, or rendering in a window (V2). Selecting an option
which your card can't handle will cause error message boxes or
missing textures or crashes... yup, sorry

2) Texture quality
-------------------
Basically there are 16 bit textures and 32 bit textures. 

* 'don't care': it's the first matching texture type your 
  card can offer... most time it will be the same as "4-4-4-4"
  textures.
* 'R4 G4 B4 A4': Every color info has 4 bits, so texture colors 
  are not as fine (the real psx can use 5 color bits), but 
  most cards should be working with that texture type.
* 'R5 G5 B5 A1': texture colors are fine in that mode. With 
  OpenGL that mode is showing black rects with 'Alpha Multipass'
  enabled, but I can use color keying with d3d for transparency,
  so it's a good choice for many cards.
* 'R8 G8 B8 A8': Best colors your PC can offer, at the cost of 
  speed and vram. If game speed is OK with that mode on your PC,  
  use it! Not possible with 3dfx V2/V3 cards, though.

Hint: 16 bit textures don't need as much vram as 32 bit textures, so
if your card has just 16 MB (or less), stick to 4-4-4-4 or 5-5-5-1

3) Texture handling
-------------------	
To optimize the texture storage, the plugin has to know the size of your
gfx card vram. You can try to let the plugin auto-detect the available
vram memory, or you can enter the right amount yourself.
If you have a lotta vram (64 MByte or higher), you can also try the
"Hi-Res texture (2xSaI)" or "Hi-Res texture (Scaled)" option. The 2xSaI one 
will use the superb 2xSaI algorithm from Derek Liauw 
(http://members.xoom.com/derek_liauw/) to improve the texture quality. 
For more informations check out the version notes from 10. July, 2002. 
The "Scaled" hires textures will need additionally some texture filtering
(best: filtering mode 2) and a screen resolution of 800x600 or above. 

4) Bilinear filtering
----------------------
Give it a try... the real PSX doesn't support BF, so there will be some
glitches if you turn BF on. Several games will look nicer... there are
two filtering modes... the Extended mode is slightly slower, but even
better with most games (be sure to use 'Dynamic caching' with extended
filtering).
If you want you can also try both filtering modes without sprite 
filtering. Some game text will be much better readable, but some
games will look weird if everything but sprites are smoothed.
Or try the new "filtering with sprite smoothing"... that one is giving
nice results most times :)

5) Framerate limit/Frame skipping
----------------------------------
You can activate FPS limitation if your game is running to fast. You can
use "Auto detect FPS limit", if you are not sure, what limit would be best 
to use or just type in a FPS rate. PAL games use 50 FPS, non-PAL 
games 60 FPS.
And if things are getting too slow... you can try Frame skipping. 
Tip: to get the 'right' speed you should enable skipping and limitation together.
You can also enable the in-game menu right from the game start
(showing the fps and let you change some gpu options while playing).
Of course you still can use the "DEL" key for showing/hiding the menu.
Btw, all gpu hotkeys are described below. If you want to change the keys,
you can use the small "..." button.

6) Offscreen Drawing
----------------------
There are now (1.48 or newer) 5 different OD modes... OD is used
to detect drawings which are outside the front/backbuffer, doing such
stuff in software (or by tweaking polygon coords).
0 (none): fastest mode, glitches in splash screens/game gfx can happen
1 (minimum): takes care of most splash screens
2 (standard): does an easy check, if software drawing is needed
3 (enhanced): does a more complicated check for soft drawing
4 (extended): does the "enhanced" check, and adds some additional buffer
swap (can cause flickering with some games)

7) Framebuffer textures
----------------------
To get whirling screen effects and psx motion blurring, there are two ways
to go:
a) set framebuffer textures to emulated vram, enable full vram primitives
(framebuffer access option) and offscreen drawing
or b) disable full vram primitives and set framebuffer textures to
'gfx card buffer' or 
c) use 'gfx card buffer & software'.
(a) will work on every system, but it will be very slow. (b) will prolly
work only with certain gfx cards with a good speed (GeForce :)... 
(c) is kinda a compromise: there will be little gfx card accessing (good for
slower gfx cards), and more software drawing instead (which will need some
cpu power). 
btw, some games will work better/faster with (b), others may need (c) instead.
You have to try that for yourself  :)
Well, ppl with slower cpus and/or gfx cards can use "black framebuffer
textures", this option will be very fast, but, of course, the special effect
will not appear!

8) Framebuffer access
---------------------
Sometimes the real psx is reading/moving the already drawn display to create
special effects. Again depending on your hardware and the game you want to 
play you may need to activate one of the available options to get all effects.
The highest setting (Full software drawing) will cause the internal soft gpu 
to paint every polygon, etc. into the emulated gpu vram. That's helpful if 
you want to see most of the fancy psx effects, but also _very_ slow.
Ah, and another hint: never use the gfx card reads/moves with FF8/FF9.

9) Advanced blending
---------------------
To get perfect lighting, you should enable this mode. Some cards
(3dfx again) can't do this in hardware (you will get no textures if 
you try), activate the "software" mode instead. The software mode can
cause some wrong double-blended areas, though, and it is slower.
If you don't mind the better lighting, you can also turn AB off,
of course.
Some games are really looking better using AB (Spyro!), try it yourself...

10) Alpha MultiPass
-------------------
Draws opaque texture pixels the way it should be. Of course it could be a bit
slower. But not much :)

11) Mask bit
------------
A really rarely used ability by the real PSX is the usage of mask bits to avoid
drawing into some parts of the screen. Well, to increase compatibility you
can turn the mask bit emulation on, but as far as I know only Silent Hill is really
needing it. If you activate it, 3D glasses should also work,
because my mask bit functions are using the ZBuffer.
Well, but if your game doesn't need the mask detection (and most games do not!),
turn it off to get more available texture vram.

12) Color dithering
-------------------
If you are using just 16Bit colors (or if you have to use it because 
you have an older 3DFX card), you can enhance shaded objects by turning 
on color dithering. If you are using a 32 bit color resolution there
is no need for dithering.

13) Scan lines
--------------
To improve the image quality you can enable scan lines which are emulating
the display of a TV screen. With the scanline brightness param you can make 
the scanline effect darker (smaller values) or brigther (bigger values). 
A special scanline mode, "Monitor dot matrix" can be enabled by setting the
brightness to "-1".

14) Unfiltered framebuffer updates
----------------------------------
MDECs and such will be bilinear filtered be default. The 'unfiltered' mode is 
faster, though (and some ppl think, it is even looking better ;)
Funny enough, GeForce cards (and prolly some other ones as well) will do
some filtering even if that option is activated (filtering on stretched blits). 
No way around that, sorry.
 
15) Screen smoothing
------------------------
This option will blur the whole screen, so 2D backgrounds will look
less pixelated. Of course it also needs a fast gfx card, and the higher
the resolution, the slower the smoothing... and less vram is available
for textures... well, it's up to you :)

16) Disable screen savers
------------------------
Helpfull if you are playing with certain joypads, and you don't want 
that suddenly the screensaver/power saving mode is kicking in.

17) Special game fixes
------------------------
Some gfx glitches are caused by the main emu core or because I've
not found out (yet) how certain things are activated on a real
psx gpu. But you can minimize bad effects with certain games by
using the internal gpu patches.... push the "..." button to see
(and activate) the list of available fixes.


Keys
----
<F8>   save screenshot to 'Snap' sub directory
<ALT>+<ENTER>  switch between window/fullscreen mode
<SHIFT> + <PAGE UP> Turn off screen smoothing
<INSERT> show/hide the gpu version (if no FPS is displayed) or an help text
(if the FPS menu is displayed)
<DEL>  show/hide FPS and option menu
  How it works: Hit <DEL> and the Framerate und the menu will appear. It
  looks like: 'FPS XXXX.X   FL< FS OD  FI  DI  AM  AB  FA  FT  GF  0 :) * 2x Ax' 

  What does it all mean? Here's the legend:

  FPS: frames per second, higher means better :)
  FL : Frame rate limiter (none, manual, auto-detect)
  FS : Frame skipping
  OD : Offscreen drawing (none, minimum, standard, enhanced, extended)
  AM : Alpha multipass 
  FI : Filtering (none, standard, extended, std without sprites, ext w/o sprites, std+smoothed sprites, ext+smoothed sprites)
  AB : Advanced blending (off, software, hardware)
  FA : Framebuffer access (emulated vram, reads, moves, reads&moves, FVP)
  FT : Framebuffer texture (emulated vram, black, gfx card buffer, gfx card buffer + software)
  GF : Special game fixes
  DI : Dithering
  0 : Screen smoothing
  :) : Smiley: mmm... not used with d3d yet, I think
  [:)] : Filled Smiley: palettized texture windows support
  *  : Shining sun... "Hardware" Advanced blending is activated and supported nicely with your card
  2x : 2xSaI hi-res textures
  A/D/G/Mx  : Analog/Digital/Gun/Mouse mode and pad number. If the main can tell the gpu the pad mode, the proper info will get displayed  M : PSX Mouse mode activated (otherwise the emu is using a digital pad mode)
  <  : Arrow for selecting

  Below every option there is a small box, if the box is filled the option 
  is active, empty box means inactive. 
  There is a small arrow you can move with the <PAGE UP> or <PAGE DOWN> keys
  to an option you want to toggle. 
  Just hit the <END>/<HOME> key to switch the selected option on or off. Changes will
  be done immediatly, you can see how the framerate is affected if an option
  is on or off.
  If you are using a manual speed limit, and the in-game menu cursor is set to FL, you
  can adjust the manual limit value by hitting <SHIFT>+ <END>/<HOME>.
  If you have found a setting that suits your game just hide the menu by 
  pressing <DEL> again.
  I don't store changed options permanently, you have to do that still in the
  main configuration dialog.


----------------------------------------------------------------------------

Some tips:

The best mode for my V3:

800x600 16 bit
5-5-5-1 textures
Offscreen drawing: extended
Advanced blending: off
Color dithering: on
Alpha multipass: on
Mask bit detection: on


The best mode for my GeForce:

800x600 32 bit
8-8-8-8 textures
Offscreen drawing: extended
Advanced blending: Hardware
Color dithering: off
Alpha multipass: on
Mask bit detection: on



Mail me your results :)

----------------------------------------------------------------------------

For version infos read the "version.txt" file.

Have fun!

Pete Bernert

EMail: BlackDove@addcom.de
Web: http://www.pbernert.com

----------------------------------------------------------------------------

Disclaimer/Licence:

This program is freeware and cannot be sold. Also this program cannot be 
distributed without written permission. This program cannot be used for 
any commercial purposes. You may not reverse engineer, decompile, or 
disassemble the enclosed software. Authors are not responsible for any 
damages that this program may cause, and are also not responsible for 
anything this plugin will be used for.

----------------------------------------------------------------------------
 
