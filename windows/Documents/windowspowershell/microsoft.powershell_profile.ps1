# Powershell Improved
#
# First You need to install Powershell 3:
# (to check the current version, run `$PSVersionTable.PSVersion`)
#
#   Powershell 3
#   http://www.microsoft.com/en-us/download/details.aspx?id=34595
#     x86 Windows6.1-KB2506143-x86.msu
#     x64 Windows6.1-KB2506143-x64.msu
#
#   Powershell 5
#   https://www.microsoft.com/en-us/download/details.aspx?id=50395
#     x86 Win7-KB3134760-x86.msu
#     x64 Win7AndW2K8R2-KB3134760-x64.msu
#
# It needs Service Pack 1 and (at least) .Net 4.0:
#
#   Service Pack 1
#   http://windows.microsoft.com/en-us/windows7/install-windows-7-service-pack-1
#
#   .Net 4.0
#   http://www.microsoft.com/en-us/download/details.aspx?id=17851
#
# To get the plugins work set ExecutionPolicy to Bypass via the command line:
#
#   powershell -ExecutionPolicy Bypass
#
# ... or set it permanent by running Powershell as Administrator, then:
#
#   Set-ExecutionPolicy -ExecutionPolicy Bypass
#
# To update a module:
#
#   Run cmd.exe
#   powershell -noprofile -c Update-Module <MODULE>
#
#  =================== BimbaLaszlo (.github.io|gmail.com) ====================

#                                  ALIAS                                  {{{1
# ============================================================================

Set-Alias g git

# For some reason ^C closes the /bin/bash shell, but the /usr/bin/bash shell
# works as it has to. Since the Git aliases which starts with bang (e.g.
# '!shell --command') executed in /bin/bash shell, I have to do the alias
# outside of .gitconfig.
function gitBash { c:\app\git\usr\bin\bash --login -i }
Set-Alias gsh gitBash

#                                 PLUGINS                                 {{{1
# ============================================================================

#                    "PACKAGE-MANAGER" FOR POWERSHELL                     {{{2
# ____________________________________________________________________________

Function Get-MyModule
{
  Param( [string] $name )
    if( -not (Get-Module -name $name) )
    {
      if( Get-Module -ListAvailable | Where-Object { $_.name -eq $name } )
      {
        Import-Module -name $name
        $true
      }
      else
      {
        $false
      }
    }
    else
    {
      $true
    }
}

if( -not (Get-Mymodule -name "PsGet") )
{
  (new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
}

#                               PSREADLINE                                {{{2
# ____________________________________________________________________________
#
# Bash-like behaviour.

if( -not (Get-Mymodule -name "PSReadLine") )
{
  Install-Module PSReadLine
}

# Bash-like editing.
Set-PSReadlineOption -EditMode Emacs
Set-PSReadlineKeyHandler -Key Ctrl+J         -Function AcceptLine
Set-PSReadlineKeyHandler -Key 'Shift+PageUp','Shift+PageDown' `
                         -BriefDescription ScrollDisplayUpDownHalfPage `
                         -LongDescription "Scroll the display up or down by half page" `
                         -ScriptBlock {
  param($key, $arg)

  [int]$intArg = if ($arg -eq $null) { 1 } else { $arg -as [int] }
  if ($key.Key -eq [System.ConsoleKey]::PageUp) { $intArg *= -1 }
  $intArg *= [Math]::Floor([Console]::WindowHeight / 2)

  $newTop = [Console]::WindowTop + $intArg
  $newTop = [Math]::Max(0, $newTop)
  $newTop = [Math]::Min([Console]::BufferHeight - [Console]::WindowHeight, $newTop)
  [Console]::SetWindowPosition(0, $newTop)
}

# Zsh-like history search.
Set-PSReadlineKeyHandler -Key UpArrow   -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key Ctrl+P    -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key Ctrl+N    -Function HistorySearchForward

#                                POSH-GIT                                 {{{2
# ____________________________________________________________________________
#
# Git commandline-completion and prompt string.

if( -not (Get-Mymodule -name "Posh-Git") )
{
  Install-Module Posh-Git
}

$global:GitPromptSettings.EnableFileStatus  = $false
$global:GitPromptSettings.EnableStashStatus = $false

$global:GitPromptSettings.BeforeText            = '['
$global:GitPromptSettings.BeforeForegroundColor = [ConsoleColor]::Cyan
$global:GitPromptSettings.BeforeBackgroundColor = $Host.UI.RawUI.BackgroundColor

$global:GitPromptSettings.AfterText            = ']'
$global:GitPromptSettings.AfterForegroundColor = [ConsoleColor]::Cyan
$global:GitPromptSettings.AfterBackgroundColor = $Host.UI.RawUI.BackgroundColor

$global:GitPromptSettings.BranchForegroundColor = [ConsoleColor]::Green
$global:GitPromptSettings.BranchBackgroundColor = $Host.UI.RawUI.BackgroundColor

$global:GitPromptSettings.BranchAheadStatusSymbol          = [char]0x2191 # Up arrow
$global:GitPromptSettings.BranchAheadStatusForegroundColor = [ConsoleColor]::Green
$global:GitPromptSettings.BranchAheadStatusBackgroundColor = $Host.UI.RawUI.BackgroundColor

$global:GitPromptSettings.BranchBehindStatusSymbol          = [char]0x2193 # Down arrow
$global:GitPromptSettings.BranchBehindStatusForegroundColor = [ConsoleColor]::Red
$global:GitPromptSettings.BranchBehindStatusBackgroundColor = $Host.UI.RawUI.BackgroundColor

$global:GitPromptSettings.BranchBehindAndAheadStatusSymbol          = [char]0x2195 # Up & Down arrow
$global:GitPromptSettings.BranchBehindAndAheadStatusForegroundColor = [ConsoleColor]::Purple
$global:GitPromptSettings.BranchBehindAndAheadStatusBackgroundColor = $Host.UI.RawUI.BackgroundColor

#                                 PROMPT                                  {{{1
# ============================================================================

function Prompt {
  $realLASTEXITCODE = $LASTEXITCODE

  Write-Host ("`n[") -nonewline -foregroundcolor Cyan
  Write-Host (Get-Date -format HH:mm) -nonewline -foregroundcolor Gray
  Write-Host ("]") -nonewline -foregroundcolor Cyan
  # Posh-Git status
  Write-VcsStatus
  Write-Host (" $PWD") -nonewline -foregroundcolor Blue
  Write-Host ("`n$") -nonewline -foregroundcolor White

  $global:LASTEXITCODE = $realLASTEXITCODE
  return " ";
}
