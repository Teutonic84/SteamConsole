---------------------------------------------------------
ePSXeCutor 1.0.6.0 - frontend for ePSXe - by Pete Bernert
---------------------------------------------------------


What's new with 1.0.6.0?

- Due to multiple user suggestions: it's now possible to use
  the epsxecutor.exe commandline to start a special config
  without even showing the ePSXeCutor window.
  That means: you can do now for example an epsxecutor shurtcut
  on your desktop, and give a certain config name as cmdline. 
  If you now double-click this shortcut, ePSXeCutor will activate 
  this config, and start ePSXe with it. 

  The syntax is easy: simply add the config name after the .exe,
  for example: epsxecutor.exe Alundra2. Please note: if your config
  name contains space characters, use quotation marks (like:
  epsxecutor.exe "Final Fantasy 9"). 
  Ah, yes, and there is a special cmd line config name, called 
  QUICKSTART. if you do a shortcut like "epsxecutor.exe QUICKSTART", 
  ePSXeCutor will look after the game ID of the inserted psx game 
  cd, and start activate the config which belongs to this game 
  (if there is such a config available, of course).

- There is still Pad plugin support in this version of ePSXeCutor,
  even if ePSXe 1.6.0 doesn't support such plugins yet... maybe
  next time, eh? :)


---------------------------------------------------------

What's new with 1.0.5.3 (pre-release)?

- First of all, it's a pre-release. In the past, a new ePSXeCutor
  release only happened in union with an ePSXe release. But since
  calb is busy with real life, and the current ePSXeCutor version
  is now on my hard drive for over half a year, I've decided to
  give you an update. This frontend will work fine with ePSXe 1.5.2,
  even if some options (like the pad plugin support) will only work
  with the upcoming next ePSXe version.

- Improved cdrom GameID detection (thanx to Mike "Moose" O'Malley)

- Added pad plugin support. This "1.0.5.3" pre-release of ePSXeCutor
  will store the pad plugin selection/configs, but of course the current 
  ePSXe version (1.5.2) will ignore it. You'll have to wait for
  the next ePSXe version...

- Due to high user request: free selectable memcard files. You can either
  use the old managed memcard list, or specify two memcards with
  custom file names.
  Please note: if ePSXeCutor doesn't know the memcard file format, it
  will show a "Not formatted" text in the info bar. That doesn't mean
  that the memcard file will not work in ePSXe (since the main emu can 
  read more formats than my frontend... yup, I am too lazy to support
  everything).

- "Fast plugin configure" buttons in the "config infos" bar. Very handy.

- Small skin support: you can change the look of every button and
  icon used in ePSXeCutor. Simply place a modified "epsxecutor.bmp" 
  file into an epsxe sub-folder called "skins".
  If no skin bitmap exists, the default symbols will be used.
  In this archive I have added two skin files, the old default style one, 
  and a nicer looking XP skin.
  Ah, and you can also change the initial splash screen gfx by 
  placing a new bitmap called "epsxecutorsplash.bmp" into the "skins"
  directory.

- Last but not least: a game 'quickstart' function. You can now specify
  the CD game ID when you create a new/change an existing game 
  configuration. This ID will be used by the 'Quickstart' toolbar 
  button/menu item: simply insert a game CD you want to play, and press
  the 'Quickstart' button. ePSXeCutor will automatically read the ID
  from the inserted CD, and search into the configuration list if
  a game config linked with that ID exists. If a config is found, it
  will get selected and started automatically.

---------------------------------------------------------

What's new with 1.0.5.2?

- Adjusted the epsxe 1.5.2 options / removed epsxe options 
  which are not needed anymore

- Added memcard file export... first I wanted to do free selectable
  memcard filenames, but after looking at my source I realized that
  such would mean an hell of changes (many funcs are needing
  the currently used memcard numbers), so I decided to let you 
  easily export (and of course import) memcards with any filename
  you want to choose... kinda a compromise ;)

- Changed the memcard formating... should be more compatible
  with the real psx. 

---------------------------------------------------------

What's new with 1.0.5.1?

- Not much :) Added the new ePSXe subchannel options and
  removed the "disable cdr status" option... that's all

---------------------------------------------------------

What's new with 1.0.5?

- epsxe directory containing spaces (f.e. C:\program files\epsxe) 
  supported
- save state size display fixed
- removed obsolete epsxe options (mdec, mdec timing, cdrom 
  RT status). 
  Note: in epsxe 1.5 you can still control mdecs by command line
  options, but the old registry settings will not work anymore. 
  If you are using an older version of epsxe as well, you have
  to turn on mdec videos with an older version of epsxe or 
  epsxecutor!
- added epsxe pad config: there's a button in the "Options" screen,
  if you push that, epsxe will get started, and you can configure
  the pads as desired. Quit epsxe afterwards, all your pad 
  settings will get saved in the game configuration.
- Biggest change: compatibility info manager (see below for 
  details)

---------------------------------------------------------

What's new with 1.0.4?

- sorting the plugins in the plugin config window 
  by name, file or date (just click the list header)
- save state manager
- support for netplay plugins

---------------------------------------------------------

What's new with 1.0.3?

- dunno... ask calb :)

---------------------------------------------------------

What's new with 1.0.2?

- the internal ePSXe plugins will now be listed 
- full mem card block names 
- support for the new cdrom options

---------------------------------------------------------

What's new with 1.0.1?

- drop down list for the different gamepad types
- selection of country mode (Auto/PAL/NTSC)
- option for starting up the ePSXe GUI
- option for internal cdr... select your cdr drive in epsxe first!

---------------------------------------------------------

What's ePSXeCutor for? 

Well, ePSXe has its own gui, after you have started
the emu you can configure it easily using the menus.
But, of course, some games will need special settings
to start up, or sometimes you will want to turn off
the sound, use different plugins, etc.

So you would have to reconfigure ePSXe a lot of times,
and you would have to keep in mind the settings of a
certain game.

That's how ePSXeCutor will help you:
You can store individual settings for each game, all
game configurations will be stored in the Windows 
registry, a simple double-click on a configuration
icon will start ePSXe with the settings you have found
best for that game.

Each game configuration will store:
- plugins used, and the plugin settings
- ePSXe settings (like sound, mdec, cdr usage, command line)
- Selection of memory cards you want to use with that game
- Activated epsxe cheats (patches to make certain games work) 

There are some goodies, too, like im/export of configs,
configuration groups (for example rpg games, fighting 
games, etc.), user defined config icons, creating/copying 
memcard files, a save state file manager, a compatibility
list and so on.

Enjoy!

---------------------------------------------------------
Installation
---------------------------------------------------------

Installation is easy:

Copy all 3 files (ePSXeCutor.exe, ePSXeCutorTool.dll and
ePSXeCutorStuff.dll) into your ePSXe directory (that's
the directory which contains the main emu "epsxe.exe").

That's all (ok, you surely want to make some desktop
shortcut icon to ePSXeCutor.exe, right). Oh, yes, 
ePSXeCutor is using the MFC dlls... maybe you have to
update them to use it.

If you want to use the compatibility list manager, please
create a new sub-directory "infos" in your epsxe main
directory, and copy the info .txt files into it.

Oh, well, if you don't know how to copy files, but unfortunately
you are able to send mails... DON'T MAIL ME QUESTIONS LIKE
'how do I copy files?'... ask some cool friend or your parents
instead :)

---------------------------------------------------------
Usage
---------------------------------------------------------

If you are familar with PSSwitch, my PSEmu Pro frontend,
you will not have any troubles using ePSXeCutor.

If you don't know PSSwitch (shame on you ;), read on.

After starting ePSXeCutor you will see one sizeable
window. The main part of the window will show you
all config icons you have done so far (yeah, starting
it the first time, the list will be empty).
A simple double click on a game config icon will start
epsxe with the stored config settings.

On the left side (by default) is the group bar, it
will contain a list of game groups, if you want to
make multiple groups to keep you game configs well
ordered. The group bar will always have at least one
entry, called 'All configurations', by selecting this
entry the main window will show all available configs
you have created so far.

On the bottom (by default) is the config info bar,
it will display details of the selected configuration.

Well, on top is the menu and tool bar. Here you can
create/delete/change configurations, change the main
window view, and so on.

OK, now let us create a new configuration.

Create a new configuration
--------------------------

Simply select 'Configurations->New ePSXe configuration..'
or push the first button of the tool bar.
A new dialog window will appear, here you have to
a) enter an unique configuration name
b) choose a bmp file as icon (optional, can be empty)
c) type in some info/comment about the config
d) push 'Configure epsxe' to go to the config window

In the box below some of the current epsxe config settings
will be displayed (plugins, memcards).
After you have done the settings, push 'OK', a new
config will be born :)

Configure ePSXe
--------------------------

Well, beside creating a new configuration, the most
important part of ePSXeCutor is the definition of
the ePSXe emu options and plugins settings.

When you are creating a new config (see above) you
will need to go to the 'change ePSXe configuration'
window (by pushing 'Configure epsxe'), but you can also 
change the settings of already existing configs by 
right clicking the config icon -> 'Quick configure' or
by selecting 'Quick configure' in the main window menu.

The 'change ePSXe configuration' is divided into four 
parts:
- plugins
- memcards
- options
- cheats

In 'Plugins' all available gpu/spu/cdr/pad/net plugins will be
listed. Select a plugin, and push 'Activate'... now
that plugin will be used with the current configuration.
Push 'Configure' to change plugin options. 'Test' will
tell ya if the plugin will work, and 'About' shows some
plugin infos. You can also use a popup-menu by right-
clicking a plugin, though. Also the internal epsxe plugins
(spu/cdr/pad) will be listed, but no configuration windows are
available for the internal plugins.

'Memcards' let you create, format, copy and choose memcard
files. You should choose two different memcards for
each game configuration. Should be easy to use. Select a
memcard and push 'Set Slot 1', select another and push 
'Set Slot 2'. That's all.
If you have already existing memcard files, you can either
import them, or use them directly with the 'custom memcard'
option.

'Options' let you set the internal ePSXe thingies...
check out the ePSXe manual to get more infos ;)
Well, with the 'command line' edit you can enter
some special options, for example you can use
ISOs by the command line "-loadbin x:\game\spyro.bin".
For a full list of the command line params, simply start
the ePSXe emu with the commandline "-help" :)
A special option is called "Start ePSXe GUI", by activating
this option the ePSXe window with menus, etc., will be 
displayed and you have to start the game manually using
the ePSXe menu.
IMPORTANT: to get videos in your games you have to activate
the "mdec" option!

'Cheats'... here you can define/import/change cheat
settings and activate them... please note: the 'cheats'
here are no Gameshark, etc cheat codes! It's made for
special patch cheat codes to get some special games to
work (for example "Thousand Arms" will need the cheat
"10023458 = 0000" to work in ePSXe).


Well, that's the main config handling... but there are 
some more goodies in ePSXeCutor... lemme explain the 
Group handling now.

Creating/using groups
--------------------------

What are groups for? Well, if you have many game configs
you will want to order them.. you can change the config
icon order by dragging a configuration icon to a new
position, but if the config list grows bigger and bigger
you will want to use groups, be assured :)
Groups are displaying just some of the game configs,
the ones that belong to that special group... only
the main group 'All configurations' will show you
all configs.

To create a group just do a right-click in the group bar
and select 'new group'.
In the following window enter an unique group name and
select a suitable group icon. That's all.

When you click on the new group entry in the group bar,
the main window will just display the game configs of
that group. Well, after creating a new group, the list
will be empty, of course.

How to put a config into a group? 
a) If you activate a group, and create a new game config, 
it will be stored in the 'All configurations' group _and_ 
the activated one.
b) If you want to store an existing config in a certain
group, select the group entry which contains the config
right now (or select 'All configurations') and drag
the config icon at the group name in the group bar.

Note: you can remove a config from a group by right clicking
the config in that group and selecting 'Remove from
group'... that way the config will only removed from that
group, it will still be available in 'All configurations',
for example. If you choose 'Delete' instead, the config will
be deleted from _all_ groups.

Oki, that's the main group handling... now we'll take a
fast look at some special stuff...


Game Quickstart function
----------------------------------

You can specify the CD game ID when you create a new/change 
an existing game configuration. 

This ID will be used by the 'Quickstart' toolbar button/menu item: 
simply insert a game CD you want to play, and press the 'Quickstart' 
button. ePSXeCutor will automatically read the ID from the inserted 
CD, and search into the configuration list, if a game config linked 
with that ID exists. If a config is found, it will get selected and 
started.


Save State Manager
----------------------------------

You can use the "F1/2/3" keys in ePSXe to store/choose/load
save state files. Each file will have the game-id as file name,
and take a few MBytes of your harddrive.

The save state manager can be used to backup (export) save
state files, to import them again into the save state directory,
you can give each game save state its own name (it's easier to
search for a certain save state file that way, if you want to give 
it to a friend), and you can delete unneeded files.

If the gpu plugin has generated a small save state screen picture,
the pic will be displayed in the manager, too.

Game compatibility infos
----------------------------------

Sometimes it's hard to get a certain game to run... maybe 
special settings in the main emu or one of the plugins are
needed to fix glitches, or to get the game to run at all.
In the "game infos" window you will find a list of tested
games, and (depending on the game) more or less usefull
infos how to get it to run (or maybe the info: doesn't work
at all). 
All infos are stored in text files, each game will have its
own file in the "infos" subdirectory (GameID.txt). Look for 
emu sites hosting such psx compatibility files to increase 
your wonderfull collection of info files... who knows, maybe you
will need infos about a special game soon :)
Of course you can also create your own game info files, simply
enter the unique game ID (can be found in the root directory
of the game CD), or insert the CD in the drive and press
the "Read ID from CD" button (don't forget to select the
proper cd drive letter first). If infos already exist, they will
get displayed, otherwise you can now type in your own 
experiences with that game... hit "Save game infos" after you
made changes, and well, if you know an emu site looking for
compatibility info files, why not mail yours to them? :)
Using "Export infos" will save the selected game infos to a
new selectable directory, simply mail this file to the
compatibility site.
"Import infos" will only copy selected files into the "infos"
subdirectory, if you know how to use the Windows Explorer you
can do that yourself, of course ;)


Misc
--------------------------

Well, in the 'View' menu you can hide the bars, if you
don't need 'groups' for example. You can also decide
if you want the game configs displayed as big or small 
icons or using a report list, which will display
your game comment in the second column.

The 'Tools' menu contains:

- 'Erase all ePSXeCutor settings', that's kinda an
  uninstall of ePSXeCutor... all game configs and
  entries will be removed from your Windows registry,
  so no trash will be left.

- 'Export/Import configuration': 'Export' stores the 
  selected config settings in a windows .reg file,
  'import' will read that file and make a new
  config icon with the stored infos.

- 'Customize ePSXeCutor': Well, you can change some of
  the ePSXeCutor gui in this dialog. You can select your own
  group bar icons, if you like. You can set a background
  picture in the main window. You can change the look
  of the toolbar buttons. And you can select which config
  infos should be displayed in the info bar.


Skin support
--------------------------

You can change the look of every button and icon used in 
ePSXeCutor. Simply place a modified "epsxecutor.bmp" 
file into an epsxe sub-folder called "skins".

If no skin bitmap exists, the default symbols will be used.

You can get original bitmap and a nice looking XP style skin
from http://home.t-online.de/home/PeteBernert/epsxecutorskin.zip

You can also change the initial splash screen gfx by placing a 
new bitmap called "epsxecutorsplash.bmp" into the "skins"
directory.

---------------------------------------------------------
Final words
---------------------------------------------------------

If you are having ePSXeCutor problems or suggestions,
you can send a mail to: BlackDove@addcom.de

And, as always, have fun :)
  
Pete Bernert   




btw, great job, calb, Galtor and _demo_ :)












