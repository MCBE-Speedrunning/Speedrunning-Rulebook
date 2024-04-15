# Seed Rules

**NOTE: The following rules may be overwritten by specific category rules**

**If you have any questions, the answer may be in our
[FAQ](https://www.speedrun.com/mcbe/thread/vdv9t)**

[Back](../README.md)

## Set Seed

* You must input the world seed manually.
	- It does not matter if you choose the seed, or randomly smash your
	keyboard. Submissions to set seed that do not predefine a seed will be
	rejected.

## Random Seed

* You must leave the world seed box blank.
* Viewing the world seed before the end of the run is forbidden.
* The use of resource packs is forbidden.

### Additional evidence required


#### Windows 10 and 11

On Windows 10 and 11 for runs in the **top 5** of a **full game** or
**world record** runs of an **individual level** category at the time of
verification the following script must be ran in a new powershell
window:

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
	Get-FileHash -InputStream ([IO.MemoryStream]::new([char[]]$mainHash)) | Select-Object Hash
} else {
	$installationDir = if ([string]::IsNullOrEmpty($installationDir)) {
		$(Get-AppxPackage -Name Microsoft.MinecraftUWP).InstallLocation
	} else {
		$installationDir
	}

	if ([string]::IsNullOrEmpty($installationDir)) {
		throw [System.IO.FileNotFoundException] "Couldn't find the minecraft installation. Please report this issue"
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
	Get-FileHash -InputStream ([IO.MemoryStream]::new([char[]]$mainHash)) | Select-Object Hash
}
```

Some runners may prefer to hide their username from the powershell
window. This can be done by editing the profile file by running
`notepad $PROFILE` and adding the following line:

```pwsh
function prompt {"PS: >"}
```

### Every other platform
- For runs in the **top 5** of a **full game** category at the time
  of verification the resource packs tab must be shown before or
  after the run
- For **world record** runs of an **individual level** category at
  the time of verification the resource packs tab must be shown
  before or after the run

