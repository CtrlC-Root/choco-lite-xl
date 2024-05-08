$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# download and install zip package
# https://docs.chocolatey.org/en-us/create/functions/install-chocolateyzippackage
$packageArgs = @{
  packageName     = $env:ChocolateyPackageName
  unzipLocation   = $toolsDir
  specificFolder  = 'lite-xl'

  url             = 'https://github.com/lite-xl/lite-xl/releases/download/v2.1.4/lite-xl-v2.1.4-addons-windows-i686.zip'
  checksum        = '900B86D73A82E72C78F166178F7B6F661BE2009DAAFF705F88BFD38C6EEFAF9C'
  checksumType    = 'sha256'

  url64bit        = 'https://github.com/lite-xl/lite-xl/releases/download/v2.1.4/lite-xl-v2.1.4-addons-windows-x86_64.zip'
  checksum64      = '5A2FA235F5E5784F8D0BD4C5D06855E79D1C4AA618488AF4CD661CE1C0443897'
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
