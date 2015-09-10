ePSXe_shark

1st goal- extend the functionality of ePSXe (fixes, improvements)
2nd goal- improve sound compatibility
3rd goal- some kind of ePSXe 1.7.0 update
4th goal- promote Pete's DSound 1.10



Installation:
1- Copy __everything__ in the bin folder to ePSXe folder

2- Run ePSXe_shark_padconfig to select PAD plugins

3- Run ePSXe_shark
> optional: ePSXe_shark -i for very slow, maximum compatibility mode)
> Must run ePSXe_shark every time)



Optional:
1- Edit inis\epsxe_shark.ini

2- Sample shark codelists are now stored in 'inis\shark_codelist_archive'
> Copy the list you want and name to inis\shark_codelist.inf






Features:

(Emulation)
- External PAD support (Lilypad, pokopom, padBlade, SSSPSX, nuvee, ..)

- CDDA plugin support
- APU cycles (faster spu calls)

- XA save / load states now work (must save first)
ex. Mega Man Legends (*cutscenes*)

- XA attenuation (Tekken 3 music fade-out, Gamera 2000)
- CDDA attenuation (Tekken 1 music fade-out, Chronicles of the Sword speech)

- CDDA does not chop the first 1-sec when starting (Chronicles of the Sword, almost all cdda games)
- CDDA does not chop the last 2-sec when finishing (Rayman)

- getlocp local subq times are now written correctly (Chronicles of the Sword speech)
- lid open stops cdda flag (Vib Ribbon swap)

- Memory card resets
- Longer pause times (InuYasha battles hopefully)

- No L3/R3 button mapping conflicts when
  dualshock / dualanalog controller is off

- Mouse port2 (Quake 2)
- Auto-start special devices (ex. mouse, dualshock analog, guncon)

- SIO cmd $45 fixed (Quake 2 mouse)
- Readd Konami Justifier support

- Analog center at $7f



(Win32)
- Fast game booting
- Autorun options
- Controllable F4 rates
- shalma DVD5 disc kits (run iso)
- shark_cheater (pec-style gameshark)

- switch iso/cdrom working (most games, +Vib Ribbon)
> Monster Rancher 2 only works with cdrom for now (SaPu)

- Auto-memcard ejection
- Permanently disable memcards

- Save states work with problem games (Gameshark v4, Policenauts)

- Analog deadzones
