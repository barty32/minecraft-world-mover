# Minecraft world relocator
# v1.0
#
# ©2022 barty12

Write-Host "Minecraft world mover"

#$phoneLocationOld="/storage/emulated/0/games/com.mojang/minecraftWorlds"

# Set this to your world location on Android
$phoneLocation="/storage/emulated/0/Android/data/com.mojang.minecraftpe/files/games/com.mojang/minecraftWorlds"

# Set this to your world location on Windows
$pcLocation="%LocalAppData%\Local\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang\minecraftWorlds"

# Path to ADB executable
$adbLocation="D:\barty\Software\android\adb\adb.exe"

# Name of world you want to move (this is the name of the world directory, NOT the name of the world itself)
$levelName="Dum"

while($true){
    $action=Read-Host "Enter command (pull: move from phone to PC / push: move from PC to phone)"
    if($action -eq "pull"){
        if ( -NOT(& $adbLocation shell "if [ -e $phoneLocation/$levelName ]; then echo 1; fi" )) { 
            Write-Host "World does not exist on phone!" -ForegroundColor Red
            break
        }
        if(Test-Path -Path "$pcLocation\$levelName"){
            Write-Host "Folder already exists on PC, renaming it..." -ForegroundColor Blue
            $date = Get-Date -format "yyMMdd_HHmm"
            Rename-Item -path "$pcLocation\$levelName" -NewName "$($levelName)_$($date)_old"
        }
        Write-Host "Copying world from mobile device..." -ForegroundColor Blue
        & $adbLocation pull "$phoneLocation/$levelName" "$pcLocation\$levelName"
        $date = Get-Date -format "yyMMdd_HHmm"
        & $adbLocation shell mkdir "$phoneLocation/$($levelName)_$($date)"
        & $adbLocation shell mv -i "$phoneLocation/$levelName" "$phoneLocation/$($levelName)_$($date)"
	    break
    }
    elseif ($action -eq "push") {
        if (-NOT(Test-Path -Path "$pcLocation\$levelName")) {
            Write-Host "World does not exist on PC!" -ForegroundColor Red
            break
        }
        if ( & $adbLocation shell "if [ -e $phoneLocation/$levelName ]; then echo 1; fi" ) { 
            Write-Host "Folder already exists on mobile, renaming it..." -ForegroundColor Blue
            $date = Get-Date -format "yyMMdd_HHmm"
            & $adbLocation shell mv -i "$phoneLocation/$levelName" "$phoneLocation/$($levelName)_$($date)_old"
        }
        Write-Host "Copying world to mobile device..." -ForegroundColor Blue
        & $adbLocation push "$pcLocation\$levelName" "$phoneLocation/$levelName" 
        $date = Get-Date -format "yyMMdd_HHmm"
        Rename-Item -path "$pcLocation\$levelName" -NewName "$($levelName)_$($date)"
	    break
    }
	Write-Host "Invalid input" -ForegroundColor Red
}

Write-Host "Program execution finished" -ForegroundColor Green
pause