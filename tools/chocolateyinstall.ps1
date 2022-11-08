$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# download and install zip package
# https://docs.chocolatey.org/en-us/create/functions/install-chocolateyzippackage
$packageArgs = @{
  packageName     = $env:ChocolateyPackageName
  unzipLocation   = $toolsDir
  specificFolder  = 'lite-xl'

##  url             = 'https://github.com/lite-xl/lite-xl/releases/download/v2.1.0/lite-xl-v2.1.0-windows-i686.zip'
##  checksum        = '6cff99fe707e3be4832de1584b2a44183b6039502f1ec815b87bc78a347fc5bf'
  url             = 'https://github.com/lite-xl/lite-xl/releases/download/v2.1.0/lite-xl-v2.1.0-addons-windows-i686.zip'
  checksum        = '52a3ec5f7bca5b2eb3ba8607a47600a8bacd297be8bd611ab8268976884c1323'
  checksumType    = 'sha256'

##  url64bit        = 'https://github.com/lite-xl/lite-xl/releases/download/v2.1.0/lite-xl-v2.1.0-windows-x86_64.zip'
##  checksum64      = 'c9ecc452bdd24c2596532bb1034b1a340d30da7243c5ecb921e731470a02b803'
  url64bit        = 'https://github.com/lite-xl/lite-xl/releases/download/v2.1.0/lite-xl-v2.1.0-addons-windows-x86_64.zip'
  checksum64      = '294a482858a68e8ca4cc332f488f693509b176ab2829e63aaf3b82cc74d4fc90'
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
