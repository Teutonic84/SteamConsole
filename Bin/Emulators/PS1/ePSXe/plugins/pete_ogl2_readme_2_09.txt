Pete's OpenGL2 driver for PSX emus and ZiNc
------------------------------------------- 
 
Requirements:

A modern gfx card with good OpenGL support. 

The plugin has been tested by me on a GF8800GT with 512 MB vram, previous versions
have been tested with a R9700Pro with 128 MB vram, and a GF4200 with 64 MB vram. 
GeforceFX and older Geforce3/2 cards are also able to handle it, but for good 
speed and quality, at least a 64 MB card should be used.

CPUs with 2GHz or faster should be fine with all nearly all games in highest 
compatibility and quality mode.

So, if your system chokes with this plugin, use a different one (different plugin
or different system, ehehe) :)

----------------------------------------------------------------------------

Configuration:

1) Resolution & Colors
----------------------
Well, the window/fullscreen settings should be self-explaining.

Every time the GPU will be started in fullscreen mode, it will change the 
desktop to the chosen fullscreen size/color depth settings, after quitting 
the main emu your original desktop size and setting will be restored.

For widescreen users (for example a 1680x1050 desktop resolution): PSX games 
have usually a 4:3 width/height ratio. Therefore a 16:10 fullscreen mode will 
stretch the display in an ugly way. If your monitor or your gfx card driver
has no option to display 4:3 modes correctly, you can set a proper 4:3 "window
size" (in our example: 1400x1050) and activate the "Use window size in 
fullscreen mode" option in the plugin. That will produce a proper display, of
course with black borders on the left and right sides, but hey!

Note: the fullscreen/window size does (unlike my other hw/accel plugins)
not influence the image quality much (for displaying the game more "hires"):
the "Internal X/Y resolution" options are controlling the image quality. 

The "low" settings produce an original PSX alike display, like a soft 
gpu plugin. 
The "high" settings double the resolution, producing a much nicer hires 
screen. 
The "very high" settings are offering the best hires quality, but sorry to 
say: only the "very high" Y resolution will work with older cards 
and drivers, the X one will most likely crash or give an error messagebox on 
such hardware. You will need a at least a Geforce 6xxx/7xxx or an ATI 1xxxx
card to run this resolution.
The same is true for the "ultra high" Y resolution.

You can combine different X and Y settings without any compatibility 
problems, therefore the best possible quality settings for most cards are
"high X" and "very high Y" right now.

I recommend the "low" settings only with 32 MB cards (if you really want to 
try this plugin with such cards), since with X/Y resolution set to "low", 
the plugin only needs up to 4 MByte initial vram.

Both settings to "high" will need additional 16 MByte vram, for example, and 
both settings to "very high" would need 64 MB vram... all values just to start 
the plugin, without any texture loaded.

Recommended settings for 64 MB cards are X and Y set to "high", and with 
128 MB cards you can use the X=high, Y=very high settings without problems.
On 256 MB cards you can even use the "Ultra Y" settings, but be aware that
some PSX framebuffer effects will need several seconds (!!!) if "Ultra" is
activated.

The "Stretching mode" is just controlling how the display will be stretched
at your display. Most users will be satisfied with mode 0 (which is stretching
the display as much as possible), but you can also try the other aspect ratios
for your game.

The "Render mode" is just telling the plugin, how to work internally. The final 
output will be the same in all modes, but depending on your hardware some modes
may not work at all, or with different performance. Golden rule: if the plugin 
is crashing on startup, try another render mode (and disable the pixel shader 
options, and try lower internal X/Y resolutions).


2) Textures
-----------
To optimize the texture storage, the plugin has to know the size of your
gfx card vram. You can try to let the plugin auto-detect the available
vram memory, or you can enter the right amount yourself.

You can try to improve the texture look with texture filtering. But be aware
that the real psx doesn't support filtering, so most psx games are not designed
to run such textures. Result: glitches. No way around that, if you don't like it,
turn filtering off, and better use the "screen filtering" feature. 

If you have a lotta vram (128 MByte or higher), you can also try the
"Hi-Res texture (2xSaI)" or "Hi-Res texture (Scaled)" option. The 2xSaI one 
will use the superb 2xSaI algorithm from Derek Liauw 
(http://members.xoom.com/derek_liauw/) to improve the texture quality. 
The "Scaled" hires textures will need additionally some texture filtering
(best: filtering mode 2) and the "Increased internal X/Y resolution" options.

For a faster and more accurate emulation of the psx "texture window" ability,
you can enable the "pixel shader for PSX texture window emulation" option.
This option is only available for DX9 capable cards, though (no, GF4 cards are
NOT DX9 cards, sorry). If your card can use it, a small icon will be displayed 
in the gpu in-game menu.


3) Framerate limit/Frame skipping
---------------------------------
You can activate FPS limitation if your game is running to fast. You can
use "Auto detect FPS limit", if you are not sure, what limit would be best 
to use or just type in a FPS rate. PAL games use 50 FPS, non-PAL games 
60 (well, 59.94) FPS.

And if things are getting too slow... you can try Frame skipping. 
But be aware that frame skipping will reduce the compatibility alot, glitches
and flickering can and will happen.

You can configure the plugin to show the in-game menu right from the game start 
(showing the fps and let you change some gpu options while playing). Of course 
you still can use the "DEL" key for showing/hiding the menu. 
Btw, all gpu hotkeys are described below. If you want to change the keys, you 
can use the small "..." button.


4) Compatibility
----------------
This plugin is designed to give a better compatibility as my other hw/accel
plugins by default, but still I offer three options to tweak its speed.

Offscreen Drawing:
******************
Sometimes the real psx renders polygons not only into its display areas, but 
also to some other vram areas, to archive special effects like Crash Bandicoot's 
shadow in CB3. 
With OD=0 (Minimum), the plugin ignores such drawing actions - glitches in some 
games will happen. OD=1 (Standard) will detect most offscreen drawings, and 
emulate them properly. OD=2 (Extended) will do an even more expensive check, which 
is usually not needed... therefore, the default setting should be "1", and if 
you are having glitches or you are looking for a little bit extra speed, you 
can try to change it to 0 or 2.

Framebuffer effects: 
********************
Ah, the wonderful battle swirls, motion blurs, fullscreen waves, etc effects... 
this option will control how the plugin is handling such. 
The highest setting (3=Full) is the most compatible one (you should get all of 
the effects by selecting it), but it will cause an overall slowdown as well. 
The two lower modes (2=Standard and 1=Minimum) will only emulate such effects 
if the plugin detects an frambuffer action, so the game speed will only go 
down when it's really needed. The lowest setting (0=None) will ignore all FB 
effects, offering the best speed (along with the most glitches, of course).
You can check while playing a game, if the plugin is currently emulating FB 
effects: a small dithered rect symbol will appear in the gpu menu (if you 
have enabled the menu). This rect will be shown all the time in the highest mode, 
otherwise it will only appear if FB emulation is currently active in one of the lower 
modes.

Framebuffer uploads: 
********************
Another ability of the real psx gpu is to upload pictures to any part of its 
vram, and to display such areas as needed. Uploading data to a PC gfx card 
is one of the slower actions, therefore you can use this FU option to control 
how the plugin should handle psx data uploads.
The "2" (Full) mode will upload everything, which may slow down things in games. 
Luckily that mode is not needed much (to be honest, I only know one menu screen, 
which needs it), therefore the standard "1" setting is the best choice for 
most games. The "0" (Minimum) setting will ignore smaller screen uploads (such 
are done by FF8 and FF9, for example), producing a better speed (and sometimes
even improving the image quality, because that way no "low res" uploads will 
get mixed with "hires rendering").

4) Fullscreen filters
-------------------------

Screen filtering:
*****************
This option is blurring the display slightly, similar to the default display 
blurring of the soft gpu plugins. Unlike the "screen smoothing" option in my 
other hw/accel plugins, this filter will not slow things down, so use it if you 
like it (you can also toggle the option while playing by using the "SF" option 
in the gpu menu).

Shader effects
*****************
That filters will use "shaders" to do screen effects. Things will be a bit slower,
but not much (at least on modern cards). The shader effects give you more 
control over the screen smoothing, you can even select the effect level
from within the gpu in-game menu (using the "SL" option).
For custom shader files you can specify the directory where the files are stored
by clicking the small "..." button.
Please check out the 2.01/2.04 version release note for further details.
Custom shader files (for example the Scale2x algorithm) can be found on my homepage 
(http://home.t-online.de/home/PeteBernert).

Flicker fix border
******************
If you are using screen filtering or fullscreen shader effects, it may happen
that there will appear irritating flickering pixels on the screen borders.
You can overwrite those pixels by specifying a "flicker fix border" of 1 or
bigger (sometimes 1 pixel is not enough, depends on you display resolution, the
internal rendering resolution and even the shader effect you are using). Simply
increase this value until no more flickering is happening.


5) Misc
-------

Scanlines
*********
To improve the image quality you can enable scan lines which are emulating the 
display of a TV screen. With the scanline brightness param you can make the 
scanline effect darker (smaller values) or brighter (bigger values). 
A special scanline mode, "Monitor dot matrix" can be enabled by setting the
brightness to "-1".

MDEC filtering
**************
The psx movies (MDECs) will look somewhat pixelated when played on a PC monitor.
This option will smooth most mdec's display, but if your card has some problems
with texture edge clamping, a small line can appear in the right movie area.

Disable screen savers
*********************
Helpfull if you are playing with certain joypads, and you don't want that 
suddenly the screensaver/power saving mode is kicking in.

GF4/WinXP crash fix
*******************
nVidia Geforce4 WinXP drivers (Det 4X.XX/Forceware 5X.XX) are having a bug
which will crash the plugin after a few frames. Enable this option as a
workaround. Note: Geforce2/3 and FX cards don't need this fix, as well as the
GF4 Win9X drivers or older XP drivers (3X.XX or lower).

Special game fixes
******************
Some gfx glitches are caused by the main emu core or because I've not found out 
(yet) how certain things are activated on a real psx gpu, or because of buggy 
hardware drivers. But you can minimize bad effects with certain games or systems 
by using the internal gpu patches.... 
push the "..." button to see (and activate) the list of available fixes.


------------------------------------------------------------------------------------
Keys
------------------------------------------------------------------------------------
<F8>   save screenshot to 'Snap' sub directory
<ALT> + <ENTER> switch between window/fullscreen mode (can crash if 
the desktop color depth is different from the chosen fullscreen color depth)
<INSERT> show/hide the gpu version (if no FPS is displayed) or an help text
(if the FPS menu is displayed)
<DEL>  show/hide FPS and option menu

  How it works: Hit <DEL> and the Framerate und the menu will appear. It
  looks like: 'FPS XXXX.X   FL< FS OD  FI  SF  SL  FU  FE  GF [] % ( * 2x Ax' 

  What does it all mean? Here's the legend:

  FPS: frames per second, higher means better... up to 50/60 fps at least :)
  FL : Frame rate limiter (none, manual, auto-detect)
  FS : Frame skipping
  OD : Offscreen drawing (none, standard, extended)
  FI : Filtering (none, standard, extended, std without sprites, ext w/o sprites, std+smoothed sprites, ext+smoothed sprites)
  SF : Screen filtering
  SL : (Optional) shader level (off, minimum, more, medium, maximum)
  FU : Framebuffer uploads (minimum, standard, full)
  FE : Framebuffer effects (none, minimum, standard, full)
  GF : Special game fixes
  [] : Framebuffer effects are emulated right now (or "full framebuffer effects" are enabled)
  %  : Pixel shaders are used to emulate psx texture windows
  (  : Moon: 100% perfect subtract blending 
  *  : Shining sun... Advanced blending is activated and supported nicely with your card
  2x : 2xSaI hi-res textures
  A/D/G/Mx  : Analog/Digital/Gun/Mouse mode and pad number. If the main can tell the gpu the pad mode, the proper info will get displayed
  <  : Arrow for selecting

  Below every option there is a number, which is the same as the numbers in the plugin
  config window: it will show if (and on which level) an option is active. 
  If you want some help text about the options and numbers, simply hit <INSERT> while
  the FPS menu is visible.
  There is a small arrow you can move with the <PAGE UP> or <PAGE DOWN> keys
  to an option you want to toggle. 
  Just hit the <END> or <HOME> key to switch the selected option on or off. Changes 
  will be done immediatly, you can see how the framerate is affected if an option
  is on or off.
  If you are using a manual speed limit, and the in-game menu cursor is set to FL, you
  can adjust the manual limit value by hitting <SHIFT>+ <END>/<HOME>.
  If you have found a setting that suits your game just hide the menu by 
  pressing <DEL> again.
  I don't store changed options permanently, you have to do that still in the
  main configuration dialog.


----------------------------------------------------------------------------

General hints:

- In the compatibilty section, most games will work fine with all three options
set to "standard". The usual exceptions: Squaresoft games, ehehe. Especially
FF7/8/9 can be tweaked, so go and try it - or look into the 2.2 version notes :)

- The background graphics in the main screen of "Star Ocean 2" will not get
displayed right. No way to fix that yet.

- The battle transition of "Legend of Dragoon" will only be displayed fully, if
"framebuffer effects" is set to "full". It's your decision... (update: with
2.1 you can use a "special game fix" to get around that issue without "full FE"
compatibility).

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
 
