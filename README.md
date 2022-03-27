# Minecraft World Relocator
A simple PowerShell script used to move worlds between Android and Windows versions of Minecraft: Bedrock Edition.

Before you can use it, you need to adjust a few variables in the script:

  - `$phoneLocation`: Path to your worlds on Android, for Minecraft versions prior to 1.18 it was something like `/storage/emulated/0/games/com.mojang/minecraftWorlds`, since 1.18 this path has changed to `/storage/emulated/0/Android/data/com.mojang.minecraftpe/files/games/com.mojang/minecraftWorlds`. See [this](https://help.minecraft.net/hc/en-us/articles/4411299967629) for more information.
  - `$pcLocation`: Path to your worlds on Windows.
  - `$levelName`: Name of the world you want to move. This is the name of the world directory, NOT the name of the world itself that you see in the game (this name is stored in `levelname.txt`).
  - `$adbLocation`: Path to your ADB installation. You can download ADB [here](https://developer.android.com/studio/releases/platform-tools).
You need to enable USB debugging on your Android device

**Note:** this only works for Bedrock Edition, because Bedrock and Java Edition worlds are not compatible with each other.

**Disclaimer:** you use this script on your own responsibility. I am not responsible for any damage caused by this script (like deleted your favorite world).
