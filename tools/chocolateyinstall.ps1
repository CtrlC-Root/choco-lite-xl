$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# download and install zip package
# https://docs.chocolatey.org/en-us/create/functions/install-chocolateyzippackage
$packageArgs = @{
  packageName     = $env:ChocolateyPackageName
  unzipLocation   = $toolsDir
  specificFolder  = 'lite-xl'

  url             = 'https://github.com/lite-xl/lite-xl/releases/download/v2.1.1/lite-xl-v2.1.1-addons-windows-i686.zip'
  checksum        = '789f61e8b4fbadaa3a51dc5bbe8f06a7b117d47228a2a7326fea2f51aec2517b'
  checksumType    = 'sha256'

  url64bit        = 'https://github.com/lite-xl/lite-xl/releases/download/v2.1.1/lite-xl-v2.1.1-addons-windows-x86_64.zip'
  checksum64      = 'e1931d6a5c2abedee4b8775aaec5dcaa2f97ab8ccb8f61608995b17486bddc43'
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
