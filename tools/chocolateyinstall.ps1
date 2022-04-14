$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# download and install zip package
# https://docs.chocolatey.org/en-us/create/functions/install-chocolateyzippackage
$packageArgs = @{
  packageName     = $env:ChocolateyPackageName
  unzipLocation   = $toolsDir
  specificFolder  = 'lite-xl'

  url             = 'https://github.com/lite-xl/lite-xl/releases/download/v2.0.3/lite-xl-windows-x86.zip'
  checksum        = '4587FE52B1B4E8A181F41B694F17867C265D31BC938D0C1C151883C985C48511'
  checksumType    = 'sha256'

  url64bit        = 'https://github.com/lite-xl/lite-xl/releases/download/v2.0.3/lite-xl-windows-x86_64.zip'
  checksum64      = 'BD59BBC9B136D39BB086A1EBDEE80ED885CE851CD69AD9F1F62C0A4937A41FAB'
  checksumType64  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# create start menu shortcut
# https://docs.chocolatey.org/en-us/create/functions/install-chocolateyshortcut
$startMenuDirectory = (Join-Path -Path $env:AppData -ChildPath "Microsoft\Windows\Start Menu\Programs")
$shortcutArgs = @{
  shortcutFilePath = (Join-Path -Path $startMenuDirectory -ChildPath 'LiteXL.lnk')
  targetPath       = (Join-Path -Path $toolsDir -ChildPath 'lite-xl\lite-xl.exe')
  workingDirectory = $env:USERPROFILE
}

Install-ChocolateyShortcut @shortcutArgs
