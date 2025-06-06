# Platform Rules

**NOTE: The following rules may be overwritten by specific category rules**

**If you have any questions, the answer may be in our
[FAQ](https://www.speedrun.com/mcbe/thread/vdv9t)**

[Back](../README.md)

## General

* Emulators are banned, unless stated otherwise below.

## PC

* All input methods are legal with the exception of touchscreen.

### Windows

* You must play on the Windows 10/11 Edition of the game.

* Running multiple instances of Minecraft Bedrock is only allowed by
  modifying the windows registry
    * This can be done with the following PowerShell script

```pwsh
$packageFullName = (Get-AppxPackage -Name Microsoft.MinecraftUWP).PackageFullName
if ([String]::IsNullOrEmpty($packageFullName)) {
    Write-Host "Could not get 'Microsoft.MinecraftUWP' package." -ForegroundColor Red
    return
}
$registryPath = "HKCU:SOFTWARE\Classes\Extensions\ContractId\Windows.Launch\PackageId\$packageFullName\ActivatableClassId\App\CustomProperties"
if (!(Test-Path -Path $registryPath)) {
    New-Item -Path $registryPath -ItemType RegistryKey -Force | Out-Null
}
Set-ItemProperty -Path $registryPath -Name "SupportsMultipleInstances" -Value 1 -Type DWORD
```

* Joining the same world on multiple instances is not allowed.
* Rare save file glitches will result in the run being rejected (such
  as copying the seed over, copying some chunks over, and other
  glitches)

### Linux / MacOS

* Linux and MacOS users may play the Pocket Edition of the game and
submit to the PC leaderboards if played via the
[Minecraft Bedrock Launcher](https://mcpelauncher.readthedocs.io/en/latest/getting_started/index.html)

## Mobile

* You must play on one of the following platforms:
	- Android
	- iOS
	- Windows Phone
* All input methods are legal.

## Console

* You must play on one of the following platforms:
	- PS4
	- PS5
	- Xbox One
	- Xbox Series X
	- Xbox Series S
	- Nintendo Switch
	- Nintendo Switch 2
	- fireTV
* All input methods are legal with the exception of touchscreen.

## Virtual Reality

* Virtual Reality runs fall under the category of the physical device the game
is being run on. This means that if the game is being run on a PC and streamed
to a headset, you must submit to PC, and if the game is being run on a Console,
you must submit to Console, etc.
