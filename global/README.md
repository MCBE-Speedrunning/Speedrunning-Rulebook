# Global Rules

**NOTE: The following rules may be overwritten by specific category rules**

**If you have any questions, the answer may be in our
[FAQ](https://www.speedrun.com/mcbe/thread/vdv9t)**
[Back](../README.md)

## General Rules

* The use of external tools that modify the game in any way, shape, or form is
forbidden.
* The, as of now, Mobile-exclusive 1.2.6.* duping glitch is banned from all
categories unless explicitly stated otherwise.
* In-game commands must not be executed during the run.
	- This includes glitch runs, where runners often attempt to use the
	command glitch. The command glitch is forbidden as it violates this
	rule.
* The editing of any world settings after world creation is strictly forbidden.
	- This includes changing game modes.
* Reloading the world (quitting and loading the same world again) always puts
the run into the glitched category.
	- If proven that reloading the world does not affect the run, the
	run may be kept in the glitchless category.
	- Exceptions to this rule include, but are not limited to:
        + Being stuck on the nether roof.
        + Entities being at ~Y32000
        + Any general bug that isn't feasibly fixable without
          reloading the world.
* While we do promote ingenuity and creativity from runners, do not attempt to
be cheeky in regards to the rules. Exploiting loopholes in the rules that were
clearly not intended to be exploited may result in your run being rejected.
	- If you do find a loophole, we ask that you point it out to a moderator
	instead.

## Submission Rules

* Runners are permitted to run on any version of the game that they would like.
	- Certain Individual Level categories may require that you run on a
	specific version or range of versions.
	- Full game runs performed on beta versions of the game must be submitted
	to the beta category on our category extensions.
	- Beta versions of the game are not permitted unless stated otherwise.
* If you submit a video significantly longer than the duration of the run,
specify timestamps of the run's beginning and end in the submission
description.
	- This is not a required rule; however, it is strongly recommended as it
	saves the moderators a lot of time when verifying.
	- If the queue is long enough, your run may be rejected with a message
	requesting you resubmit with timestamps.
* Top runners must be prepared to send extra evidence for their runs, which may
include:
    - A full raw recording of the session
	- Recordings of past attempts
	- The world folder of the run (limited to PC runs)
	- The world seed (for random seed runs) - it is encouraged to send the
world seed for every submission, but it is not mandatory
* Other runners should also be ready to send this extra evidence if required
(though it will not be required in most cases).


## Game Modification Rules

* Any sort of texture pack is banned.
* All runs must be performed on a vanilla client.
	- There is an exception to this rule for runners playing on Linux.
* Runners are allowed to edit game options in the options.txt file of the game.
	- This allows the change of any visual settings (e.g., vsync to decrease lag).
	- Any changes that may be used to provide an advantage to the runner
	(e.g., gamma) are not allowed.
* Any other form of game modification / behavior pack is forbidden.
* Any form of external game assistance (macros, scripts etc.) is forbidden. 
	- Macros for resetting worlds are allowed. 
	- A key mapper is allowed on mobile when binding the following keys
	and actions:
		* Q must be bound to Drop
		* F5 must be bound to change perspective
		* Shift must be bound to crouch

## Proof Rules

* All runs require proof to be entered on the leaderboards.
	- By submitting to the leaderboards, you are giving the moderation team
	permission to download your run for retiming and archival purposes.
* Proof must be given in the form of a viewable video.
	- In the case of cooperative runs, only the host is required to provide
	proof.
	- Any video hosting service is allowed, and the video does not need to
	be public. It is, however, strongly recommended that you submit public
	videos on YouTube.
		+ If a video is not public, it must either be unlisted or shared with
		a moderator in another form.
	- There are no minimum quality settings; however, at a minimum, we
	recommend 480p video at 30fps.
	- A run may be rejected if there are too many dropped frames, as it
	makes accurate retiming impossible.
	- Audio is not required.
* It is not required to have a timer.
* Editing the video in any way, shape, or form that affects the resulting time
of the run is strictly against the rules.
	- Examples of banned edits are splices and changing the video speed.
	- Examples of legal edits are putting music over your run and adding a
	custom video intro.
		+ You may use whatever music you would like.
* All videos must show the world creation process and the runner entering the
newly created world.
* You may freeze/suspend the game, however this must be done before any input
* After completing a run in the **top 5** of a **full game** or
  **world record** runs of an **individual level** category at the time
  of verification, you MUST exit the world and go to the main menu.
* On Windows for runs in the **top 5** of a **full game** or **world
  record** runs of an **individual level** category at the time of
  verification, the following script MUST be run at the START or END of
  a run in the same video in a new PowerShell window:

```pwsh
param (
	[Parameter(Mandatory=$false)] [string] $installationDir,
	[Parameter(Mandatory=$false)] [string] $outputFile,
	[Parameter(Mandatory=$false)] [bool] $Check = $false
)
$outputFile = if ([string]::IsNullOrEmpty($outputFile)) {
	[string] $currentTime = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
	[string] $desktopFolder = [Environment]::GetFolderPath([Environment+SpecialFolder]::Desktop);
	[string] $outFolderName = "mcbe-speedrunning";
	[string] $outFolder = Join-Path `
		-Path $desktopFolder `
		-ChildPath $outFolderName
	if (-not (Test-Path $outFolder)) {
		New-Item -Path $desktopFolder -Name $outFolderName -ItemType "directory" | Out-Null
	}
	Join-Path -Path $outFolder -ChildPath "Hashes_$currentTime.txt"
} else {
	$outputFile
}

if ([string]::IsNullOrEmpty($outputFile)) {
	throw [System.IO.FileNotFoundException] "Couldn't find the output file. Please report this issue"
}

if ($Check) {
	[string[]] $hashStrings = Get-Content -Path "$outputFile"
	[string] $mainHash = $hashStrings -join ''
	$(Get-FileHash -InputStream ([IO.MemoryStream]::new([char[]]$mainHash))).Hash
} else {
	[Microsoft.Windows.Appx.PackageManager.Commands.AppxPackage] $mcbeAppx = Get-AppxPackage -Name Microsoft.MinecraftUWP
	$installationDir = if ([string]::IsNullOrEmpty($installationDir)) {
		$mcbeAppx.InstallLocation
	} else {
		$installationDir
	}

	if ([string]::IsNullOrEmpty($installationDir)) {
		throw [System.IO.FileNotFoundException] "Couldn't find the minecraft installation. Please report this issue"
	}

	[string] $mcbeStateFolder = Join-Path -Path $env:LOCALAPPDATA -ChildPath "Packages\$($mcbeAppx.Name)_$($mcbeAppx.PublisherId)\LocalState\games\com.mojang"
	[string] $globalResourcePacksFile = $(Join-Path -Path $mcbeStateFolder -ChildPath "minecraftpe\global_resource_packs.json")
	if ([System.IO.File]::Exists($globalResourcePacksFile)) {
		[PSCustomObject] $globalResourcePacks = Get-Content -Path $globalResourcePacksFile | ConvertFrom-Json
		echo "Activated global resource packs are 0? $($globalResourcePacks.Count -eq 0)"
	} else {
		echo "No global resources file found"
	}
	[System.IO.DirectoryInfo] $lastWorld = Get-ChildItem $(Join-Path -Path $mcbeStateFolder -ChildPath "minecraftWorlds") -Directory | Sort-Object LastWriteTime -Descending | Select-Object -First 1
	if ($lastWorld) {
		[string] $worldResourcePacksFile = $(Join-Path -Path $lastWorld.FullName -ChildPath "world_resource_packs.json")
		if ([System.IO.File]::Exists($worldResourcePacksFile)) {
			[PSCustomObject] $worldResourcePacks = Get-Content -Path $worldResourcePacksFile | ConvertFrom-Json
			echo "Activated latest world resource packs are 0? $($worldResourcePacks.Count -eq 0)"
		} else {
			echo "No world resource pack file found"
		}
		[string] $worldBehaviorPacksFile = $(Join-Path -Path $lastWorld.FullName -ChildPath "world_behavior_packs.json")
		if ([System.IO.File]::Exists($worldBehaviorPacksFile)) {
			[PSCustomObject] $worldBehaviorPacks = Get-Content -Path $worldBehaviorPacksFile | ConvertFrom-Json
			echo "Activated latest world behaviour packs are 0? $($worldBehaviorPacks.Count -eq 0)"
		} else {
			echo "No world behaviour pack file found"
		}
	} else {
		echo "No last world found"
	}

	[int] $totalFiles = (Get-ChildItem -Path $installationDir -Recurse -File).Count
	[int] $progress = 0
	[int] $updateInterval = [Math]::Ceiling($totalFiles / 100)

	[string[]] $hashStrings = Get-ChildItem -Path $installationDir -Recurse -File | ForEach-Object {
		$hash = Get-FileHash -Path "$($_.FullName)"
		"$($_.Name)=$($hash.Hash)"

		if (++$progress % $updateInterval -eq 0) {
			$percentComplete = [Math]::Floor(($progress / $totalFiles) * 100)
			Write-Progress -Activity "Calculating Hashes" -Status "Progress: $percentComplete%" -PercentComplete $percentComplete
		}
	}
	$hashStrings | Out-File -FilePath $outputFile
	[string] $mainHash = $hashStrings -join ''
	$(Get-FileHash -InputStream ([IO.MemoryStream]::new([char[]]$mainHash))).Hash
}
```

This script MUST be run at the START or END of random seed runs in the
same video, and it is highly recommended to run it on set seed runs as well.

To open a PowerShell window, press the windows button and "R", then type
"powershell" and press enter. After pasting the script above, remember to
show the whole output to the end and close the window at the end before
running the script again.

Some runners may prefer to hide their username from the PowerShell
window. This can be done by editing the profile file by running
`notepad $PROFILE` and adding the following line:

```pwsh
function prompt {"PS: >"}
```

## Timing Rules

### Timing starts when: 
* Any input, except changing perspective, opening chat, emote, or the pause menu.
* Any sort of player movement, or if the player takes damage that has any form of knockback.
* For cooperative runs, timing starts when any of the players performs one of the actions mentioned above.
### Notes/Exceptions:
* If the player spawns inside a block and gets pushed by it, the timer does not start.
* Inputs that have no effect, such as right clicking nothing, do not start the timer.
* On runs played using touchscreen, time starts when the action takes place, and not when a button is touched.
* You may wait for a reasonable amount of time at the start of your run for the world to load.
    * If a reasonable amount of time is exceeded, the time starts on
      world load.
    * A reasonable amount of time is up to the examiner's discretion.
* Full game runs time with full second precision. In the case of a tie, runs will be timed with millisecond precision.
* Individual level runs are timed with millisecond precision.

## World Creation Rules

**NOTE: All videos must display the world creation settings**

* Gamemode: Survival
* Difficulty: Easy, Normal, or Hard
	- Peaceful is allowed for peaceful-specific categories.
* Starting Map: OFF
* Bonus Chest: OFF
* Default Player Permissions: Member
* World Type: Infinite
* Friendly Fire: ON
* Fire Spreads: ON
* TNT Explodes: ON
* Mob Loot: ON
* Tile Drops: ON
* Beds Work: ON
* Required Sleeping Players: Default
* Immediate Respawn: OFF
* Respawn Blocks Explode: ON
* Respawn Radius: Default
* Use Experimental Gameplay: OFF
* Activate Cheats: OFF
