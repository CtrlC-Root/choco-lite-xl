# remove the start menu shortcut
$startMenuDirectory = (Join-Path -Path $env:AppData -ChildPath "Microsoft\Windows\Start Menu\Programs")
$startMenuLink = (Join-Path -Path $startMenuDirectory -ChildPath 'LiteXL.lnk')

Remove-Item -LiteralPath $startMenuLink
