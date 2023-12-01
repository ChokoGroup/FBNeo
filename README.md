#

## FinalBurn Neo
Official Forum: https://neo-source.com

Official Discord: https://discord.gg/8EGVd9v

Use of this program and its source code is subject to the license conditions provided in the [license.txt](/src/license.txt) file in the src folder.



#

## Port for Capcom Home Arcade

This is a fork from https://github.com/finalburnneo/FBNeo - the official repository of FinalBurn Neo, an Emulator for Arcade Games & Select Consoles. It is based on the emulators FinalBurn and old versions of [MAME](https://www.mamedev.org)

It's an unofficial port of the SDL2 build to the Capcom Home Arcade (specs and more in https://github.com/lilo-san/cha-documentation).

If you want to build from source, clone this git to a device able to compile for arm7hf and type `make sdl2` (requires SDL2, SDL2_image, gcc, make, perl and nasm).
You can also cross compile with the command: `make sdl2 CROSS_COMP=1 RELEASEBUILD=1`

#

https://user-images.githubusercontent.com/55603581/284382783-2afbadec-8c0b-4680-96bf-7833dc8f0862.mov

#

The games selection menu supports titles screenshots.

![Screenshot of FBNeo showing titles screenshots.](https://github.com/ChokoGroup/FBNeo/blob/fbneo-CHA/FinalBurn%20Neo%20for%20CHA%20-%20support%20titles%20screenshot.png?raw=true)
#

## How to use with Choko Hack

1. Download the [latest build](https://github.com/ChokoGroup/FBNeo/releases/tag/latest) and extract the "FinalBurn Neo for CHA" folder to the root of an USB pendrive.

2. You can put your ROMs either in "/roms" or in "/fbneo/roms" in the root of the pendrive.

3. Put the pendrive in the USB EXT port of the CHA, power it on and select the option "Run FinalBurn Neo" from the Choko Menu.


In Choko Menu you should also have an option for downloading and updating FinalBurn Neo **and cheats**.
A new version is compiled in our GitHub fork every Friday.

Another option should be in Choko Menu to install (or uninstall) FinalBurn Neo into the internal memory of the CHA.
If installed, the folder "FinalBurn Neo for CHA" can be deleted from the pendrive.

The installer can also copy the ROMs zip files to /opt/fbneo/roms (CHA internal disk), to play without using a pendrive.
For that it's recommended to have the expanded partition for more available space.


#

## In Game special controls

P1 Start + Coin = call UniBIOS menu when playing NeoGeo games

P1 Start + Coin (Hold) = Quit game

P1 Start + Joystick Down = diagnostic menu (available in some games)

P1 Start + Joystick Up = pause game and show ingame menu

#

https://user-images.githubusercontent.com/55603581/169626870-86cb38f7-96b4-4946-a36e-f2e70b0e55d4.mov

#

#

## Support for up to 4 joysticks/gamepads

Games with 3 or 4 players are supported, just need to connect extra controllers to the USB EXT port of the CHA.

Note: If you add controllers before calling fbneo, the 3rd controller will become the one that controls game selection and ingame special controls.


### Game controllers not detected or not mapped correctly

The ingame menu has a basic buttons mapping option that creates a file named gamecontrollerdb.txt file and will be loaded when fbneo starts.

Alternatively, you can copy the file "gamecontrollerdb.example.txt" into the folder /fbneo/config (in the root of a pendrive) and rename it to "gamecontrollerdb.txt".
Open the file in a text editor and add a line (or replace the content) to include your controller data. For this you will need to use the controller GUID.

You can search [in this gamecontrollerdb.txt](https://github.com/gabomdq/SDL_GameControllerDB/blob/master/gamecontrollerdb.txt) if it has the data you need - don't forget to change the ending part to `platform:Linux,`


https://github.com/gabomdq/SDL_GameControllerDB has more info on this and some tools that may be useful to create your controller mappings.

Note: If you install fbneo into the CHA the file gamecontrollerdb.txt will also be copied.

#

https://user-images.githubusercontent.com/55603581/173922688-2472470b-5547-46cb-afca-53a636e54c06.mov

#

### What works and what not

Tested and working:
- Capcom Home Arcade (obviously) also in USB Joystick Mode
- PS4 official controller
- Nintendo Switch PowerA Wired Controller (needs button mapping)
- THEGamepad from Retro Games LTD - A500 mini gamepad (needs button mapping)

Tested and not working:
- PS3 official controller (detected, mapped but no reaction ???)
- PS5 official controller (not detected)
- PDP Gaming Wired Controller Xbox Series X|S/Xbox One/PC (not detected)
- NPLAY Skill 4.1 Wired PS4/PS3/PC controller (not detected)



#

## Support for cheats

You can either use a MAME cheat.dat or download a pack of FBNeo native cheats in <romname>.ini format from https://github.com/finalburnneo/FBNeo-cheats/ and uncompress them into /fbneo/support/cheats folder (of the USB pendisk).
They'll become available in the ingame menu (P1 Start + Joystick Up).

Note: If you install fbneo into the CHA it will also copy the cheats folder.

#

https://user-images.githubusercontent.com/55603581/284382783-2afbadec-8c0b-4680-96bf-7833dc8f0862.mov

#

#

## Support for DIP switches

DIP switches are accessible in the ingame menu (P1 Start + Joystick Up).

When available, we can usually change dificulty and other interesting aspects of the game.

Note: If you changed DIP switches and exit game without resetting DIP switches to defaults, your settings are saved in the `<romname>.ini` file and they will become the default values. Only way to restore the real defaults is deleting the `<romname>.ini` file.

#

https://user-images.githubusercontent.com/55603581/284382936-d3784272-3717-4178-829a-b1ffc6aee792.mov

#

#

## Reporting Issues

Please don't report issues about this CHA build in the official libretro git, also don't report bugs on the forums at [Neosource](https://neo-source.com)

Use [this to report issues](https://github.com/ChokoGroup/FBNeo/issues) instead.



#

## Contributing

We welcome pull requests and other submissions. 
