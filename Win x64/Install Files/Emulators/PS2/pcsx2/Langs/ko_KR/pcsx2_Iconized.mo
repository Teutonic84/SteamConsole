Þ    C      4  Y   L      °     ±  9   ;  R   u  b   È  w   +  Í   £     q  ~   	  Æ   	  `   T
  Q   µ
       Ó     /   q  M   ¡  ]   ï  «   M  G   ù  H   A  d        ï  b     Ï   ä     ´  5   <  6   r  ÷   ©     ¡  À   &  Õ   ç  ¡   ½  r  _  |   Ò  î   O    >  N  Ë  ÿ     ¤        ¿  á   X  z  :  J   µ  h          i   p   þ   G  o!     ·"     ;#     Ø#  Ù   `$     :%  í   Ì%  ¼   º&  Â   w'  ¡   :(     Ü(  *  w)  û   ¢*  ß   +  \   ~,  r   Û,     N-  ï   Ù-  °   É.  ©   z/    $0  "  ¯1     Ò3  k   c4     Ï4     \5  °   í5    6  Ý    7  ¥   ~8  !  $9     F:  r   Í:  ë   @;  ò   ,<  =   =  \   ]=  ·   º=  ß   r>  a   R?  l   ´?  |   !@  À   @     _A  $  äA  ¼   	C  G   ÆC  G   D  ^  VD  ­   µE    cF  $  qG  î   H  §  I     -K  /  ¾K  ã  îL  Ó  ÒN  v  ¦P  ð   R  Þ   S  >  íS    ,U  f   4W     W  §   %X     ÍX  Æ  ^Y  µ   %[  Ý   Û[  °   ¹\    j]  Ö   ^  *  __    `  å   a  Ù   xb    Rc  `  qd  1  Òe    g  j   h     h      i  0  ½i  ×   îj  Ú   Æk  ÿ  ¡l         >   "                 ;       6                 (   0      :                    C       +   %          8   '            2              3   .      1   @   )   4   A         5          *   $      7          =   -      #                    9      ?   B   <                   /      &       
          ,   	       !          'Ignore' to continue waiting for the thread to respond.
'Cancel' to attempt to cancel the thread.
'Terminate' to quit PCSX2 immediately.
 0 - Disables VU Cycle Stealing.  Most compatible setting! 1 - Mild VU Cycle Stealing.  Lower compatibility, but some speedup for most games. 2 - Moderate VU Cycle Stealing.  Even lower compatibility, but significant speedups in some games. 3 - Maximum VU Cycle Stealing.  Usefulness is limited, as this will cause flickering visuals or slowdown in most games. All plugins must have valid selections for %s to run.  If you are unable to make a valid selection due to missing plugins or an incomplete install of %s, then press Cancel to close the Configuration panel. Avoids memory card corruption by forcing games to re-index card contents after loading from savestates.  May not be compatible with all games (Guitar Hero). Check HDLoader compatibility lists for known games that have issues with this. (Often marked as needing 'mode 1' or 'slow DVD' Check this to force the mouse cursor invisible inside the GS window; useful if using the mouse as a primary control device for gaming.  By default the mouse auto-hides after 2 seconds of inactivity. Completely closes the often large and bulky GS window when pressing ESC or pausing the emulator. Enable this if you think MTGS thread sync is causing crashes or graphical errors. Enables automatic mode switch to fullscreen when starting or resuming emulation. You can still toggle fullscreen display at any time using alt-enter. Existing %s settings have been found in the configured settings folder.  Would you like to import these settings or overwrite them with %s default values?

(or press Cancel to select a different settings folder) Failed: Destination memory card '%s' is in use. Failed: Duplicate is only allowed to an empty PS2-Port or to the file system. Known to affect following games:
 * Bleach Blade Battler
 * Growlanser II and III
 * Wizardry Known to affect following games:
 * Digital Devil Saga (Fixes FMV and crashes)
 * SSX (Fixes bad graphics and crashes)
 * Resident Evil: Dead Aim (Causes garbled textures) Known to affect following games:
 * Mana Khemia 1 (Going "off campus")
 Known to affect following games:
 * Test Drive Unlimited
 * Transformers NTFS compression can be changed manually at any time by using file properties from Windows Explorer. NTFS compression is built-in, fast, and completely reliable; and typically compresses memory cards very well (this option is highly recommended). Note that when Framelimiting is disabled, Turbo and SlowMotion modes will not be available either. Note: Recompilers are not necessary for PCSX2 to run, however they typically improve emulation speed substantially. You may have to manually re-enable the recompilers listed above, if you resolve the errors. Notice: Due to PS2 hardware design, precise frame skipping is impossible. Enabling it will cause severe graphical errors in some games. Notice: Most games are fine with the default options. Notice: Most games are fine with the default options.  Out of Memory (sorta): The SuperVU recompiler was unable to reserve the specific memory ranges required, and will not be available for use.  This is not a critical error, since the sVU rec is obsolete, and you should use microVU instead anyway. :) PCSX2 is unable to allocate memory needed for the PS2 virtual machine. Close out some memory hogging background tasks and try again. PCSX2 requires a *legal* copy of the PS2 BIOS in order to run games.
You cannot use a copy obtained from a friend or the Internet.
You must dump the BIOS from your *own* Playstation 2 console. PCSX2 requires a PS2 BIOS in order to run.  For legal reasons, you *must* obtain a BIOS from an actual PS2 unit that you own (borrowing doesn't count).  Please consult the FAQs and Guides for further instructions. Playstation game discs are not supported by PCSX2.  If you want to emulate PSX games then you'll have to download a PSX-specific emulator, such as ePSXe or PCSX. Please ensure that these folders are created and that your user account is granted write permissions to them -- or re-run PCSX2 with elevated (administrator) rights, which should grant PCSX2 the ability to create the necessary folders itself.  If you do not have elevated rights on this computer, then you will need to switch to User Documents mode (click button below). Please select a valid BIOS.  If you are unable to make a valid selection then press Cancel to close the Configuration panel. Please select your preferred default location for PCSX2 user-level documents below (includes memory cards, screenshots, settings, and savestates).  These folder locations can be overridden at any time using the Plugin/BIOS Selector panel. Primarily targetting the EE idle loop at address 0x81FC0 in the kernel, this hack attempts to detect loops whose bodies are guaranteed to result in the same machine state for every iteration until a scheduled event triggers emulation of another unit.  After a single iteration of such loops, we advance to the time of the next event or the end of the processor's timeslice, whichever comes first. Removes any benchmark noise caused by the MTGS thread or GPU overhead.  This option is best used in conjunction with savestates: save a state at an ideal scene, enable this option, and re-load the savestate.

Warning: This option can be enabled on-the-fly but typically cannot be disabled on-the-fly (video will typically be garbage). Runs VU1 on its own thread (microVU1-only). Generally a speedup on CPUs with 3 or more cores. This is safe for most games, but a few games are incompatible and may hang. In the case of GS limited games, it may be a slowdown (especially on dual core CPUs). Speedhacks usually improve emulation speed, but can cause glitches, broken audio, and false FPS readings.  When having emulation problems, disable this panel first. The PS2-slot %d has been automatically disabled.  You can correct the problem
and re-enable it at any time using Config:Memory cards from the main menu. The Presets apply speed hacks, some recompiler options and some game fixes known to boost speed.
Known important game fixes will be applied automatically.

--> Uncheck to modify settings manually (with current preset as base) The Presets apply speed hacks, some recompiler options and some game fixes known to boost speed.
Known important game fixes will be applied automatically.

Presets info:
1 -     The most accurate emulation but also the slowest.
3 --> Tries to balance speed with compatibility.
4 -     Some more aggressive hacks.
6 -     Too many hacks which will probably slow down most games.
 The specified path/directory does not exist.  Would you like to create it? The thread '%s' is not responding.  It could be deadlocked, or it might just be running *really* slowly. There is not enough virtual memory available, or necessary virtual memory mappings have already been reserved by other processes, services, or DLLs. This action will reset the existing PS2 virtual machine state; all current progress will be lost.  Are you sure? This command clears %s settings and allows you to re-run the First-Time Wizard.  You will need to manually restart %s after this operation.

WARNING!!  Click OK to delete *ALL* settings for %s and force-close the app, losing any current emulation progress.  Are you absolutely sure?

(note: settings for plugins are unaffected) This folder is where PCSX2 records savestates; which are recorded either by using menus/toolbars, or by pressing F1/F3 (save/load). This folder is where PCSX2 saves its logfiles and diagnostic dumps.  Most plugins will also adhere to this folder, however some older plugins may ignore it. This folder is where PCSX2 saves screenshots.  Actual screenshot image format and style may vary depending on the GS plugin being used. This hack works best for games that use the INTC Status register to wait for vsyncs, which includes primarily non-3D RPG titles. Games that do not use this method of vsync will see little or no speedup from this hack. This is the folder where PCSX2 saves your settings, including settings generated by most plugins (some older plugins may not respect this value). This recompiler was unable to reserve contiguous memory required for internal caches.  This error can be caused by low virtual memory resources, such as a small or disabled swapfile, or by another program that is hogging a lot of memory. This slider controls the amount of cycles the VU unit steals from the EmotionEngine.  Higher values increase the number of cycles stolen from the EE for each VU microprogram the game runs. This wizard will help guide you through configuring plugins, memory cards, and BIOS.  It is recommended if this is your first time installing %s that you view the readme and configuration guide. Updates Status Flags only on blocks which will read them, instead of all the time. This is safe most of the time, and Super VU does something similar by default. Vsync eliminates screen tearing but typically has a big performance hit. It usually only applies to fullscreen mode, and may not work with all GS plugins. Warning!  Changing plugins requires a complete shutdown and reset of the PS2 virtual machine. PCSX2 will attempt to save and restore the state, but if the newly selected plugins are incompatible the recovery may fail, and current progress will be lost.

Are you sure you want to apply settings now? Warning!  You are running PCSX2 with command line options that override your configured plugin and/or folder settings.  These command line options will not be reflected in the settings dialog, and will be disabled when you apply settings changes here. Warning!  You are running PCSX2 with command line options that override your configured settings.  These command line options will not be reflected in the Settings dialog, and will be disabled if you apply any changes here. Warning: Some of the configured PS2 recompilers failed to initialize and have been disabled: When checked this folder will automatically reflect the default associated with PCSX2's current usermode setting.  You are about to delete the formatted memory card '%s'. All data on this card will be lost!  Are you absolutely and quite positively sure? You can change the preferred default location for PCSX2 user-level documents here (includes memory cards, screenshots, settings, and savestates).  This option only affects Standard Paths which are set to use the installation default value. You may optionally specify a location for your PCSX2 settings here.  If the location contains existing PCSX2 settings, you will be given the option to import or overwrite them. Your system is too low on virtual resources for PCSX2 to run. This can be caused by having a small or disabled swapfile, or by other programs that are hogging resources. Zoom = 100: Fit the entire image to the window without any cropping.
Above/Below 100: Zoom In/Out
0: Automatic-Zoom-In untill the black-bars are gone (Aspect ratio is kept, some of the image goes out of screen).
  NOTE: Some games draw their own black-bars, which will not be removed with '0'.

Keyboard: CTRL + NUMPAD-PLUS: Zoom-In, CTRL + NUMPAD-MINUS: Zoom-Out, CTRL + NUMPAD-*: Toggle 100/0 Project-Id-Version: PCSX2 0.9.9
Report-Msgid-Bugs-To: https://github.com/PCSX2/pcsx2/issues
POT-Creation-Date: 2016-02-21 11:51+0100
PO-Revision-Date: 2014-01-14 19:47+0900
Last-Translator: 99skull <99skull@gmail.com>
Language-Team: 99skull,p695091 <99skull@gmail.com>
Language: ko_KR
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Poedit-KeywordsList: pxE;pxEt
X-Poedit-SourceCharset: UTF-8
X-Poedit-Basepath: trunk\
X-Generator: Poedit 1.6
X-Poedit-SearchPath-0: pcsx2
X-Poedit-SearchPath-1: common
 ì¤ë ëì ìëµì ìí ëê¸°ë¥¼ ê³ìíë ¤ë©´ 'ë¬´ì'
ì¤ë ëë¥¼ ì·¨ìíë ¤ë©´ 'ì·¨ì'
PCSX2ë¥¼ ì¦ì ì¢ë£íë ¤ë©´ 'ì¢ë£'
 0 - ë²¡í° ì ë ì¬ì´í´ íì¹ê¸°ë¥¼ ë¹íì±íí©ëë¤. ê°ì¥ í¸íì±ì´ ì¢ì ì¤ì ìëë¤! 1 - ê°ë²¼ì´ ë²¡í° ì ë ì¬ì´í´ íì¹ê¸°. ë ë®ì í¸íì±ì´ì§ë§, ëë¶ë¶ì ê²ìì ì½ê°ì ìë ìì¹ì ì¤ëë¤. 2 - ì ë¹í ë²¡í° ì ë ì¬ì´í´ íì¹ê¸°. ë³´ë¤ ë ë®ì í¸íì±ì´ì§ë§, ì¼ë¶ ê²ììì ìë¹í ìë ìì¹ì ì¤ëë¤. 3 - ìµë ë²¡í° ì ë ì¬ì´í´ íì¹ê¸°. ì ì©ì±ì´ ì íëë ëì, ì´ê²ì ëë¶ë¶ì ê²ììì ê¹ë¹¡ì´ë ë¹ì£¼ì¼ ëë ëíì ìì¸ì´ ë©ëë¤. ëª¨ë  íë¬ê·¸ì¸ì %së¥¼ ì¤ííê¸° ìí´ ì ì í ì íëì´ì¼ í©ëë¤. ë¹ì ì íë¬ê·¸ì¸ ëë½ì¼ë¡ ì¸í´ %s ì¤ì¹ê° ë¶ìì í´ì ì ì í ì íì í  ì ìë¤ë©´, ë¤ì ì·¨ìë¥¼ ëë¬ì êµ¬ì± í¨ëì ë«ì¼ì­ìì¤. ìí ì ì¥ìì ë¶ë¬ì¨ ë¤ì ì¹´ë ë´ì©ì ê°ì ë¡ ê²ìì ë¤ì-ì ë ¬íì¬ ë©ëª¨ë¦¬ ì¹´ëì ììì ë°©ì§í©ëë¤. ëª¨ë  ê²ìê³¼ í¨ê» í¸íëì§ ìì ì ììµëë¤ (ê¸°í íì´ë¡). ì´ ë¬¸ì ê° ìë ¤ì§ ê²ìì ëí´ íëë¡ë í¸í ëª©ë¡ì íì¸íì­ìì¤ (ì¢ì¢ íìì ë°ë¼ 'ë°©ì 1' ëë 'ëë¦° DVD'ë¡ íìë©ëë¤) ê°ì ë¡ ë§ì°ì¤ ì»¤ìë¥¼ GS ì°½ ë´ë¶ìì ë³´ì´ì§ ìê² íë ¤ë©´ ì´ ìµìì ì ííì­ìì¤; ê²ìì ìí ì£¼ ì ì´ ì¥ì¹ë¡ ë§ì°ì¤ë¥¼ ì¬ì©íë ê²½ì° ì ì©í©ëë¤. ê¸°ë³¸ì ì¼ë¡ ë§ì°ì¤ê° ë¹íëì 2ì´ íì ì»¤ìë¥¼ ìëì¼ë¡ ì¨ê¹ëë¤. ESCë¥¼ ëë¥´ê±°ë ìë®¬ë ì´í°ë¥¼ ì¤ì§í  ë ë³´íµ í¬ê±°ë ì¡ì¤í ê·¸ëí½ í©ì±ê¸°(GS) ì°½ì ìì í ë«ìµëë¤. ì¶©ë ëë ê·¸ëí½ ì¤ë¥ ë°ìì´ MTGS ì¤ë ë ëê¸°íë¼ê³  ìê°ëë©´ ì´ê²ì íì±íí©ëë¤. íì±íë¥¼ íë©´ ìë®¬ë ì´ìì´ ììëê±°ë ë¤ì ììë  ë ì ì²´íë©´ ë°©ìì¼ë¡ ìë ë³íë©ëë¤. ë¹ì ì ì¬ì í Alt+Enterë¥¼ ì¬ì©íì¬ ì¸ì ë ì§ ì ì²´íë©´ íìë¥¼ ì íí  ì ììµëë¤. ê¸°ì¡´ %s ì¤ì ì´ êµ¬ì±ë ì¤ì  í´ëìì ë°ê²¬ëììµëë¤. ì´ ì¤ì ì ê°ì ¸ì¤ê±°ë ê·¸ê²ì %s ê¸°ë³¸ ê°ì¼ë¡ ë®ì´ ì°ìê² ìµëê¹?

(ìëë©´, ë¤ë¥¸ ì¤ì  í´ëë¥¼ ì ííìë ¤ë©´ ì·¨ìë¥¼ ëë¥´ì­ìì¤) ì¤í¨: ëì  '%s' ë©ëª¨ë¦¬ ì¹´ëê° ì¬ì© ì¤ìëë¤. ì¤í¨: ë³µì¬ë ì¤ì§ ë¹ì´ìë PS2-í¬í¸ ëë íì¼ ìì¤íì íì©ë©ëë¤. ë¤ìê³¼ ê°ì ê²ìì ìí¥ì ì¤ëë¤:
 * ë¸ë¦¬ì¹ ë¸ë ì´ë ë°°íë¬
 * ê·¸ë¡ì°ëì â¡, â¢
 * ìì ëë¦¬
 * ëë£¨í  ì°ì¦ë§í¤ì¸ì , ëë­ì ì¤í¼ë¦¿ì¸  ë¤ìê³¼ ê°ì ê²ìì ìí¥ì ì¤ëë¤:
 * ëì§í¸ ë°ë¹ ì¬ê° (FMV ë° ì¶©ë ìì )
 * SSX (ìëª»ë ê·¸ëí½ ë° ì¶©ë ìì )
 * ë ì§ëí¸ ì´ë¸: ë°ë ìì (ìì ë³´ê¸° íë  íì¤ì² ì ë°) ë¤ìê³¼ ê°ì ê²ìì ìí¥ì ì¤ëë¤:
 * ë§ë ì¼ë¯¸ì 1("ìº í¼ì¤ë¥¼ ë ë " ë)
 ë¤ìê³¼ ê°ì ê²ìì ìí¥ì ì¤ëë¤:
 * íì¤í¸ ëë¼ì´ë¸ ì¸ë¦¬ë¯¸í°ë
 * í¸ëì¤í¬ë¨¸ NTFS ìì¶ì ìëì° íìê¸°ìì íì¼ ìì±ì ì¬ì©íì¬ ì¸ì ë ì§ ìëì¼ë¡ ë³ê²½í  ì ììµëë¤. NTFS ìì¶ì´ ë´ì¥ëì´ ìì¼ë©°, ë¹ ë¥´ê³ , ìë²½íë©° ì ë¢°í  ì ììµëë¤; í¹ì§ì ì¼ë¡ íì¤í ë©ëª¨ë¦¬ ì¹´ëë¥¼ ìì¶í©ëë¤ (ì´ ìµìì ì ê·¹ ê¶ì¥í©ëë¤). ì íë íë ìì´ ë¹íì±íë  ë, í°ë³´ì ëë¦° ëì ë°©ì ì¤ íëë¥¼ ì¬ì©í  ì ìì¼ë ì£¼ìíì­ìì¤. ì£¼ì: PCSX2ë¥¼ ì¤ííëë° ë¦¬ì»´íì¼ë¬ë íìíì§ ììµëë¤, ê·¸ë¬ë ë³´íµì ìë®¬ë ì´ì ìëë¥¼ ìë¹í ê°ì ìí¬ ì ììµëë¤. ë¹ì ì ì¤ë¥ë¥¼ í´ê²°íê¸° ìí´ ìëì¼ë¡ ìì ëì´ë ë¦¬ì»´íì¼ë¬ë¥¼ ë¤ì-íì±íí  ì ììµëë¤. ì£¼ì: PS2ì íëì¨ì´ ì¤ê³ë¡ ì¸í, ì íí íë ì ìëµì´ ë¶ê°ë¥í©ëë¤. ì´ê²ì íì±ííë©´ ì¼ë¶ ê²ììì ì¬ê°í ê·¸ëí½ ì¤ë¥ê° ë°ìí©ëë¤. ì£¼ì: ëë¶ë¶ì ê²ìì ê¸°ë³¸ ìµìì¼ë¡ ì ìëí©ëë¤. ì£¼ì: ëë¶ë¶ì ê²ìì ê¸°ë³¸ ìµìì¼ë¡ ì ìëí©ëë¤. ë©ëª¨ë¦¬ ë¶ì¡±(ë¹ì·í ì¢ë¥): ìí¼ ë²¡í° ì ë ë¦¬ì»´íì¼ë¬ê° íìí í¹ì  ë©ëª¨ë¦¬ ë²ìë¥¼ ìì½í  ì ìì¼ë©°, ì¬ì©í  ì ììµëë¤. ìí¼ ë²¡í° ì ëì ë¹íëì§ ììµëë¤, ëë¬¸ì ì´ê²ì ì¤ìí ì¤ë¥ê° ìëëë¤, ë¹ì ì ì´ì¨ë  ëì  ë§ì´í¬ë¡ ë²¡í° ì ëì ì¬ì©íì­ìì¤. :) PCSX2ë PS2 ê°ì ë¨¸ì ì íìí ë©ëª¨ë¦¬ë¥¼ í ë¹í  ì ììµëë¤. ì¼ë¶ ë©ëª¨ë¦¬ë¥¼ ì ì íë ë°±ê·¸ë¼ì´ë ììì ë«ê³  ë¤ì ìëíì­ìì¤. PCSX2ë ê²ìì ì¤ííê¸° ìí´ PS2ì ë°ì´ì¤ì¤ *ë²ì * ì¬ë³¸ì´ íìí©ëë¤.
ì¹êµ¬ ëë ì¸í°ë·ì¼ë¡ ë¶í° ì»ì ì¬ë³¸ì ì¬ì©í  ì ììµëë¤.
*ìì ì* íë ì´ì¤íì´ì 2 ì½ìë¡ ë¶í° ë°ì´ì¤ì¤ë¥¼ ë¤íí´ì¼ í©ëë¤. PCSX2ë¥¼ ì¤ííê¸° ìí´ PS2 ë°ì´ì¤ì¤ê° íìí©ëë¤. ë²ì ì¸ ì´ì ë¡, ë¹ì ì *ë°ëì* ìì ì´ ìì í ì¤ì  PS2 ì ëìì ë°ì´ì¤ì¤ë¥¼ ì»ì´ì¼ í©ëë¤ (ë¹ë¦°ê²ë í¬í¨ëì§ ììµëë¤). ì¶ê° ì¤ëªì ëí FAQ ë° ìë´ë¥¼ ì°¸ì¡°íì­ìì¤. íë ì´ì¤íì´ì ê²ì ëì¤í¬ë PCSX2ìì ì§ìëì§ ììµëë¤. ë¹ì ì´ PSX ê²ìì ìë®¬ë ì´í¸íê³  ì¶ì ê²½ì° ë¹ì ì ePSXe ëë PCSXì ê°ì í¹ì  PSX ìë®¬ë ì´í°ë¥¼ ë¤ì´ë¡ëí´ì¼ í©ëë¤. ì´ í´ëë¥¼ ìì±íê³  ê·¸ê²ì ì°ê¸° ê¶íì´ ë¶ì¬ëì´ ìëì§ ì¬ì©ì ê³ì ì íì¸íì­ìì¤ -- ëë PCSX2ìê² íìí í´ë ìì²´ë¥¼ ë§ë¤ ì ìë (ê´ë¦¬ì) ê¶íê³¼ í¨ê» ë¥ë ¥ì ë¶ì¬í ë¤ PCSX2ë¥¼ ë¤ì-ì¤íí©ëë¤. ì´ ì»´í¨í°ì ëí ëì ê¶íì´ ìë ê²½ì°, ë¹ì ì ì¬ì©ì ë¬¸ì ë°©ìì¼ë¡ ì íí´ì¼ í©ëë¤ (ìë ë²í¼ì ëë¥´ì­ìì¤). ì í¨í ë°ì´ì¤ì¤ë¥¼ ì ííì­ìì¤. ë¹ì ì´ íì¤í ì íì í  ì ìë¤ë©´ ì·¨ìë¥¼ ëë¬ êµ¬ì± í¨ëì ë«ì¼ì­ìì¤. ìëì PCSX2ì ì¬ì©ì-ìì¤ ë¬¸ìë¥¼ ìí ìíë ê¸°ë³¸ ìì¹ë¥¼ ì ííì­ìì¤ (ë©ëª¨ë¦¬ ì¹´ë, ì¤ëì·, ì¤ì  ë° ìí ì ì¥ ë±ì í¬í¨í©ëë¤). ì´ í´ë ìì¹ë íë¬ê·¸ì¸/ë°ì´ì¤ì¤ ì íê¸° í¨ëì ì¬ì©íì¬ ì¸ì ë ì§ ì¬ì ì í  ì ììµëë¤. ê¸°ë³¸ì ì¸ ì»¤ë ë´ì 0x81FC0 ì£¼ììì ì´ëª¨ììì§ ìì´ë¤ ë£¨íë¥¼ ëìì¼ë¡ í©ëë¤, ì´ íµì ìì ë ì´ë²¤í¸ê° ë¤ë¥¸ ì ëì ìë®¬ë ì´ìì ë°ìí  ëê¹ì§, ëª¨ë  ë°ë³µì ëí ëì¼í ë¨¸ì  ìíì ê²°ê³¼ë¥¼ ë³´ì¥íë ííì ë£¨íë¥¼ ê²ìíë ¤ê³  ìëí©ëë¤. ì´ë¬í ë£¨íì ë¨ì¼ ë°ë³µ ë¤ì, ë¤ì ì´ë²¤í¸ ìê°ê¹ì§ ë¨¼ì  ëì°©íë íë¡ì¸ìì íì ì¬ë¼ì´ì¤ì ëì¼ë¡ ì´ëí©ëë¤. MTGS ì¤ë ë ëë GPU ì¤ë² í¤ëë¡ ì¸í ë²¤ì¹ ë§í¬ ë¸ì´ì¦ë¥¼ ì ê±°í©ëë¤. ì´ ìµìì ìµìì ìí ì ì¥ê³¼ í¨ê» ì¬ì©ë©ëë¤:
ìíë ì¥ë©´ìì ìíë¥¼ ì ì¥íê³ , ì´ ìµìì íì±íí ë¤, ìí ì ì¥ì ë¤ì-ë¶ë¬ìµëë¤.

ê²½ê³ : ì´ ìµìì ê·¸ë ê·¸ë íì±íí  ì ìì§ë§ ì¼ë°ì ì¼ë¡ ê·¸ë ê·¸ë ë¹íì±íë¥¼ í  ì ììµëë¤ (ë¹ëì¤ë ì¼ë°ì ì¼ë¡ ì°ë ê¸°ê° ë  ê²ëë¤) ìì ì ì¤ë ëì VU1ì ì¤íí©ëë¤ (ë§ì´í¬ë¡VU1-ì ì©). ì¼ë°ì ì¼ë¡ 3ê° ì´ìì ì½ì´ë¥¼ ê°ì§ CPUìì ìëê° ìì¹í©ëë¤. ì´ê²ì ëë¶ë¶ì ê²ììì ìì íì§ë§, ì½ê°ì ê²ìì´ í¸íëì§ ìì¼ë©° ê±¸ë¦´ì§ ëª¨ë¦ëë¤. GSê° ì íë ê²ìì ê²½ì°ë, ëíë ì§ë ëª¨ë¦ëë¤ (í¹í ëì¼ì½ì´ CPUì...) ì¤í¼ë íµì ë³´íµ ìë®¬ë ì´ì ìëë¥¼ ê°ì íì§ë§, ìì ê²°í¨, ì¤ëì¤ ê¹¨ì§, ê±°ì§ FPS ê²ì¶ì ìì¸ì´ ë  ì ììµëë¤. ìë®¬ë ì´ì ë¬¸ì ê° ë°ìí  ë, ë¨¼ì  ì´ í¨ëì ë¹íì±ííì­ìì¤. PS2ì ì¬ë¡¯ %d ì´ ìëì¼ë¡ ë¹íì±í ëììµëë¤. ë¹ì ì ë¬¸ì ë¥¼ í´ê²°í  ì ììµëë¤;
ë©ì¸ ë©ë´ìì ë©ëª¨ë¦¬ ì¹´ë êµ¬ì±ì ì¬ì©íì¬ ì¸ì ë ì§ ë¤ì-íì±íí  ì ììµëë¤. ì´ ì¬ì  ì¤ì ì ì¤í¼ë íµ, ì¼ë¶ ë¦¬ì»´íì¼ë¬ ìµìê³¼ ìë ì¦ê°ë¡ ìë ¤ì§ ì¼ë¶ ê²ì ìì ì ì ì©í©ëë¤.
ìë ¤ì§ ì¤ìí ê²ì ìì ì´ ìëì¼ë¡ ì ì©ë©ëë¤.

--> ìëì¼ë¡ ì¤ì ì ë³ê²½íë ¤ë©´ íì¸ëì ì ííì­ìì¤ (íì¬ ì¬ì  ì¤ì ì ê¸°ë³¸ì¼ë¡) ì´ ì¬ì  ì¤ì ì ì¤í¼ë íµ, ì¼ë¶ ë¦¬ì»´íì¼ë¬ ìµìê³¼ ìë ì¦ê°ë¡ ìë ¤ì§ ì¼ë¶ ê²ì ìì ì ì ì©í©ëë¤.
ìë ¤ì§ ì¤ìí ê²ì ìì ì´ ìëì¼ë¡ ì ì©ë©ëë¤.

ì¬ì  ì¤ì  ì ë³´:
1 -   ê°ì¥ ì íí ìë®¬ë ì´ì ê·¸ë¬ë ëí ê°ì¥ ëë¦½ëë¤.
3 --> í¸íì±ê³¼ ìëì ê· íì ì´ë£¨ë ¤ê³  í©ëë¤.
4 -   ì¢ ë ê³µê²©ì ì¸ íµì ì¬ì©í©ëë¤.
6 -   ëë¬´ ë§ì íµì ì¬ì©íì¬ ìë§ë ëë¶ë¶ì ê²ì ìëë¥¼ ëë¦¬ê² í©ëë¤.
 ì§ì ë ê²½ë¡/ëë í ë¦¬ê° ì¡´ì¬íì§ ììµëë¤. ë¹ì ì ê·¸ê²ì ë§ëìê² ìµëê¹? '%s' ì¤ë ëê° ìëµíì§ ììµëë¤. êµì°© ìíì´ê±°ë, ë¤ë§ *ì¤ì ë¡* ëë¦¬ê² ì¤íëë ê²ì¼ì§ë ëª¨ë¦ëë¤. íìí ê°ì ë©ëª¨ë¦¬ ë§¤íì ì´ë¯¸ ë¤ë¥¸ íë¡ì¸ì, ìë¹ì¤ ëë DLLì ìí´ ìì½ëì´ ì¶©ë¶í ê°ì ë©ëª¨ë¦¬ë¥¼ ì´ì©í  ì ììµëë¤.  ì´ ììì ê¸°ì¡´ PS2ì ê°ì ë¨¸ì  ìíë¥¼ ë¦¬ìí  ê²ìëë¤; íì¬ì ëª¨ë  ì§íì ìê² ë  ê²ìëë¤. íì¤íê°ì? ì´ ëªë ¹ì %s ì¤ì ì ì§ì°ê³  ì²ì ë§ë²ì¬ë¥¼ ë¤ì-ì¤íí  ì ììµëë¤. ì´ê²ì ìëí ë¤ì %së¥¼ ìëì¼ë¡ ë¤ì ììí´ì¼ í©ëë¤.

ê²½ê³ ! %sì ëí *ëª¨ë * ì¤ì  ë° ìì© íë¡ê·¸ë¨ì´ ê°ì ë¡ ë«íë©° íì¬ì ëª¨ë  ìë®¬ë ì´ì ì§íì ìê²ë©ëë¤. ì­ì íë ¤ë©´ íì¸ì ëë¥´ì­ìì¤.  ì ë§ë¡ íì¤íê°ì?

(ì£¼ì: íë¬ê·¸ì¸ì ëí ì¤ì ì ìí¥ë°ì§ ììµëë¤) ì´ í´ëë PCSX2ì ê¸°ë¡ì ìí ì ì¥íë ê³³ìëë¤; ë©ë´/ëêµ¬ ëª¨ì ì¤ íëë¥¼ ì¬ì©íê±°ë F1/F3ì ëë¥´ë©´ ê¸°ë¡ë©ëë¤ (ì ì¥íê¸°/ë¶ë¬ì¤ê¸°). ì´ í´ëë PCSX2ì ë¡ê·¸ íì¼ ë° ì§ë¨ ë¤íë¥¼ ì ì¥íë ê³³ìëë¤. ëí ëë¶ë¶ì íë¬ê·¸ì¸ì ì´ í´ëì ì¶©ì¤í©ëë¤, ê·¸ë¬ë ì¼ë¶ ì¤ëë íë¬ê·¸ì¸ì ë¬´ìí ì§ ëª¨ë¦ëë¤. ì´ í´ëë PCSX2ì ì¤ëì·ì ì ì¥íë ê³³ìëë¤. ì¤ì  ì¤ëì· ì´ë¯¸ì§ íìê³¼ ì¤íì¼ì ì¬ì©ì¤ì¸ GS íë¬ê·¸ì¸ì ë°ë¼ ë¤ë¥¼ ì ììµëë¤. ì´ íµì ì£¼ë¡ 3Dê° ìë RPG íì´íì í¬í¨íì¬, ìì§ëê¸°ë¥¼ ê¸°ë¤ë¦¬ë INTC ìí ë ì§ì¤í°ë¥¼ ì¬ì©íë ê²ìì ê°ì¥ ì í©í©ëë¤. ì´ë° ìì§ëê¸° ë°©ë²ì ì¬ì©íì§ ìë ê²ìì ì´ íµì¼ë¡ ìë ìì¹ì ê±°ì ë³¼ ì ììµëë¤. ì´ê³³ì ëë¶ë¶ì íë¬ê·¸ì¸ì ìí´ ë§ë¤ì´ì§ ì¤ì ì í¬í¨íì¬, PCSX2ì ì¤ì ì ì ì¥íë í´ëìëë¤ (ì¼ë¶ ì¤ëë íë¬ê·¸ì¸ì ì´ ê°ì ì¡´ì¤íì§ ìì ì ììµëë¤). ì´ ë¦¬ì»´íì¼ë¬ë ë´ë¶ ìºìë¥¼ ìí íìí ì°ì ë©ëª¨ë¦¬ë¥¼ ìì½í  ì ììµëë¤. ì´ ì¤ë¥ë ìê±°ë ë¹íì±íë êµì²´ íì¼, ëë ë©ëª¨ë¦¬ë¥¼ ë§ì´ ì ì íë ë¤ë¥¸ íë¡ê·¸ë¨ìì ê°ì ë©ëª¨ë¦¬ ìì ë¶ì¡±ì¼ë¡ ì¸í´ ë°ìí  ì ììµëë¤.  ì´ ì¬ë¼ì´ëë ì´ëª¨ììì§ìì ë²¡í° ì ëì´ íì¹ë ì¬ì´í´ì ìì ì ì´í©ëë¤. ëì ê°ì ê°ê°ì ë²¡í° ì ë ë§ì´í¬ë¡ íë¡ê·¸ë¨ì´ ê²ì ì¤íì ìí´ ì´ëª¨ììì§ìì íì¹ ì¬ì´í´ ìë¥¼ ì¦ê° ìíµëë¤. ì´ ë§ë²ì¬ë íë¬ê·¸ì¸, ë©ëª¨ë¦¬ ì¹´ë ë° ë°ì´ì¤ì¤ êµ¬ì±ì íµíì¬ ë¹ì ì ìë´íëë° ëìì ì¤ ê²ìëë¤. %s ì¤ì¹ê° ì²ìì¸ ê²½ì° Readme íì¼ê³¼ êµ¬ì± ìë´ë¥¼ ë³´ìê¸¸ ê¶ì¥í©ëë¤. í­ì ìë°ì´í¸íì§ ìê³  ì½ì´ì§ë ë¸ë¡ìë§ ìí íëê·¸ë¥¼ ìë°ì´í¸ í©ëë¤. ì´ê²ì ëë¶ë¶ì ê²½ì° ìì íë©°, ìí¼ ë²¡í° ì ëì ê¸°ë³¸ì ì¼ë¡ ë¹ì·í ëìì í©ëë¤. ìì§ëê¸°ë íë©´ì´ ë¶ê·ì¹íê² ë²ì´ëë íì ê²°í¨ íì(í°ì´ë§)ì ì ê±°íì§ë§, ì¼ë°ì ì¼ë¡ í° ì±ë¥ ì íê° ììµëë¤. ì´ê²ì ë³´íµ ì ì²´íë©´ ë°©ìììë§ ì ì©ëë©°, ëª¨ë  GS íë¬ê·¸ì¸ìì ìëëì§ ììì§ë ëª¨ë¦ëë¤. ê²½ê³ ! íë¬ê·¸ì¸ì ë³ê²½íë©´ PS2ì ê°ì ë¨¸ì ì ìì í ì¤ë¨íëê° ë¦¬ìì´ íìí©ëë¤. PCSX2ë ìíë¥¼ ì ì¥íê³  ë³µìíë ¤ê³  ìëíì§ë§, ìë¡ ì íë íë¬ê·¸ì¸ì´ í¸íëì§ ìë ê²½ì° íë³µëì§ ìì¼ë©°, íì¬ ì§íì ìê² ë©ëë¤.

ì§ê¸ ì¤ì ì íì¤í ì ì©íìê² ìµëê¹?  ê²½ê³ ! ë¹ì ì êµ¬ì±ë íë¬ê·¸ì¸ ë°/ëë í´ë ì¤ì ì ë¬´ìíê³  ëªë ¹ ì¤ ìµìê³¼ í¨ê» PCSX2ë¥¼ ì¤ííê³  ììµëë¤. ì´ ëªë ¹ ì¤ ìµìì ì¤ì  ë¤ì´ì¼ë¡ê·¸ì ë°ìëì§ ìì¼ë©°, ë¹ì ì´ ì¬ê¸°ìì ì¤ì  ë³ê²½ì ì ì©í  ë ë¹íì±í ë  ê²ìëë¤. ê²½ê³ ! ë¹ì ì êµ¬ì±ë ì¤ì ì ë¬´ìíê³  ëªë ¹ ì¤ ìµìê³¼ í¨ê» PCSX2ë¥¼ ì¤ííê³  ììµëë¤. ì´ ëªë ¹ ì¤ ìµìì ì¤ì  ë¤ì´ì¼ë¡ê·¸ì ë°ìëì§ ìì¼ë©°, ë¹ì ì´ ì¬ê¸°ìì ëª¨ë  ë³ê²½ì ì ì©í  ë ë¹íì±í ë  ê²ìëë¤. ê²½ê³ : êµ¬ì±ë PS2ì ë¦¬ì»´íì¼ë¬ ì¤ ì¼ë¶ ì´ê¸°íì ì¤í¨íì¬ ë¹íì±íëììµëë¤: ì´ ìµìì ì ííë©´ ì´ í´ëê° ìëì¼ë¡ PCSX2ì íì¬ ì¬ì©ì ë°©ì ì¤ì ê³¼ í¨ê» ê´ë ¨ë ëª¨ëë¥¼ ê¸°ë³¸ì¼ë¡ ë°ìí©ëë¤. ë¹ì ì í¬ë§·ë '%s' ë©ëª¨ë¦¬ ì¹´ëë¥¼ ì­ì íë ¤ê³  í©ëë¤. ì´ ì¹´ëì ëª¨ë  ë°ì´í°ë¥¼ ìê² ë©ëë¤! ì ë§ë¡ ë¶ëªí íì¤íê°ì? ì¬ê¸°ìì PCSX2ì ì¬ì©ì-ìì¤ ë¬¸ìë¥¼ ìí ìíë ê¸°ë³¸ ìì¹ë¥¼ ë³ê²½í  ì ììµëë¤ (ë©ëª¨ë¦¬ ì¹´ë, ì¤ëì·, ì¤ì  ë° ìí ì ì¥ ë±ì í¬í¨í©ëë¤). ì´ ìµìì ì¤ì§ ì¤ì¹ ê¸°ë³¸ ê°ì¼ë¡ ì¬ì©íëë¡ ì¤ì ëì´ íì¤ ê²½ë¡ì ìí¥ì ë¯¸ì¹©ëë¤. íìì ë°ë¼ ì¬ê¸°ì PCSX2ì ì¤ì  ìì¹ë¥¼ ì§ì í  ì ììµëë¤. ìì¹ê° ê¸°ì¡´ PCSX2ì ì¤ì ì´ í¬í¨ë ê²½ì° ì´ë¥¼ ê°ì ¸ì¤ê±°ë ë®ì´ ì°ê¸°ë¥¼ í  ì ìë ìµìì´ ì ê³µë©ëë¤. PCSX2ë¥¼ ì¤ííê¸° ìí ìì¤í ê°ì ììì´ ëë¬´ ë®ìµëë¤. ì´ê²ì ìê±°ë ë¹íì±íë êµì²´ íì¼, ëë ë¦¬ìì¤ë¥¼ ì ì íë ë¤ë¥¸ íë¡ê·¸ë¨ì ìí´ ë°ìí  ì ììµëë¤. ì¤ = 100: ì´ë í ê²ë ìë¥´ì§ ìê³  ì°½ì ì ì²´ ì´ë¯¸ì§ë¥¼ ë§ì¶¥ëë¤.
100 ì´ì/ì´í: ì¶ì/íë
0: ê²ìì ë°ê° ì¬ë¼ì§ ëê¹ì§ ìëì¼ë¡ ì¶ì.(íë©´ ë¹ì¨ì ì ì§ëë©°, ì´ë¯¸ì§ì ì¼ë¶ê° íë©´ ë°ì¼ë¡ ì´ëë©ëë¤)
   ì£¼ì: ì¼ë¶ ê²ìì '0'ì¼ë¡ ì ê±°ëì§ ìì¼ë©° ìì²´ì ì¼ë¡ ê²ìì ë°ë¥¼ ê·¸ë¦½ëë¤.

í¤ë³´ë: CTRL + ì«ìí¨ë ï¼: ì¶ì
           CTRL + ì«ìí¨ë ï¼: íë
           CTRL + ì«ìí¨ë ï¼: 100/0 ì í 