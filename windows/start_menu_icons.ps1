# start_menu_icons.ps1: Create Start menu and quicklaunch icons

Import-Module PinnedApplications

echo  "powershell.exe"
Set-PinnedApplication -Action PinToTaskBar -FilePath "$env:WINDIR\System32\WindowsPowerShell\v1.0\powershell.exe"
echo  "calc.exe"
Set-PinnedApplication -Action PinToTaskBar -FilePath "$env:WINDIR\System32\calc.exe"
echo  "StikyNot.exe"
Set-PinnedApplication -Action PinToTaskBar -FilePath "$env:WINDIR\System32\StikyNot.exe"

echo  "cmd.exe"
Set-PinnedApplication -Action PinToStartMenu -FilePath "$env:WINDIR\System32\cmd.exe"
echo  "mspaint.exe"
Set-PinnedApplication -Action PinToStartMenu -FilePath "$env:WINDIR\System32\mspaint.exe"
