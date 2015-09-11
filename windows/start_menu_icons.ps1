# start_menu_icons.ps1: Create Start menu and quicklaunch icons

Import-Module PinnedApplications

echo  "cmd.exe"
Set-PinnedApplication -Action PinToStartMenu -FilePath "$env:WINDIR\System32\cmd.exe"
echo  "powershell.exe"
Set-PinnedApplication -Action PinToStartMenu -FilePath "$env:WINDIR\System32\WindowsPowerShell\v1.0\powershell.exe"
echo  "StikyNot.exe"
Set-PinnedApplication -Action PinToStartMenu -FilePath "$env:WINDIR\System32\StikyNot.exe"
echo  "calc.exe"
Set-PinnedApplication -Action PinToStartMenu -FilePath "$env:WINDIR\System32\calc.exe"
echo  "mspaint.exe"
Set-PinnedApplication -Action PinToStartMenu -FilePath "$env:WINDIR\System32\mspaint.exe"
