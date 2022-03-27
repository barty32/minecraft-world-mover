@echo off
echo Minecraft world mover

set phoneLocationOld=/storage/emulated/0/games/com.mojang/minecraftWorlds
set phoneLocation=/storage/emulated/0/Android/data/com.mojang.minecraftpe/files/games/com.mojang/minecraftWorlds
set pcLocation=C:\Users\barty\AppData\Local\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang\minecraftWorlds
set adbLocation=D:\barty\Software\android\adb\adb.exe
set levelName=keuwlsoft

:input
set /p action="What you want do to (pull: move from phone->PC / push: move from PC->phone)?:"
if %action% == pull (
	echo Copying world from mobile device...
	%adbLocation% pull "%phoneLocation%/%levelName%/" "%pcLocation%\%levelName%"
	rem %adbLocation% shell rm "/storage/emulated/0/games/com.mojang/minecraftWorlds/Dum_old/"
	rem %adbLocation% shell mv -i "/storage/emulated/0/games/com.mojang/minecraftWorlds/Dum" "/storage/emulated/0/games/com.mojang/minecraftWorlds/Dum_old"
	goto finished
)
if %action% == push (
	echo PC->phone
	goto finished
) else (
	echo Invalid input
	goto input
)

:finished
echo Program execution finished
pause