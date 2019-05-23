# powershell -ExecutionPolicy Bypass ./intellij_idea.ps1

$ideadir = "$ENV:HOMEDRIVE\$ENV:HOMEPATH\.IntelliJIdea*\config"

Remove-Item "$ideadir\eval" -Recurse

$optionsfile = Get-ChildItem "$ideadir\options\other.xml"
Get-Content "$optionsfile" | Where-Object {$_ -notmatch 'evlsprt'} | Set-Content "$optionsfile.tmp"
Move-Item "$optionsfile.tmp" "$optionsfile" -Force

Get-ChildItem -Path "HKCU:\Software\JavaSoft\Prefs\jetbrains\idea" -Include * -ErrorAction SilentlyContinue | Remove-Item -Force
