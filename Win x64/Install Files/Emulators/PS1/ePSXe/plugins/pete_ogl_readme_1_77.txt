Pete's OpenGL driver for PSX emus 
----------------------------------

Some words from the first release in spring 1999:      
During development of PSSwitch I used some of the public PSEPro plugin
sources to look how PSEPro communicates with the different plugins 
(especially the GPU drivers). After Version 1.0.12 of PSSwitch
I wanted to write my own GPU, mainly because I was curious how the 
GPUs are working but also because the only real good GPU plugin 
(Lewpys Glide) could only be used by the owners of 3DFX cards.
 
So I started to improve Duddie's SoftGPU, fixed some bugs and learned...
until I noticed, that some important GPU parts were just missing and
not even mentioned in the sources.

I cried for help... and Lewpy jumped in... he gave me the 
informations I needed most, so my GPU could grow again... and it was 
slowing down speedwise.

I had to make a decision: doing some high optimization stuff (but that's
mostly a boring and very time-consuming job) or trying to use some kind
of hardware acceleration (hey, that one sounds nice). OK, the decision
was an easy one: "acceleration" should do the work, now-a-days video cards
are "intelligent", so why don't use it? But what kind of interface should I
use? Direct3D ? My aging MSVC 5.0 compiler just supported DirectX 3, the 
download of the DirectX 6 SDK from the internet would be >70MByte (and I
have a slow connection to the net). And "NoComp" seemed to be working
on a Direct3D GPU. Well, and Segu wasn't lazy, too...

So I looked at the OpenGL API and it seemed to fit...  and there were no 
"real" OpenGL GPUs for PSEPro, all, even the one from Kazz, were just partial 
implementations.

I borrowed an OpenGL book from a friend (hi Gamma!) and got to work.

Now I spent some weekends and evenings for getting it to work and after 
some ups and downs (in one of these downs I downloaded the DirectX 6.1 
SDK and didn't want to do something with OpenGL at all in the future)  
I feel it is ready to hit the public.

Enjoy!

----------------------------------------------------------------------------

Requirements:

OpenGL... in Windows there should be a file called "opengl32.dll" in your
Windows\System directory. That's the one I am using. If your video card 
supports OpenGL, the "opengl32.dll" will just be a mapper for the faster
video driver functions, you don't have to install anything else.

If you have a 3DFX add-on card (I have a Riva TNT/GeForce and a Voodoo II/III,
so I could test both) and you want to use OpenGL with it, you should place the 
3DFX "opengl32.dll" from the 3DFX OpenGL SDK in your PSEmu Pro directory, don't
overwrite the original Microsoft dll in your System directory! You can get
that SDK from the 3DFX server (www.3dfx.com), just search for "OpenGL SDK".
Hint: Rename the "3dfxopengl.dll" into "opengl32.dll".
Don't use a MiniGL driver for Quoke (had to rename that game from ID because
I am a really dumb german grown-up and cannot make a difference between the
screen and the reality, greetings to the german BPS) or alike, the right DLL 
should be > 600 KByte (MiniGL IS NOT OpenGL).

If your video card has no OpenGL support, software emulation will be done 
from the Microsoft OpenGL32.dll, but that one is ssssslllloooooowwww. 
You can also give a "OpenGL to DirectX" mapper a try, there is one at 
www.altsoftware.com, just copy that "opengl32.dll" in your main emu directory.

If you own a nVidia card, be sure to have installed the latest drivers 
(Detonator build), they are much faster than earlier versions.

And, of course, try my D3D plugins, if your card is having OGL troubles :)

----------------------------------------------------------------------------

Configuration:

Take yourself some time to test different settings (especially texture modes),
because it seems every video card company has its own opinion what's important 
to speed up in OpenGL. Here is the list of the available settings and their
baddies and gooddies...

1) Desktop resolution
---------------------
Every time the GPU will be started in fullscreen mode, it will change the desktop to 
the chosen fullscreen size/color depth settings, after quitting the main emu your
original Desktop will be restored. If your OpenGL driver doesn't support 
this feature (for example: older 3DFX OpenGL drivers) just select a proper 
resolution that fits your actual Desktop size, and your desktop's color depth.
If your card supports OpenGL in window mode, you can give it a try. I prefer
to play my games in fullscreen, but to do the coding in window mode :)
The "keep psx aspect ratio" will insure, that the x/y ratios will be the same as
on the real psx... use it, if you like it.

2) Texture handling
-------------------	
To optimize the texture storage, the plugin has to know the size of your
gfx card vram. You can try to let the plugin auto-detect the available
vram memory, or you can enter the right amount yourself (recommended
on all non-nVidia cards).
If you have a lotta vram (64 MByte or higher), you can also try the
"Hi-Res texture (2xSaI)" or "Hi-Res texture (Scaled)" option. The 2xSaI one 
will use the superb 2xSaI algorithm from Derek Liauw 
(http://members.xoom.com/derek_liauw/) to improve the texture quality. 
For more informations check out the version notes from 10. July, 2002. 
The "Scaled" hires textures will need additionally some texture filtering
(best: filtering mode 2) and a screen resolution of 800x600 or above. 

3) Texture quality
-------------------
Please see the 'version.txt' entry '1.May 1999' for details...
* 'don't care' is how the versions minor 1.9 of my GPU were working, so 
  selecting it means no gain and no loss... just to be sure. And of course
  it is the best solution for 3DFX OpenGL drivers at the time I am typing
  this text...
* 'R4 G4 B4 A4': Every color info has 4 bits, so texture colors are not as
  fine, but speed is better with newer cards Don't use it with ATI cards,
  that mode is very slow with them.
* 'R5 G5 B5 A1': texture colors are getting better, but the 'Alpha Multipass'
  mode can't be done with just one alpha bit. Many games don't need AM
  (Spyro, Tekken) so you can select this mode for better colors. This mode
  is the fastest one.
* 'R8 G8 B8 A8': Best colors your PC can offer, at the cost of speed. If game
  speed is OK with that mode on your PC, use it!
* 'B8 G8 R8 A8': Also best colors, but the different color ordering is giving a 
  small speed up on some cards. See also the March 2003 release notes.


4) Bilinear filtering
---------------------
Give it a try... the real PSX doesn't support BF, so there will be some
glitches if you turn BF on. Several games will look nicer... there are
two filtering modes... the Extended mode is slightly slower, but even
better with most games.
If you want you can also try both filtering modes without sprite 
filtering. Some game text will be much better readable, but some
games will look weird if everything but sprites are smoothed...
Or try the new "filtering with sprite smoothing"... that one is giving
nice results most times :)

5) Framerate limit/Frame skipping
---------------------------------
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
---------------------
There are now (1.48 or newer) 5 different OD modes... OD is used
to detect drawings which are outside the front/backbuffer, doing such
stuff in software (or by tweaking polygon coords).
0 (none): fastest mode, glitches in splash screens/game gfx can happen
1 (minimum): takes care of most splash screens
2 (standard): does an easy check, if software drawing/coord tweaking is needed
3 (enhanced): does a more complicated check for soft drawing
4 (extended): does the "enhanced" check, and adds some additional buffer
swap (can cause flickering with some games)

7) Framebuffer texture
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
Sometimes the real psx is reading/moving the already drawn display to make
special effects. Again depending on your hardware and the game you want to 
play you may need to set one of the available options to get all effects.
The highest setting (Full software drawing) will cause the internal soft gpu 
to paint every polygon, etc. into the emulated gpu vram. That's helpful if 
you want to see most of the fancy psx effects, but also _very_ slow.
Ah, and another hint: never use the gfx card reads/moves with FF8/FF9.

9) Advanced blending
---------------------
Depending on your drivers OpenGL implementation using 'Advanced blending'
will be nice or slow... Some games are really looking better using AB
(Spyro!), try it yourself...

10) Alpha MultiPass
-------------------
Draws opaque texture pixels the way it should be. Of course it could be a bit
slower (and if your OpenGL driver draws black rectangles around objects, turn
this option off).

11) Mask bit
------------
A really rarely used ability of the real PSX is the usage of mask bits to avoid
drawing into some parts of the screen. Well, to increase compatibility you
can turn the mask bit emulation on, but as far as I know only Silent Hill is really
needing it. If you activate it, there are also some chances that
3D shutter glasses will work...
Another hint: because most games don't need the mask detection, you can
turn it off to get more available texture vram.

12) Line mode
-----------------
A funny mode, just displaying lines...

13) Color dithering
------------------
If you are using just 16Bit colors (or 3DFX OpenGL), you can enhance shaded
objects by turning on color dithering. Of course it will slow things a bit 
down, but not too much...

14) Scan lines
--------------
To improve the image quality you can enable scan lines which are emulating
the display of a TV screen. With the scanline brightness param you can make 
the scanline effect darker (smaller values) or brigther (bigger values). 
A special scanline mode, "Monitor dot matrix" can be enabled by setting the
brightness to "-1".

15) Unfiltered framebuffer updates/force 15 bit framebuffer updates
------------------------------------------------------------
MDECs and such will be bilinear filtered be default. The 'unfiltered' mode is
a little bit faster, though. And if you don't mind a reduced color with movies, 
you can get the best speed by selecting the 15bit framebuffer updates. 
 
16) Screen smoothing/Screen cushion
----------------------------------------------
This smoothing option will blur the whole screen, so 2D backgrounds 
will look less pixelated. Of course it also needs a fast gfx card, and the 
higher the resolution, the slower the smoothing... and less vram is available
for textures... well, it's up to you :)
The cushion option is just a 'fun' mode, I don't expect that somebody
will actually want to play a game with that effect... it emulates the fish-eye
effect of an very old TV set :)
Btw, smoothing and cushion can't be used together...

17) Disable screen savers
------------------------
Helpfull if you are playing with certain joypads, and you don't want 
that suddenly the screensaver/power saving mode is kicking in.

18) Special game fixes
------------------------
Some gfx glitches are caused by the main emu core or because I've
not found out (yet) how certain things are activated on a real
psx gpu. But you can minimize bad effects with certain games by
using the internal gpu patches.... push the "..." button to see
(and activate) the list of available fixes.


Keys
----
<F8>   save screenshot to 'Snap' sub directory
<ALT> + <ENTER> switch between window/fullscreen mode (can crash if 
the desktop color depth is different from the chosen fullscreen color depth)
<SHIFT> + <PAGE UP> Turn off screen smoothing
<INSERT> show/hide the gpu version (if no FPS is displayed) or an help text
(if the FPS menu is displayed)
<DEL>  show/hide FPS and option menu

  How it works: Hit <DEL> and the Framerate und the menu will appear. It
  looks like: 'FPS XXXX.X   FL< FS OD  FI  DI  AM  AB  FA  FT  GF 0 :) ( * 2x Ax' 

  What does it all mean? Here's the legend:

  FPS: frames per second, higher means better :)
  FL : Frame rate limiter (none, manual, auto-detect)
  FS : Frame skipping
  OD : Offscreen drawing (none, minimum, standard, enhanced, extended)
  AM : Alpha multipass
  FI : Filtering (none, standard, extended, std without sprites, ext w/o sprites, std+smoothed sprites, ext+smoothed sprites)
  AB : Advanced blending
  FA : Framebuffer access (emulated vram, reads, moves, reads&moves, FVP)
  FT : Framebuffer texture (emulated vram, black, gfx card buffer, gfx card buffer + software)
  GF : Special game fixes
  DI : Dithering
  0 : Screen smoothing/Screen cushion
  :) : Hollow Smiley: packed pixel support in 5551/4444 texture modes
  [:)] : Filled Smiley: palettized texture windows support
  (  : Moon: 100% perfect subtract blending 
  *  : Shining sun... Advanced blending is activated and supported nicely with your card
  2x : 2xSaI hi-res textures
  A/D/G/Mx  : Analog/Digital/Gun/Mouse mode and pad number. If the main can tell the gpu the pad mode, the proper info will get displayed
  <  : Arrow for selecting

  Below every option there is a small box, if the box is filled the option 
  is active, empty box means inactive. 
  There is a small arrow you can move with the <PAGE UP> or <PAGE DOWN> keys
  to an option you want to toggle. 
  Just hit the <END> or <HOME> key to switch the selected option on or off. Changes 
  will be done immediatly, you can see how the framerate is affected if an option
  is on or off.
  If you are using a manual speed limit, and the in-game menu cursor is set to FL, you
  can adjust the manual limit value by hitting <SHIFT>+ <END>/<HOME>.
  If you have found a setting that suits your game just hide the menu by 
  pressing <DEL> again.
  <SHIFT> + <PAGUP> will toggle between the smoothing/cushion/normal display,
  but only if the game has been started with the smoothing/cushion option.
  I don't store changed options permanently, you have to do that still in the
  main configuration dialog.


----------------------------------------------------------------------------

Conclusion:

After all it was a hell of coding... but it was worth the time and I will
surely enhance the driver further. I have done all the tests with BOF III 
and Spyro and some PSX demo CDs, if your favorite game doesn't work...
bad luck, sorry.

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
 
