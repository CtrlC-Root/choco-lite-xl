$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# download and install zip package
# https://docs.chocolatey.org/en-us/create/functions/install-chocolateyzippackage
$packageArgs = @{
  packageName     = $env:ChocolateyPackageName
  unzipLocation   = $toolsDir
  specificFolder  = 'lite-xl'

  url             = 'https://github.com/lite-xl/lite-xl/releases/download/v1.16.12/lite-xl-win-x86.zip'
  checksum        = '20066333E2C738FA8A1FF879424AD729D4BC80046CCC75281158B5C52E8FF0EE'
  checksumType    = 'sha256'

  url64bit        = 'https://github.com/lite-xl/lite-xl/releases/download/v1.16.12/lite-xl-win-x86-64.zip'
  checksum64      = '999163551227129EE913B25DA5B7136EB4761EFD6B02689C5440E7675ED4C813'
  checksumType64  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# create start menu shortcut
# https://docs.chocolatey.org/en-us/create/functions/install-chocolateyshortcut
$startMenuDirectory = (Join-Path -Path $env:AppData -ChildPath "Microsoft\Windows\Start Menu\Programs")
$shortcutArgs = @{
  shortcutFilePath = (Join-Path -Path $startMenuDirectory -ChildPath 'LiteXL.lnk')
  targetPath       = (Join-Path -Path $toolsDir -ChildPath 'lite-xl\lite.exe')
  workingDirectory = $env:USERPROFILE
}

Install-ChocolateyShortcut @shortcutArgs
